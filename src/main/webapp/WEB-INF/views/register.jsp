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
  
  <div class="signup-form">
    <form action="register" method="post" class="form-horizontal" onsubmit="return registerCheck();">
      <div class="text-center">
        <h2>Sign Up</h2>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">아이디</label>
        <div class="col-sm-8 col-12">
          <input type="text" class="form-control" id="signup-cust_id" name="cust_id" required="required">
        </div>
      </div>
      <div class="row" style="position: relative; bottom: 8px;">
        <small class="col-sm-8 offset-sm-4" id="v-cust_id">회원 ID는 6 ~ 20자 사이의 영문 + 숫자로 이루어져야 하며 영문으로 시작해야 합니다.</small>
      </div>
      <div class="row" style="position: relative; bottom: 8px;">
        <small class="col-sm-8 offset-sm-4 text-danger" id="v-cust_idcheck"></small>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">비밀번호</label>
        <div class="col-sm-8 col-12">
          <input type="password" class="form-control" id="signup-cust_password" name="cust_password" required="required">
        </div>
      </div>
      <div class="row" style="position: relative; bottom: 8px;">
        <small class="col-sm-8 offset-sm-4" id="v-cust_password">비밀번호는 6자리 이상 30자리 이하 영문과 숫자를 반드시 포함해야 합니다.</small>
      </div>
      <div class="row" style="position: relative; bottom: 8px;">
        <small><!-- 역할 X --></small>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">비밀번호 확인</label>
        <div class="col-sm-8 col-12">
          <input type="password" class="form-control" id="signup-cust_confirm_password" name="cust_confirm_password" required="required">
        </div>
      </div>
      <div class="row" style="position: relative; bottom: 8px;">
        <small class="col-sm-8 offset-sm-4 text-danger" id="v-cust_confirm_password"></small>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">이메일 주소</label>
        <div class="col-sm-8 col-12">
          <input type="email" class="form-control" id="signup-cust_email" name="cust_email" required="required">
        </div>
      </div>
      <div class="row" style="position: relative; bottom: 8px;">
        <small class="col-sm-8 offset-sm-4 text-danger" id="v-cust_email"></small>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">휴대전화</label>
        <div class="col-sm-8 col-12">
          <input type="text" class="form-control" id="signup-cust_phone" name="cust_phone" required="required">
        </div>
      </div>
      <div class="row" style="position: relative; bottom: 8px;">
        <small class="col-sm-8 offset-sm-4 text-danger" id="v-cust_phone"></small>
      </div>
      <div class="form-group row">
        <div class="col-10 offset-1 text-center">
          <p>
            <label class="form-check-label"><input type="checkbox" required="required"><a href="javascript:void(0);"> 이용 약관</a>을 확인 하였으며, 이에 동의합니다.</label>
          </p>
          <button type="submit" class="btn btn-lg text-white">회원 가입</button>
        </div>
      </div>
      <s:csrfInput/>
    </form>
    <div class="text-center lead">
      <p>이미 계정이 있으시다면 <a href="login">로그인</a></p>
    </div>
  </div>

  <jsp:include page="../templates/footer.jsp" />
</body>
</html>