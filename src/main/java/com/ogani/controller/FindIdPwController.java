package com.ogani.controller;

import java.io.UnsupportedEncodingException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ogani.config.PathCollections;
import com.ogani.domain.CustomerDTO;
import com.ogani.domain.EmailConfirmDTO;
import com.ogani.service.MemberService;
import com.ogani.util.MailUtils;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/findidpw")
@RequiredArgsConstructor
public class FindIdPwController {

	private final MemberService memberService;
	private final JavaMailSender mailSender;
	private final PasswordEncoder passwordEncoder;
	
	@GetMapping
	public String findIdPw() {
		return "ogani/findIdPw";
	}
	
	@ResponseBody
	@PostMapping("/findid")
	public Map<String, Object> findId(@RequestBody String email) {

		List<CustomerDTO> customerList = memberService.getMemberByEmail(email);
		if (customerList.size() == 0) {
			return Collections.singletonMap("findIdResult", false);
		
		} else {
			customerList.forEach(customer -> {
				try {
					sendIdFindMail(customer);
				} catch (Exception e) { e.printStackTrace(); }
			});
		}
		
		return Collections.singletonMap("findIdResult", true);
}
	
	@ResponseBody
	@PostMapping("/findpw")
	public Map<String, Object> findPw(@RequestBody String idAndEmail) {
		
		Map<String, String> paramMap = Collections.emptyMap();
		try {
			paramMap = new ObjectMapper().readValue(idAndEmail, new TypeReference<Map<String, String>>(){});
		} catch (Exception e1) { e1.printStackTrace(); }
		
		CustomerDTO customer = memberService.getMemberByIdAndEmail(paramMap);
		log.debug("{}", customer);
		if (customer == null) {
			return Collections.singletonMap("findPwResult", false);

		} else {
			try {
				sendPwFindMail(customer);
			} catch (Exception e2) { e2.printStackTrace(); }
		}
		
		return Collections.singletonMap("findPwResult", true);
	}
	
	@GetMapping("/changepw")
	public String changePw(@ModelAttribute EmailConfirmDTO customerAuth, Model model) {

		boolean emailAuthResult = false;
		if (customerAuth.getCust_email() != null && customerAuth.getCust_authkey() != null) {
			emailAuthResult = memberService.checkEmailAuth(customerAuth);
		}
		
		model.addAttribute("customerAuth", customerAuth);
		return emailAuthResult ? "ogani/changePw" : "redirect:/";
	}
	
	@PostMapping("/changepw")
	public String changePw(@RequestParam Map<String, String> idPasswordAuthkey, 
						   RedirectAttributes redirectAttr) {

		String encodedPassword = passwordEncoder.encode(idPasswordAuthkey.get("cust_password"));
		idPasswordAuthkey.put("cust_password", encodedPassword);
		
		boolean updatePasswordResult = memberService.updatePassword(idPasswordAuthkey);
		redirectAttr.addFlashAttribute("updatePasswordResult", updatePasswordResult);
		return "redirect:/login";
	}
	
	private void sendIdFindMail(CustomerDTO customer) 
			throws MessagingException, UnsupportedEncodingException {
		
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("[Ogani] 아이디 찾기 결과");
		sendMail.setText(new StringBuffer()
					.append("<h1>[Ogani 아이디 찾기]</h1>")
					.append("<p>요청하신 아이디는 다음과 같습니다 : ")
					.append(customer.getCust_id()).append("</p>")
					.append("<a href='" + PathCollections.LOCALHOST + "/login")
					.append("' target='_blank'>로그인 페이지로 가기</a>")
					.toString());
		sendMail.setFrom("p01076322603@gmail.com ", "Ogani");
		sendMail.setTo(customer.getCust_email());
		sendMail.send();
	}

	private void sendPwFindMail(CustomerDTO customer) 
			throws MessagingException, UnsupportedEncodingException {

		MailUtils sendMail = new MailUtils(mailSender);
		
		sendMail.setSubject("[Ogani] 비밀번호 변경 링크");
		sendMail.setText(new StringBuffer()
				.append("<h1>[Ogani 비밀번호 변경]</h1>")
				.append("<p>요청하신 비밀번호 변경 페이지 입니다.</p>")
				.append("<a href='" + PathCollections.LOCALHOST + "/findidpw/changepw")
				.append("?cust_id=").append(customer.getCust_id())
				.append("&cust_email=").append(customer.getCust_email())
				.append("&cust_authkey=").append(customer.getCust_authkey())
				.append("' target='_blank'>비밀번호 변경 페이지로 가기</a>")
				.toString());
		sendMail.setFrom("p01076322603@gmail.com ", "Ogani");
		sendMail.setTo(customer.getCust_email());
		sendMail.send();
	}
	
}
