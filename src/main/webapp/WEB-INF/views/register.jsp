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
    <form action="register" method="post" class="form-horizontal">
      <div class="text-center">
        <h2>Sign Up</h2>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">Username</label>
        <div class="col-sm-8 col-12">
          <input type="text" class="form-control" name="cust_id" required="required">
        </div>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">Password</label>
        <div class="col-sm-8 col-12">
          <input type="password" class="form-control" name="cust_password" required="required">
        </div>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">Confirm Password</label>
        <div class="col-sm-8 col-12">
          <input type="password" class="form-control" name="cust_confirm_password" required="required">
        </div>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">Email Address</label>
        <div class="col-sm-8 col-12">
          <input type="email" class="form-control" name="cust_email" required="required">
        </div>
      </div>
      <div class="form-group row">
        <label class="col-form-label col-sm-4 col-12">Phone</label>
        <div class="col-sm-8 col-12">
          <input type="text" class="form-control" name="cust_phone" required="required">
        </div>
      </div>
      <div class="form-group row">
        <div class="col-8 offset-2 text-center">
          <p>
            <label class="form-check-label"><input type="checkbox" required="required"> I accept the <a href="#">Terms of Use</a> &amp; <a href="#">Privacy Policy</a>.</label>
          </p>
          <button type="submit" class="btn btn-lg text-white">Sign Up</button>
        </div>
      </div>
      <s:csrfInput/>
    </form>
    <div class="text-center lead">
      Already have an account? <a href="login">Login here</a>
    </div>
  </div>

  <jsp:include page="../templates/footer.jsp" />
</body>
</html>