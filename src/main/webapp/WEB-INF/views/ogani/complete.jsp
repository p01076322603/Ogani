<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">

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
</head>
<body>

  <jsp:include page="/WEB-INF/templates/ogani/header.jsp" />
  
  <div class="login-form my-5">
    <form>
      <div class="avatar">
        <i class="fa fa-check fa-4x"></i>
      </div>
      <p class="lead text-center">주문이 접수되었습니다.</p>
      <div class="form-group">
        <p><strong>주문 번호</strong> : ${order.order_uid}</p>
      </div>
      <div class="form-group">
        <p><strong>주문 품목</strong> : ${order.order_name}</p>
      </div>
      <div class="form-group">
        <p><strong>결제 금액</strong> : <fmt:formatNumber value="${order.order_price}" type="currency"/></p>
      </div>
      <div class="form-group mb-5">
        <p><strong>배송지</strong> : <br>${order.order_postcode}，${order.order_address}</p>
      </div>
      <a href="/"><input type="button" class="btn btn-primary btn-block btn-lg" value="Home"></a>
    </form>
  </div>

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />
  
</body>
</html>