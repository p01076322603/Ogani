<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
<body class="memberInfo">

  <jsp:include page="/WEB-INF/templates/ogani/header.jsp" />
  <s:authentication var="principal" property="principal"/>
  
  <div class="container">
    <c:if test="${modifyResult eq true}">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        ?????? ????????? ?????????????????????.
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
      
      <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li class="nav-item" role="presentation">
          <a class="nav-link active" id="member-info-tab" data-toggle="tab" href="#member-info" role="tab" aria-controls="member-info" aria-selected="true">?????? ??????</a>
        </li>
        <li class="nav-item" role="presentation">
          <a class="nav-link" id="member-order-tab" data-toggle="tab" href="#member-order" role="tab" aria-controls="member-order" aria-selected="false">?????? ??????</a>
        </li>
      </ul>
      <div class="tab-content" id="myTabContent">
        <div class="tab-pane fade show active" id="member-info" role="tabpanel" aria-labelledby="member-info-tab">
          <div class="row mt-2">
            <div class="col-lg-6">
              <div class="form-group row no-border">
                <label class="col-form-label col-sm-4 col-12">?????????</label>
                <div class="col-sm-8 align-middle">
                  <p><c:out value="${principal.cust_id}"/></p>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-form-label col-sm-4 col-12">?????????</label>
                <div class="col-sm-8 align-middle">
                  <p><c:out value="${principal.cust_email}"/></p>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-form-label col-sm-4 col-12">????????? ??????</label>
                <div class="col-sm-8 align-middle">
                  <p><c:out value="${principal.cust_phone}"/></p>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-form-label col-sm-4 col-12">?????????</label>
                <div class="col-sm-8 align-middle">
                  <p><fmt:formatDate value="${principal.cust_regdate}" dateStyle="full"/></p>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-form-label col-sm-4 col-12">?????? ????????? ??????</label>
                <div class="col-sm-8 align-middle">
                  <p><fmt:formatDate value="${principal.cust_lastlogin}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                </div>
              </div>
            </div>
            <div class="col-lg-6">
              <div class="form-group row no-border">
                <label class="col-form-label col-sm-4 col-12">??????</label>
                <div class="col-sm-8 align-middle">
                  <p><c:out value="${principal.cust_name}"/></p>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-form-label col-sm-4 col-12">????????? ?????? ??????</label>
                <div class="col-sm-8 align-middle">
                  <p><c:out value="${principal.cust_mailing == 1 ? '???????????????.' : '???????????? ????????????.'}"/></p>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-form-label col-sm-4 col-12">??????</label>
                <div class="col-sm-8 align-middle">
                  <p><c:out value="${principal.cust_address}"/></p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="tab-pane fade" id="member-order" role="tabpanel" aria-labelledby="member-order-tab">
          <c:if test="${empty orderList}">
            <p class="lead text-center p-5">?????? ????????? ????????????.</p>
          </c:if>
          <!-- ????????? ????????? ????????? ?????? ?????? -->
          <c:if test="${not empty orderList}">
            <div class="card mt-3">
              <div class="card-header" id="orderHeading">
                <div class="d-flex text-center">
                  <strong class="w-25">?????????</strong>
                  <strong class="w-25">?????? ??????</strong>
                  <strong class="w-25">??? ??????</strong>
                  <strong class="w-25">?????? ???</strong>
                </div>
              </div>
            </div>
            <div class="accordion mt-2" id="accordion">
              <c:forEach var="order" items="${orderList}">
                <div class="card order-each" style="cursor: pointer;">
                  <div class="card-header p-0" id="orderHeading">
                    <p><fmt:formatDate value="${order.order_regdate}" pattern="yy-MM-dd"/></p> 
                    <p>${order.order_name}</p> 
                    <p><fmt:formatNumber value="${order.order_price}" type="currency"/></p> 
                    <p>${fn:length(order.orderDetailList)}???</p>
                  </div>
                  <div id="orderCollapse" class="collapse" aria-labelledby="orderHeading" data-parent="#accordion">
                    <div class="card-body p-0 py-2">
                      <strong>?????? ??????</strong>
                      <strong>?????? ??????</strong>
                      <strong>?????? ??????</strong>
                      <strong>?????? ??????</strong>
                    </div>
                    <c:forEach var="orderDetail" items="${order.orderDetailList}">
                      <div class="card-body p-0">
                        <p>${orderDetail.order_uid}</p>
                        <p>${orderDetail.prod_name}</p>
                        <p>${orderDetail.order_detail_quantity}</p>
                        <c:choose>
                          <c:when test="${orderDetail.order_detail_shipstatus == 1}">
                            <p>?????????</p>
                          </c:when>
                          <c:when test="${orderDetail.order_detail_shipstatus == 2}">
                            <a href="#" data-toggle="tooltip" data-placement="right" title="????????? ?????? ??? ????????????.">
                              <p class="btn text-white" style="min-width: 95px;">?????? ??????</p>
                            </a>
                          </c:when>
                          <c:otherwise>
                            <p>?????? ??????</p>
                          </c:otherwise>
                        </c:choose>
                      </div>
                    </c:forEach>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:if>
        </div>
      </div>
      <div class="d-flex justify-content-center">
        <a href="member/modify"><button class="btn text-white mx-2">????????????</button></a>
        <a href="/"><button class="btn text-white mx-2">????????????</button></a>
      </div>
    </div>
  </div>

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />
  
</body>
</html>