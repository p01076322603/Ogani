<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<s:csrfMetaTags/>
<title>Ogani | Template</title>

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
<script defer src="/resources/ogani/js/jquery.number.min.js"></script>
<script defer src="/resources/ogani/js/mixitup.min.js"></script>
<script defer src="/resources/ogani/js/owl.carousel.min.js"></script>
<script defer src="/resources/ogani/js/main.js"></script>
</head>

<body>
  
  <jsp:include page="/WEB-INF/templates/ogani/header.jsp" />
  <c:set var="uploadLoc" value="/resources/upload/"/>

  <!-- Breadcrumb Section Begin -->
  <section class="breadcrumb-section set-bg" data-setbg="/resources/ogani/img/breadcrumb.jpg">
    <div class="container">
      <div class="row">
        <div class="col-lg-12 text-center">
          <div class="breadcrumb__text">
            <h2>Shopping Cart</h2>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Breadcrumb Section End -->

  <!-- Shoping Cart Section Begin -->
  <section class="shoping-cart spad">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="shoping__cart__table">
            <table>
              <thead>
                <tr>
                  <th class="shoping__product">Products</th>
                  <th>Price</th>
                  <th>Quantity</th>
                  <th>Total</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="cart" items="${cartDetailList}">
                  <tr class="cartDetails">
                    <td class="shoping__cart__item">
                      <img class="rounded" width="100px" height="80px" src="${uploadLoc}${cart.imagePath}" alt="" style="object-fit: cover;">
                      <h5 class="cart-prod_name"><c:out value="${cart.prod_name}"/></h5>
                    </td>
                    <td class="shoping__cart__price" data-cart="${cart.prod_price}"><fmt:formatNumber value="${cart.prod_price}" type="currency"/></td>
                    <td class="shoping__cart__quantity">
                      <div class="quantity">
                        <div class="pro-qty" data-cart="${cart.cart_no}">
                          <input type="text" value="${cart.cart_quantity}" name="cart_quantity" readonly>
                        </div>
                      </div>
                    </td>
                    <td class="shoping__cart__total" style="position: relative; bottom: 3px; right: 5px;"><fmt:formatNumber value="${cart.prod_price * cart.cart_quantity}" type="currency"/></td>
                    <td class="shoping__cart__item__close"><span class="icon_close" data-cart="${cart.cart_no}"></span></td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </div>
      <c:if test="${empty cartDetailList}">
        <p class="text-center lead">장바구니가 비어있습니다.</p>
      </c:if>
        <p class="cart-empty text-center lead"></p>
      <div class="row">
        <div class="col-lg-6 offset-lg-6">
          <div class="shoping__checkout">
            <h5>Cart Total</h5>
            <ul>
              <li>
                Total 
                <span class="cart_total">
                  <c:set var="totalPrice"/>
                  <c:forEach var="cart" items="${cartDetailList}">
                    <c:set var="cartPrice" value="${cart.prod_price * cart.cart_quantity}"/>
                    <c:set var="totalPrice" value="${totalPrice + cartPrice}"/>
                  </c:forEach>
                  <fmt:formatNumber value="${totalPrice == 0 ? '0' : totalPrice}" type="currency"/>
                </span>
              </li>
            </ul>
            <a href="javascript:void(0);" class="checkout-submit primary-btn lead">장바구니 구매</a>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Shoping Cart Section End -->

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />

</body>
</html>