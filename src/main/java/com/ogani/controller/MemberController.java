package com.ogani.controller;

import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ogani.domain.CustomerDTO;
import com.ogani.domain.OrderDTO;
import com.ogani.service.MemberService;
import com.ogani.service.OrderService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@Secured("ROLE_USER")
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {

	private final MemberService memberService;
	private final PasswordEncoder passwordEncoder;
	private final OrderService orderService;
	
	@GetMapping
	public String memberInfo(@AuthenticationPrincipal CustomerDTO customer, Model model) {

		List<OrderDTO> orderList = orderService.getOrderByCustNo(customer.getCust_no());
		model.addAttribute("orderList", orderList);
		
		return "ogani/memberInfo";
	}

	@GetMapping("/modify")
	public String memberModifyForm(@AuthenticationPrincipal CustomerDTO customer, Model model) {
		
		if (customer.getCust_address() != null) {
			String[] address = customer.getCust_address().split("，");
			model.addAttribute("address", address);
		}
		
		return "ogani/memberModify";
	}

	@PostMapping("/modify")
	public String memberModify(@RequestParam Map<String, String> paramMap, RedirectAttributes redirectAttr) {

		// 필수 항목
		CustomerDTO newCustomerInfo = CustomerDTO.builder()
				.cust_no     (Integer.parseInt(paramMap.get("cust_no")))
				.cust_mailing(Integer.parseInt(paramMap.get("cust_mailing")))
				.cust_email  (paramMap.get("cust_email"))
				.cust_phone  (paramMap.get("cust_phone"))
				.build();
		
		// 선택 항목
		String newPassword = paramMap.get("cust_new_password");
		newCustomerInfo.setCust_password(newPassword.length() > 0 ? passwordEncoder.encode(newPassword) : "");
		
		newCustomerInfo.setCust_name(paramMap.get("cust_name"));

		String newAddressPostcode = paramMap.get("cust_address1");
		if (newAddressPostcode.length() == 0) {
			newCustomerInfo.setCust_address("");
		
		} else {
			StringBuilder addressBuilder = new StringBuilder();
			
			String address = addressBuilder
					.append(paramMap.get("cust_address1")).append("，")
				    .append(paramMap.get("cust_address2")).append(paramMap.get("cust_address3").length() > 0 ? "，" : "")
				    .append(paramMap.get("cust_address3")).append(paramMap.get("cust_address4").length() > 0 ? "，" : "")
				    .append(paramMap.get("cust_address4")).toString();
			
			newCustomerInfo.setCust_address(address);
		}
		
		log.debug("newCustomerInfo = {}", newCustomerInfo);
		
		// 새로운 고객 정보로 토큰 갱신
		CustomerDTO modifiedCustomer = memberService.modifyMember(newCustomerInfo);
		
		if (modifiedCustomer == null) {
			redirectAttr.addFlashAttribute("modifyResult", false);
			
			return "redirect:/member";
		}
		
		String modifiedPassword = modifiedCustomer.getCust_password();
		modifiedCustomer.setCust_password("[PROTECTED]");
		
		Collection<? extends GrantedAuthority> authorities = 
				SecurityContextHolder.getContext().getAuthentication().getAuthorities();

		log.debug("modifiedCustomer = {}", modifiedCustomer);
		
		SecurityContextHolder.getContext()
				.setAuthentication(new UsernamePasswordAuthenticationToken(modifiedCustomer, modifiedPassword, authorities));
		
		// 결과 전송
		redirectAttr.addFlashAttribute("modifyResult", true);
		
		return "redirect:/member";
	}
	
	@ResponseBody
	@PostMapping("/modify/passwordcheck")
	public Map<String, Object> passwordCheck(@RequestBody Map<String, String> validateInfo) { 
		
		CustomerDTO customer = memberService.getMemberByNo(Integer.parseInt(validateInfo.get("cust_no")));
		boolean result = passwordEncoder.matches(validateInfo.get("cust_password"), customer.getCust_password());
		log.debug("passwordCheck result = {}", result);
		
		return Collections.singletonMap("checkResult", result == true ? 1 : 0);
	}

	@PostMapping("/modify/leave")
	public String memberLeave(@RequestParam int cust_no, RedirectAttributes redirectAttr,
							  HttpServletRequest request, HttpServletResponse response) {
		
		boolean leaveResult = memberService.leaveMember(cust_no);
		log.debug("memberLeave result = {}", leaveResult);
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if (auth != null) { 
			new SecurityContextLogoutHandler().logout(request, response, auth); 
		}
		
		if (leaveResult) {
			redirectAttr.addFlashAttribute("leaveResult", leaveResult);
		}
		
		return "redirect:/";
	}
}
