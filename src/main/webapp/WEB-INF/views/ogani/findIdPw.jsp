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
<body class="find-id-pw">

  <jsp:include page="/WEB-INF/templates/ogani/header.jsp" />
  
  <div class="row">
    <div class="col-xl-3 offset-xl-3 col-lg-4 offset-lg-2">
      <div class="login-form">
        <form name="idfind">
          <div class="avatar">
            <i class="fa fa-user-times fa-4x" aria-hidden="true"></i>
          </div>
          <p class="lead text-center">아이디 찾기</p>
          <div class="idfind-info text-center">
            <p style="min-height: 30px;">회원가입 시에 등록한 이메일로<br> 아이디를 전송합니다.</p>
          </div>
          <div class="form-group" style="margin-bottom: 68px;">
            <input type="email" class="form-control" id="idfind-email" placeholder="이메일" maxlength="255">
          </div>
          <div style="min-height: 30px">
            <small id="idfind-result" class="text-danger" style="position: relative; bottom: 8px;"></small>
          </div>
          <input type="button" id="idfind-submit" class="btn btn-primary btn-block btn-lg" value="아이디 찾기">
          <s:csrfInput/>
        </form>
      </div>
    </div>
    <div class="col-xl-3 col-lg-4">
      <div class="login-form">
        <form name="pwfind">
          <div class="avatar">
            <i class="fa fa-key fa-4x" aria-hidden="true"></i>
          </div>
          <p class="lead text-center">비밀번호 찾기</p>
          <div class="find-id-info text-center">
            <p style="min-height: 30px;">회원가입 시에 등록한 이메일로<br> 비밀번호 변경 링크를 전송합니다.</p>
          </div>
          <div class="form-group mb-2">
            <input type="text" class="form-control" id="pwfind-id" placeholder="아이디" maxlength="20">
          </div>
          <div class="form-group">
            <input type="email" class="form-control" id="pwfind-email" placeholder="이메일" maxlength="255">
          </div>
          <div style="min-height: 30px">
            <small id="pwfind-result" class="text-danger" style="position: relative; bottom: 8px;"></small>
          </div>
          <input type="button" id="pwfind-submit" class="btn btn-primary btn-block btn-lg" value="비밀번호 찾기">
        </form>
      </div>
    </div>
  </div>
  <div class="text-center lead">
    <p>계정이 없으신가요? <a href="register" class="text-ogani">회원가입</a></p>
  </div>

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />
</body>
</html>