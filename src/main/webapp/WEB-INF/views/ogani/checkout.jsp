<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<s:csrfMetaTags/>
<title>Ogani</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

<!-- Css Styles -->
<link rel="stylesheet" href="/resources/ogani/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="/resources/ogani/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="/resources/ogani/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="/resources/ogani/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="/resources/ogani/css/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="/resources/ogani/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="/resources/ogani/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="/resources/ogani/css/style.css" type="text/css">

<!-- Js Plugins -->
<script defer src="/resources/ogani/js/jquery-3.3.1.min.js"></script>
<script defer src="/resources/ogani/js/bootstrap.min.js"></script>
<script defer src="/resources/ogani/js/jquery.nice-select.min.js"></script>
<script defer src="/resources/ogani/js/jquery-ui.min.js"></script>
<script defer src="/resources/ogani/js/jquery.slicknav.js"></script>
<script defer src="/resources/ogani/js/mixitup.min.js"></script>
<script defer src="/resources/ogani/js/owl.carousel.min.js"></script>
<script defer src="/resources/ogani/js/main.js"></script>
<script defer src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script defer src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body class="_checkout">
  
  <jsp:include page="/WEB-INF/templates/ogani/header.jsp" />
  <s:authentication var="principal" property="principal"/>
  
  <!-- Breadcrumb Section Begin -->
  <section class="breadcrumb-section set-bg" data-setbg="/resources/ogani/img/breadcrumb.jpg">
    <div class="container">
      <div class="row">
        <div class="col-lg-12 text-center">
          <div class="breadcrumb__text">
            <h2>Checkout</h2>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Breadcrumb Section End -->

  <!-- Checkout Section Begin -->
  <section class="checkout spad">
    <div class="container">
      <div class="checkout__form">
        <h4>구매 정보</h4>
          <div class="row">
            <div class="col-lg-8 col-md-6">
              <div class="row">
                <div class="col-lg-3 mt-2">
                  <p>구매자 이름</p>
                </div>
                <div class="col-lg-6">
                  <div class="checkout__input">
                    <input type="text" id="checkout-cust_name" value="${principal.cust_name}">
                    <div style="position: relative; top: 8px;">
                      <small id="vc-cust_name"></small>
                    </div>
                  </div>
                </div>
              </div>
              <div class="checkout__input">
                <div class="row mt-4">
                  <div class="col-lg-3 mt-2">
                    <p>주소</p>
                  </div>
                  <div class="col-lg-3">
                    <input type="text" class="checkout__input__add" id="sample3_postcode" value="${cust_address[0]}" name="cust_address1" readonly>
                  </div>
                  <div class="col-lg-3">
                    <button type="button" class="btn bg-ogani text-white" onclick="sample3_execDaumPostcode()">우편번호 찾기</button> 
                  </div>
                </div>
                <div class="row">
                  <div class="col-lg-9">
                    <input type="text" class="checkout__input__add pr-0" id="sample3_address" value="${cust_address[1]}" name="cust_address2" readonly>
                  </div>
                </div>
                <div class="row">
                  <div class="col-lg-5">
                    <input type="text" class="checkout__input__add" id="sample3_detailAddress" value="${cust_address[2]}" name="cust_address3">
                  </div>
                  <div class="col-lg-4">
                    <input type="text" class="checkout__input__add" id="sample3_extraAddress" value="${cust_address[3]}" name="cust_address4">
                  </div>
                  <div class="col-lg-9" style="position: relative; bottom: 4px;">
                    <small id="vc-cust_address"></small>
                  </div>
                </div>
              </div>
              <div class="col-lg-9 mb-5 p-0">
                <div id="wrap" style="display: none; border: 1px solid; min-height: 500px; margin: 5px 0; position: relative">
                  <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" 
                       style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1" onclick="foldDaumPostcode()" alt="접기 버튼">
                </div>
              </div>
              <div class="row">
                <div class="col-lg-3 mt-2">
                  <p>연락처</p>
                </div>
                <div class="col-lg-6">
                  <div class="checkout__input">
                    <input type="text" id="checkout-cust_phone" value="${principal.cust_phone}">
                  </div>
                  <div style="position: relative; bottom: 16px;">
                    <small id="vc-cust_phone"></small>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col-lg-3 mt-2">
                  <p>이메일 주소</p>
                </div>
                <div class="col-lg-6">
                  <div class="checkout__input">
                    <input type="text" id="checkout-cust_email" value="${principal.cust_email}">
                  </div>
                  <div style="position: relative; bottom: 16px;">
                    <small id="vc-cust_email"></small>
                  </div>
                </div>
              </div>
              <div class="checkout__input__checkbox">
                <label for="diff-acc"> 이 정보를 기본 회원 정보로 저장합니다. <input type="checkbox" id="diff-acc" name="save-request">
                  <span class="checkmark"></span>
                </label>
              </div>
              <div class="row">
                <div class="col-lg-3 mt-2">
                  <p>비밀번호 확인</p>
                </div>
                <div class="col-lg-6">
                  <div class="checkout__input">
                    <input type="password" id="checkout-cust_password">
                    <input type="hidden" id="checkout-cust_no" value="${principal.cust_no}">
                  </div>
                  <div style="position: relative; bottom: 16px;">
                    <small id="vc-cust_password"></small>
                  </div>
                </div>
              </div>
              <p>주문 요청 사항</p>
              <div class="row">
                <div class="col-lg-9 checkout-textarea">
                  <textarea class="form-control" id="order_request"></textarea>
                </div>
              </div>
            </div>
            <div class="col-lg-4 col-md-6">
              <div class="checkout__order mb-1">
                <h4>Your Order</h4>
                <div class="checkout__order__products">
                  Products <span>Total</span>
                </div>
                <ul class="checkout-list" data-checkout="${fn:length(checkout)}">
                  <c:forEach var="checkout" items="${checkout}">
                    <li data-checkout="${checkout.prod_name}">
                      ${checkout.prod_name} * ${checkout.cart_quantity} 
                      <span><fmt:formatNumber value="${checkout.prod_price * checkout.cart_quantity}" type="currency"/></span>
                    </li>
                    <input type="hidden" value="${checkout.cart_no}" name="cart_no">
                  </c:forEach>
                </ul>
                <div class="checkout__order__total">
                  Total 
                  <span>
                    <c:set var="totalPrice"/>
                    <c:forEach var="checkout" items="${checkout}">
                      <c:set var="checkoutPrice" value="${checkout.prod_price * checkout.cart_quantity}"/>
                      <c:set var="totalPrice" value="${totalPrice + checkoutPrice}"/>
                    </c:forEach>
                    <fmt:formatNumber value="${totalPrice}" type="currency"/>
                  </span>
                </div>
                <p>Lorem ipsum dolor sit amet, consectetur adip elit, sed do eiusmod tempor incididunt ut labore et
                  dolore magna aliqua.</p>
                <button type="submit" class="site-btn place-order lead">주문하기</button>
              </div>
            </div>
          </div>
      </div>
    </div>
  </section>
  <!-- Checkout Section End -->

  <!-- CheckoutFailModal -->
  <div class="modal fade" id="checkoutFailModal" tabindex="-1" role="dialog" aria-labelledby="checkoutFailModalTitle" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="checkoutFailModalTitle">결제 실패</h5>
        </div>
        <div class="modal-body">
          결제에 실패하였습니다.
          <p class="lead p-0 mt-5 text-danger">사유 : <span class="error_msg"></span></p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />

</body>
</html>