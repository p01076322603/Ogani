package com.ogani.controller;

import java.util.Collection;
import java.util.Map;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ogani.domain.CustomerDTO;
import com.ogani.service.MemberService;

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
	
	@GetMapping
	public String memberInfo() {
		log.trace("memberInfo() GET");

		return "memberInfo";
	}

	@GetMapping("/modify")
	public String memberModifyForm(@AuthenticationPrincipal CustomerDTO customer, Model model) {
		log.trace("memberModifyForm() GET");
		log.debug("memberModifyForm( {} )", customer);
		
		String[] address = customer.getCust_address().split("，");
		model.addAttribute("address", address);
		
		return "memberModify";
	}

	@PostMapping("/modify")
	public String memberModify(@RequestParam() Map<String, String> paramMap, RedirectAttributes redirectAttr) {
		log.trace("memberModify() POST");
		log.debug("memberModify( paramMap = {} )", paramMap);

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
}
