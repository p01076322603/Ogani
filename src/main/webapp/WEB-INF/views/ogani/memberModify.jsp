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
<s:csrfMetaTags/>

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
<script defer src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>

  <jsp:include page="/WEB-INF/templates/ogani/header.jsp" />
  <s:authentication var="principal" property="principal"/>
  
  <div class="container">
    <div class="modify-form">
      <form action="modify" method="post" onsubmit="return modifyCheck();">
        <div class="text-center">
          <h2>Member Modify</h2>
        </div>
        <div class="form-group row mb-2">
          <div class="col-sm-4">
            <small class="text-danger" style="position: relative; top: 8px;">* : 필수 항목입니다.</small>
          </div>
          <label class="col-form-label col-sm-2 offset-sm-2 col-12">아이디</label>
          <div class="col-sm-4">
            <p class="ml-2 lead"><c:out value="${principal.cust_id}"/></p>
          </div>
        </div>
        <div class="row">
          <div class="col-lg-6">
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">비밀번호<span class="float-right">*</span></label>
              <div class="col-sm-8">
                <input type="password" class="form-control" id="modify-cust_password" name="cust_password" required="required" maxlength="30">
              </div>
            </div>
            <div class="row" style="position: relative; bottom: 8px;">
              <small class="col-sm-8 offset-sm-4 text-danger" id="vm-cust_password"></small>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">새 비밀번호</label>
              <div class="col-sm-8">
                <input type="password" class="form-control" id="modify-cust_new_password" name="cust_new_password" maxlength="30">
              </div>
            </div>
            <div class="row" style="position: relative; bottom: 8px;">
              <small class="col-sm-8 offset-sm-4" id="vm-cust_new_password">비밀번호는 6자리 이상 30자리 이하 영문과 숫자를 반드시 포함해야 합니다.</small>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">새 비밀번호 확인</label>
              <div class="col-sm-8">
                <input type="password" class="form-control" id="modify-cust_confirm_new_password" name="cust_confirm_new_password" maxlength="30">
              </div>
            </div>
            <div class="row" style="position: relative; bottom: 8px;">
              <small class="col-sm-8 offset-sm-4 text-danger" id="vm-cust_confirm_new_password"></small>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">이메일 주소<span class="float-right">*</span></label>
              <div class="col-sm-8">
                <input type="email" class="form-control" id="modify-cust_email" name="cust_email" value="${principal.cust_email}" required="required" maxlength="255">
              </div>
            </div>
            <div class="row" style="position: relative; bottom: 8px;">
              <small class="col-sm-8 offset-sm-4 text-danger" id="vm-cust_email"></small>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">휴대전화<span class="float-right">*</span></label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="modify-cust_phone" name="cust_phone" value="${principal.cust_phone}" required="required" maxlength="13">
              </div>
            </div>
            <div class="row" style="position: relative; bottom: 8px;">
              <small class="col-sm-8 offset-sm-4 text-danger" id="vm-cust_phone"></small>
            </div>
          </div>
          <div class="col-lg-6">
            <div class="form-group row">
              <label class="col-form-label col-sm-4 col-12">이름</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="modify-cust_name" name="cust_name" value="${principal.cust_name}" maxlength="20">
              </div>
            </div>
            <div class="row" style="position: relative; bottom: 8px;">
              <small class="col-sm-8 offset-sm-4 text-danger" id="vm-cust_name"></small>
            </div>
            <div class="form-group row mt-2">
              <label class="col-form-label col-sm-4 col-12">메일링 동의 여부</label>
              <div class="mailing col-sm-8">
                <label><input type="radio" name="cust_mailing" value="1" ${principal.cust_mailing == 1 ? 'checked' : ''}><span class="mr-2"> 동의합니다.</span></label> 
                <label><input type="radio" name="cust_mailing" value="0" ${principal.cust_mailing == 0 ? 'checked' : ''}><span > 동의하지 않습니다.</span></label> 
              </div>
            </div>
            <div class="form-group form-address row mb-0">
              <label class="col-form-label col-sm-4 col-12">주소</label>
              <div class="col-sm-3 pr-0">
                <input type="text" class="form-control" id="sample3_postcode" name="cust_address1" value="${address[0]}" readonly>
              </div>
              <button class="col-sm-4 btn btn-address text-white m-0 ml-auto" type="button" onclick="sample3_execDaumPostcode()">우편번호 찾기</button>
              <div class="col-sm-12 custom-margin">
                <input type="text" class="form-control" id="sample3_address" name="cust_address2" value="${address[1]}" readonly>
              </div>
              <div class="col-sm-6 pr-1 mb-3">
                <input type="text" class="form-control" id="sample3_detailAddress" name="cust_address3" value="${address[2]}" maxlength="75">
              </div>
              <div class="col-sm-6 pl-1 mb-3">
                <input type="text" class="form-control" id="sample3_extraAddress" name="cust_address4" value="${address[3]}" maxlength="75">
              </div>
            </div>
            <div class="row">
              <small class="col-sm-12 text-danger" id="vm-cust_address"></small>
            </div>
          </div>
        </div>
        <div class="buttons">
          <button type="submit" class="btn text-white mt-1">수정하기</button>
          <a href="/member"><button type="button" class="btn text-white ml-3 mt-1">취소</button></a>
          <button type="button" class="btn text-white float-right mt-1" data-oper="leaveModal">회원 탈퇴</button>
        </div>
        <input type="hidden" id="modify-cust_id" name="cust_id" value="${principal.cust_id}">
        <input type="hidden" id="modify-cust_no" name="cust_no" value="${principal.cust_no}" data-cust_no="${principal.cust_no}">
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

  <!-- Leave Modal -->
  <div class="modal fade" id="leaveModal" tabindex="-1" role="dialog" aria-labelledby="leaveModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="leaveModalLabel">회원 탈퇴</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <p class="text-center m-3">정말로 탈퇴 하시겠습니까? <br> 탈퇴 이후 복구 할 수 없습니다.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary mr-auto" data-dismiss="modal">취소</button>
          <button type="button" class="btn btn-danger" data-oper="leave">탈퇴</button>
        </div>
      </div>
    </div>
  </div>
  <!-- /Leave Modal -->
  
  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />
  
</body>
</html>