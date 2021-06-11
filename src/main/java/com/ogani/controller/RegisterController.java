package com.ogani.controller;

import java.io.UnsupportedEncodingException;
import java.util.Collections;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ogani.config.PathCollections;
import com.ogani.domain.CustomerDTO;
import com.ogani.domain.EmailConfirmDTO;
import com.ogani.service.AdminService;
import com.ogani.service.MemberService;
import com.ogani.util.MailUtils;
import com.ogani.util.TempKey;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/register")
@RequiredArgsConstructor
public class RegisterController {

	private final PasswordEncoder passwordEncoder;
	private final MemberService memberService;
	private final AdminService adminService;
	private final JavaMailSender mailSender;
	
	@GetMapping
	public String registerForm() {
		return "ogani/register";
	}
	
	@PostMapping
	public String register(@ModelAttribute CustomerDTO customer, RedirectAttributes redirectAttr) {

		String id    = customer.getCust_id().toLowerCase(); 
		String email = customer.getCust_email().toLowerCase();
		String encodedPassword = passwordEncoder.encode(customer.getCust_password());
		
		customer.setCust_id(id);
		customer.setCust_email(email);
		customer.setCust_password(encodedPassword);
		customer.setCust_authkey(new TempKey().getKey(40, false));
		
		boolean registerResult = memberService.registerMember(customer);
		
		if (registerResult) {
			
			try {
				sendAuthMail(customer);
			} catch (Exception e) { e.printStackTrace(); }
		
			log.debug("register result = {}, {}", registerResult, email);
			redirectAttr.addFlashAttribute("registerEmail", email);
		}
		return "redirect:/login";
	}
	
	private void sendAuthMail(CustomerDTO customer) 
			throws MessagingException, UnsupportedEncodingException {
		
		MailUtils sendMail = new MailUtils(mailSender);

		sendMail.setSubject("[Ogani] 회원가입 이메일 인증");
		sendMail.setText(new StringBuffer()
					.append("<h1>[Ogani 이메일 인증]</h1>")
					.append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
					.append("<a href='" + PathCollections.LOCALHOST + "/register/emailConfirm")
					.append("?cust_id=").append(customer.getCust_id())
					.append("&cust_email=").append(customer.getCust_email())
					.append("&cust_authkey=").append(customer.getCust_authkey())
					.append("' target='_blank'>이메일 인증 확인</a>")
					.toString());
		sendMail.setFrom("p01076322603@gmail.com ", "Ogani");
		sendMail.setTo(customer.getCust_email());
		sendMail.send();
	}

	@ResponseBody
	@PostMapping("/idcheck")
	public Map<String, Object> validateDuplicateMember(@RequestBody String id) {
		
					 int result = memberService.getMemberById(id) == null ? 0 : 1;
		if (result == 0) result = adminService.getAdminById(id)   == null ? 0 : 1;
		log.debug("validateDuplicateMember result = {}", result);
		
		return Collections.singletonMap("checkResult", result);
	}
	
	@GetMapping("/emailConfirm")
	public String emailConfirm(@ModelAttribute EmailConfirmDTO customerAuth, 
							   Model model, RedirectAttributes redirectAttr) {

		boolean emailAuthResult = memberService.checkEmailAuth(customerAuth);
		redirectAttr.addFlashAttribute("emailAuthResult", emailAuthResult);
		
		return "redirect:/login";
	}
}
