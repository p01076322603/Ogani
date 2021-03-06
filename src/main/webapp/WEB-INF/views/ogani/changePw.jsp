<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<s:authorize access="isAuthenticated()">
  <% response.sendRedirect("/member"); %>
</s:authorize>

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
<body class="changepw">

  <jsp:include page="/WEB-INF/templates/ogani/header.jsp" />
  
  <div class="login-form">
    <form action="/findidpw/changepw" method="post" name="pwfind">
      <div class="avatar">
        <i class="fa fa-key fa-4x" aria-hidden="true"></i>
      </div>
      <p class="lead text-center">???????????? ??????</p>
      <div class="changepw-info text-center">
        <p>??????????????? 6?????? ?????? 30??????<br> ?????? ????????? ????????? <br>????????? ???????????? ?????????.</p>
      </div>
      <div class="form-group mb-2">
        <input type="password" class="form-control" id="pwchange-new-password" name="cust_password" placeholder="??? ????????????" maxlength="30">
      </div>
      <div class="form-group">
        <input type="password" class="form-control" id="pwchange-new-password-confirm" placeholder="??? ???????????? ??????" maxlength="30">
      </div>
        <input type="hidden" value="${customerAuth.cust_id}" name="cust_id">
        <input type="hidden" value="${customerAuth.cust_authkey}" name="cust_authkey">
      <div style="min-height: 30px">
        <small id="changepw-result" class="text-danger" style="position: relative; bottom: 8px;"></small>
      </div>
      <input type="button" id="changepw-submit" class="btn btn-primary btn-block btn-lg" value="???????????? ??????">
      <s:csrfInput/>
    </form>
  </div>

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />
</body>
</html>