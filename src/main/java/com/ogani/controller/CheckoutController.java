package com.ogani.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ogani.domain.CartDTO;
import com.ogani.domain.CheckoutDTO;
import com.ogani.domain.CustomerDTO;
import com.ogani.domain.OrderDTO;
import com.ogani.domain.OrderDetailDTO;
import com.ogani.domain.ProductDTO;
import com.ogani.service.CartService;
import com.ogani.service.MemberService;
import com.ogani.service.OrderService;
import com.ogani.service.ProductService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@Secured("ROLE_USER")
@RequestMapping("/checkout")
@RequiredArgsConstructor
public class CheckoutController {

	private final ProductService productService;
	private final CartService cartService;
	private final OrderService orderService;
	private final MemberService memberService;
	
	private IamportClient api = 
			new IamportClient("9651074284903334", "ZUP3YcgUPQ1SDr8wW4xiqSHYEt3dm7Ol1DpZQGUFwWy9nGGjKdBb5j9KNdX9kMvlpUlgAfV6ctfzaVTV");
	
	@GetMapping
	public String checkout() {
		log.trace("checkout() GET");
		
		return "redirect:/cart";
	}
	
	@PostMapping
	@Transactional
	public String checkout(@AuthenticationPrincipal CustomerDTO customer,
						   @RequestParam List<Integer> cartList, Model model) {
		log.trace("checkout( {} ) POST", cartList);

		if (customer.getCust_address() != null) {
			String[] cust_address = customer.getCust_address().split("，");
			model.addAttribute("cust_address", cust_address);
		}
		
		List<CheckoutDTO> checkoutList = new ArrayList<>();
		
		cartList.forEach(cart_no -> {
			
			CartDTO cart = cartService.getCart(cart_no);
			ProductDTO product = productService.getProduct(cart.getProd_no());

			CheckoutDTO checkout = CheckoutDTO.builder()
					.cart_no(cart_no)
					.cart_quantity(cart.getCart_quantity())
					.prod_name(product.getProd_name())
					.prod_price(product.getProd_price())
					.build();
			
			checkoutList.add(checkout);
		});
		
		model.addAttribute("checkout", checkoutList);
		
		return "ogani/checkout";
	}
	
	@ResponseBody
	@Transactional
	@PostMapping("/validatePrice")
	public int validatePrice(@RequestBody String cartArray, @AuthenticationPrincipal CustomerDTO customer) {
		log.trace("validatePrice( {} )", cartArray);
		
		// 주문시 요청한 카트의 고유번호
		List<Integer> requestedCartList = Collections.emptyList();
		try {
			requestedCartList = new ObjectMapper().readValue(cartArray, new TypeReference<List<Integer>>(){});
		} catch (Exception e) { e.printStackTrace(); }
		log.debug("requestedCartList = {}", requestedCartList);
		
		// 사용자가 현재 가지고있는 카트의 번호
		List<CartDTO> customerCartDTOList = cartService.getCustomerCartList(customer.getCust_no());
		List<Integer> customerCartList = customerCartDTOList.stream()
				.map(cart -> cart.getCart_no())
				.collect(Collectors.toList());
		log.debug("customerCartList = {}", customerCartList);

		// 사용자가 가진 카트와 주문받은 카트를 비교하여 전부 포함관계인지 판단
		boolean illegalCartMatch = requestedCartList.stream()
				.filter(cart_no -> customerCartList.contains(cart_no) == false)
				.findAny().isPresent();

		if (illegalCartMatch) return 0;

		int totalPrice = customerCartDTOList.stream()
				.mapToInt(cart -> productService.getProduct(cart.getProd_no()).getProd_price() * cart.getCart_quantity())
				.sum();
		log.debug("totalPrice = {}", totalPrice);
		
		return totalPrice;
	}
	
	@ResponseBody
	@PostMapping("/verifyCheckout/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(@PathVariable String imp_uid) 
			throws IamportResponseException, IOException {
		log.debug("paymentByImpUid( imp_uid = {} )", imp_uid);
		
		return api.paymentByImpUid(imp_uid);
	}
	
	// TODO: rest방식으로 변경하여 result 분기시켜 성공 / 실패 구분하기
	@Transactional
	@PostMapping("/complete")
	public void checkoutComplete(@ModelAttribute OrderDTO order, @RequestParam List<Integer> cartList,
								   @RequestParam int save_request, Model model,
								   @AuthenticationPrincipal CustomerDTO customer) {
		log.debug("checkoutComplete( {}, {} ) POST", order, cartList);
		log.debug("checkoutComplete( save_request = {} ) POST", save_request);
		
		int cust_no = customer.getCust_no();
		String order_uid = order.getOrder_uid();

		order.setCust_no(cust_no);
		
		List<OrderDetailDTO> orderDetailList = new ArrayList<>();
		
		cartList.forEach(cart_no -> {
			CartDTO cart = cartService.getCart(cart_no);
			
			OrderDetailDTO orderDetail = OrderDetailDTO.builder()
					.order_uid(order_uid)
					.order_detail_quantity(cart.getCart_quantity())
					.prod_no(cart.getProd_no())
					.build();
			orderDetailList.add(orderDetail);
			
			cartService.removeCart(cart_no);
		});
		order.setOrderDetailList(orderDetailList);
		
		boolean result = orderService.registerOrder(order);
		log.debug("registerOrder result = {}", result);
		
		if (save_request == 1) {
			String cust_address = order.getOrder_postcode() + "，" 
								+ order.getOrder_address();
			
			CustomerDTO requestedCustomer = CustomerDTO.builder()
					.cust_no(cust_no)
					.cust_mailing(customer.getCust_mailing())
					.cust_name(order.getOrder_buyer())
					.cust_phone(order.getOrder_phone())
					.cust_email(order.getOrder_email())
					.cust_address(cust_address)
					.build();
			log.debug("{}", requestedCustomer);
			CustomerDTO modifiedCustomer = memberService.modifyMember(requestedCustomer);
			
			String modifiedPassword = modifiedCustomer.getCust_password();
			modifiedCustomer.setCust_password("[PROTECTED]");
			
			Collection<? extends GrantedAuthority> authorities = 
					SecurityContextHolder.getContext().getAuthentication().getAuthorities();

			log.debug("modifiedCustomer = {}", modifiedCustomer);
			
			SecurityContextHolder.getContext()
					.setAuthentication(new UsernamePasswordAuthenticationToken(modifiedCustomer, modifiedPassword, authorities));
		}
		
	}
	
	@GetMapping("/complete")
	public String checkoutComplete(@RequestParam String imp_uid, @RequestParam String merchant_uid, Model model) {
		log.debug("checkoutComplete( imp_uid = {}, merchant_uid = {} ) GET", imp_uid, merchant_uid);

		OrderDTO order = orderService.getOrder(merchant_uid);

		model.addAttribute("order", order);
		return "ogani/complete";
	}
}