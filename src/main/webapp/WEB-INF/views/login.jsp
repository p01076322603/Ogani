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
<title>Ogani</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Cairo:wght@200;300;400;600;900&display=swap" rel="stylesheet">

<!-- Css Styles -->
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" type="text/css">
<link rel="stylesheet" href="../resources/css/font-awesome.min.css" type="text/css">
<link rel="stylesheet" href="../resources/css/elegant-icons.css" type="text/css">
<link rel="stylesheet" href="../resources/css/nice-select.css" type="text/css">
<link rel="stylesheet" href="../resources/css/jquery-ui.min.css" type="text/css">
<link rel="stylesheet" href="../resources/css/owl.carousel.min.css" type="text/css">
<link rel="stylesheet" href="../resources/css/slicknav.min.css" type="text/css">
<link rel="stylesheet" href="../resources/css/style.css" type="text/css">

<!-- Js Plugins -->
<script defer src="../resources/js/jquery-3.3.1.min.js"></script>
<script defer src="../resources/js/bootstrap.min.js"></script>
<script defer src="../resources/js/jquery.nice-select.min.js"></script>
<script defer src="../resources/js/jquery-ui.min.js"></script>
<script defer src="../resources/js/jquery.slicknav.js"></script>
<script defer src="../resources/js/mixitup.min.js"></script>
<script defer src="../resources/js/owl.carousel.min.js"></script>
<script defer src="../resources/js/main.js"></script>
</head>
<body>

  <jsp:include page="../templates/header.jsp" />

  <c:if test="${registerResult}">
    <div class="container">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <strong>회원가입을 환영합니다!</strong> 로그인 해주세요.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </div>
  </c:if>
  
  <div class="login-form my-5">
    <form action="/login" method="post">
      <div class="avatar">
        <i class="fa fa-user fa-4x"></i>
      </div>
      <h4 class="modal-title">Login to Your Account</h4>
      <div class="form-group">
        <input type="text" class="form-control" name="username" placeholder="Username" required="required">
      </div>
      <div class="form-group mb-1">
        <input type="password" class="form-control" name="password" placeholder="Password" required="required">
      </div>
      <div class="query-result">
        <small class="text-danger"></small>
      </div>
      <div class="form-group small clearfix">
        <label class="form-check-label"><input type="checkbox"> Remember me</label> <a href="#"
          class="forgot-link">Forgot Password?</a>
      </div>
      <input type="submit" class="btn btn-primary btn-block btn-lg" value="Login">
      <s:csrfInput/>
    </form>
    <div class="text-center lead">
      Don't have an account? <a href="register">Sign up</a>
    </div>
  </div>

  <jsp:include page="../templates/footer.jsp" />
</body>
</html>