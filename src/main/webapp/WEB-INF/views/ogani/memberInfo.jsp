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
  <s:authentication var="principal" property="principal"/>
  
  <div class="container">
    <c:if test="${modifyResult eq true}">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        회원 정보가 수정되었습니다.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </c:if>
  </div>
  
  <div class="container">
    <div class="member-form">
      <div class="text-center">
        <h2>Member Info</h2>
      </div>
      <div class="row">
        <div class="col-lg-6">
          <div class="form-group row">
            <label class="col-form-label col-sm-4 col-12">아이디</label>
            <div class="col-sm-8 align-middle">
              <p><c:out value="${principal.cust_id}"/></p>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-form-label col-sm-4 col-12">이메일</label>
            <div class="col-sm-8 align-middle">
              <p><c:out value="${principal.cust_email}"/></p>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-form-label col-sm-4 col-12">핸드폰 번호</label>
            <div class="col-sm-8 align-middle">
              <p><c:out value="${principal.cust_phone}"/></p>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-form-label col-sm-4 col-12">가입일</label>
            <div class="col-sm-8 align-middle">
              <p><fmt:formatDate value="${principal.cust_regdate}" dateStyle="full"/></p>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-form-label col-sm-4 col-12">이전 로그인 시각</label>
            <div class="col-sm-8 align-middle">
              <p><fmt:formatDate value="${principal.cust_lastlogin}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
            </div>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="form-group row">
            <label class="col-form-label col-sm-4 col-12">이름</label>
            <div class="col-sm-8 align-middle">
              <p><c:out value="${principal.cust_name}"/></p>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-form-label col-sm-4 col-12">메일링 동의 여부</label>
            <div class="col-sm-8 align-middle">
              <p><c:out value="${principal.cust_mailing == 1 ? '동의합니다.' : '동의하지 않습니다.'}"/></p>
            </div>
          </div>
          <div class="form-group row">
            <label class="col-form-label col-sm-4 col-12">주소</label>
            <div class="col-sm-8 align-middle">
              <p><c:out value="${principal.cust_address}"/></p>
            </div>
          </div>
        </div>
      </div>
      <div class="d-flex justify-content-center">
        <a href="member/modify"><button class="btn text-white mx-2">수정하기</button></a>
        <a href="/"><button class="btn text-white mx-2">메인으로</button></a>
      </div>
    </div>
  </div>

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />
</body>
</html>