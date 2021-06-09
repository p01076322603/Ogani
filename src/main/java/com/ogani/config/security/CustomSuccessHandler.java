package com.ogani.config.security;

import java.io.IOException;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ogani.domain.AdminDTO;
import com.ogani.domain.CustomerDTO;
import com.ogani.domain.adapter.AdminAdapter;
import com.ogani.domain.adapter.CustomerAdapter;
import com.ogani.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomSuccessHandler implements AuthenticationSuccessHandler {

	@Autowired
	private MemberService memberService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) 
			throws IOException, ServletException {

		
		Object principal = authentication.getPrincipal();

		Object[] authorities = authentication.getAuthorities().toArray();
		String[] authArray = Arrays.stream(authorities).map(Object::toString).toArray(String[]::new);
		
		boolean isCustomer = false;
		for (String auth : authArray) {
			if (auth.contains("ROLE_USER")) { isCustomer = true; }
		}
		RequestCache requestCache = new HttpSessionRequestCache();
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		String indexPage = request.getRequestURL().toString().replace(request.getRequestURI(), "");
		String adminIndexPage = indexPage + "/admin";
		String targetUrl = "";
		
		if (principal instanceof CustomerAdapter && isCustomer) {
			CustomerAdapter customerAdapter = (CustomerAdapter) authentication.getPrincipal();
			CustomerDTO customer = customerAdapter.getCustomer();
			
			customer.setCust_password("[PROTECTED]");
			
			customerAdapter.eraseCredentials();
			log.debug(customerAdapter.toString());
			log.debug(customer.toString());
			
			log.debug("Customer 로그인에 성공하였습니다.");
			
			SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken
					(customer, customerAdapter.getPassword(), // Password == null;
								Collections.singletonList(new SimpleGrantedAuthority("ROLE_USER"))));

			Date loginDate = memberService.updateLastLogin(customer.getCust_id());
			log.debug("loginDate = {}", loginDate);
			
			targetUrl = savedRequest == null ? indexPage : savedRequest.getRedirectUrl();

			HttpSession session = request.getSession();
			Integer prod_no = (Integer) session.getAttribute("return-to");
			if (prod_no != null) {
				targetUrl = indexPage + "/goods/" + prod_no;
				session.removeAttribute("return-to");
			}
		}
		
		else if (principal instanceof AdminAdapter && !isCustomer) {
			AdminAdapter adminAdapter = (AdminAdapter) authentication.getPrincipal();
			AdminDTO admin = adminAdapter.getAdmin();
			admin.setAdmin_password("[PROTECTED]");
			
			adminAdapter.eraseCredentials();
			log.debug(adminAdapter.toString());
			log.debug(admin.toString());
			
			SecurityContextHolder.getContext().setAuthentication(new UsernamePasswordAuthenticationToken
					(admin, adminAdapter.getPassword(), // Password == null;
								Collections.singletonList(new SimpleGrantedAuthority(admin.getAdmin_role()))));

			log.debug("Admin 로그인에 성공하였습니다.");
			
			targetUrl = savedRequest == null ? adminIndexPage : savedRequest.getRedirectUrl();
		}

		else { throw new IllegalStateException("조건을 충족하는 Table / Adapter를 찾지 못하였습니다."); }
		
		requestCache.removeRequest(request, response);
		log.debug("targetUrl = {}", targetUrl);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("targetUrl", targetUrl);
		paramMap.put("loginResult", 1);
		
		String loginResult = new ObjectMapper().writeValueAsString(paramMap);
		response.getWriter().print(loginResult);
	}
	
}