<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script defer src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

  <jsp:include page="../templates/header.jsp" />
  <s:authentication var="principal" property="principal"/>
  
  <div class="container">
    <div class="modify-form">
      <form action="modify" method="post">
        <div class="text-center">
          <h2>Member Modify</h2>
        </div>
        <div class="row">
          <div class="col-lg-6">
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">Username</label>
              <div class="col-sm-8">
                <p class="ml-2"><c:out value="${principal.cust_id}"/></p>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">Password</label>
              <div class="col-sm-8">
                <input type="password" class="form-control" name="cust_password" required="required">
              </div>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">Confirm Password</label>
              <div class="col-sm-8">
                <input type="password" class="form-control" name="cust_confirm_password" required="required">
              </div>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">Email Address</label>
              <div class="col-sm-8">
                <input type="email" class="form-control" name="cust_email" value="${principal.cust_email}">
              </div>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">Phone</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" name="cust_phone" value="${principal.cust_phone}">
              </div>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">Name</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" name="cust_name" value="${principal.cust_name}">
              </div>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">Mailing</label>
              <div class="mailing col-sm-8">
                <label><input type="radio" name="cust_mailing"><span class="mr-2"> 동의합니다.</span></label> 
                <label><input type="radio" name="cust_mailing"><span> 동의하지 않습니다.</span></label> 
              </div>
            </div>
            <div class="form-group form-address row mb-0">
              <label class="col-form-label col-sm-4 col-12">Address</label>
              <div class="col-sm-3 pr-0">
                <input type="text" class="form-control" id="sample3_postcode" name="cust_address1" readonly>
              </div>
              <button class="col-sm-4 btn btn-address text-white m-0 ml-auto" type="button" onclick="sample3_execDaumPostcode()">우편번호 찾기</button>
              <div class="col-sm-12 custom-margin">
                <input type="text" class="form-control" id="sample3_address" name="cust_address2" readonly>
              </div>
              <div class="col-sm-6 pr-1">
                <input type="text" class="form-control" id="sample3_detailAddress" name="cust_address3">
              </div>
              <div class="col-sm-6 pl-1">
                <input type="text" class="form-control" id="sample3_extraAddress" name="cust_address4">
              </div>
            </div>
          </div>
        </div>
        <s:csrfInput/>
      </form>
      <div class="col-lg-12 p-0">
        <div id="wrap" style="display: none; border: 1px solid; min-height: 500px; margin: 5px 0; position: relative">
          <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" 
               style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1" onclick="foldDaumPostcode()" alt="접기 버튼">
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="../templates/footer.jsp" />
</body>
</html>