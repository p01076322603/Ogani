<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<body>

  <jsp:include page="/WEB-INF/templates/ogani/header.jsp" />

  <c:if test="${not empty registerEmail}">
    <div class="container">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>회원가입을 환영합니다!</strong> ${registerEmail} 으로 인증 이메일이 발송되었습니다.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true"><i class="fa fa-times"></i></span>
        </button>
      </div>
    </div>
  </c:if>

  <c:if test="${emailAuthResult}">
    <div class="container">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>이메일이 인증되었습니다.</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true"><i class="fa fa-times"></i></span>
        </button>
      </div>
    </div>
  </c:if>
  
  <c:if test="${updatePasswordResult}">
    <div class="container">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>비밀번호가 변경되었습니다.</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true"><i class="fa fa-times"></i></span>
        </button>
      </div>
    </div>
  </c:if>
  
  <div class="login-form my-5">
    <form action="/login" method="post">
      <div class="avatar">
        <i class="fa fa-user fa-4x"></i>
      </div>
      <p class="lead text-center">로그인</p>
      <div class="form-group">
        <input type="text" class="form-control" id="username" name="username" placeholder="아이디" required="required" maxlength="20">
      </div>
      <div class="form-group mb-1">
        <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required="required" maxlength="30">
      </div>
      <div class="query-result">
        <small id="login-result" class="text-danger" style="min-height: 30px;"></small>
      </div>
      <div class="form-group small clearfix">
        <label class="form-check-label"><input type="checkbox"> 로그인 기억하기</label> 
        <a href="/findidpw" class="forgot-link">아이디 / 비밀번호 찾기</a>
      </div>
      <input type="button" id="login-submit" class="btn btn-primary btn-block btn-lg" value="Login">
      <s:csrfInput/>
    </form>
    <div class="text-center lead">
      <p>계정이 없으신가요? <a href="register">회원가입</a></p>
    </div>
  </div>

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />
</body>
</html>