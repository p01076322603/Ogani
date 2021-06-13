<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<title>Ogani | Template</title>

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
  
  <jsp:include page="/WEB-INF/templates/ogani/header.jsp"/>
  <c:set var="uploadLoc" value="/resources/upload/"/>
  <s:authorize access="hasRole('ROLE_USER')">
    <s:authentication var="principal" property="principal"/>
    <input type="hidden" value="${principal.cust_no}" id="cust_no">
  </s:authorize>

  <!-- Breadcrumb Section Begin -->
  <section class="breadcrumb-section set-bg" data-setbg="/resources/ogani/img/breadcrumb.jpg">
    <div class="container">
      <div class="row">
        <div class="col-lg-12 text-center">
          <div class="breadcrumb__text">
            <h2>Organi Shop</h2>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Breadcrumb Section End -->

  <!-- Product Section Begin -->
  <section class="product spad">
    <div class="container">
      <div class="row">
        <div class="col-lg-3 col-md-5">
          <div class="sidebar">
            <div class="sidebar__item">
              <h4>카테고리</h4>
              <ul>
                <li><a href="/shop">전체</a></li>
                <c:forEach var="category" items="${categoryList}">
                  <li><a href="/shop/${category.cate_no}">${category.cate_name}</a></li>
                </c:forEach>
              </ul>
            </div>
            <div class="sidebar__item">
              <div class="latest-product__text">
                <h4>Latest Products</h4>
                <div class="latest-product__slider owl-carousel">
                  <div class="latest-prdouct__slider__item">
                    <a href="#" class="latest-product__item">
                      <div class="latest-product__item__pic">
                        <img src="/resources/ogani/img/latest-product/lp-1.jpg" alt="">
                      </div>
                      <div class="latest-product__item__text">
                        <h6>Crab Pool Security</h6>
                        <span>$30.00</span>
                      </div>
                    </a> 
                    <a href="#" class="latest-product__item">
                      <div class="latest-product__item__pic">
                        <img src="/resources/ogani/img/latest-product/lp-2.jpg" alt="">
                      </div>
                      <div class="latest-product__item__text">
                        <h6>Crab Pool Security</h6>
                        <span>$30.00</span>
                      </div>
                    </a> 
                    <a href="#" class="latest-product__item">
                      <div class="latest-product__item__pic">
                        <img src="/resources/ogani/img/latest-product/lp-3.jpg" alt="">
                      </div>
                      <div class="latest-product__item__text">
                        <h6>Crab Pool Security</h6>
                        <span>$30.00</span>
                      </div>
                    </a>
                  </div>
                  <div class="latest-prdouct__slider__item">
                    <a href="#" class="latest-product__item">
                      <div class="latest-product__item__pic">
                        <img src="/resources/ogani/img/latest-product/lp-1.jpg" alt="">
                      </div>
                      <div class="latest-product__item__text">
                        <h6>Crab Pool Security</h6>
                        <span>$30.00</span>
                      </div>
                    </a> 
                    <a href="#" class="latest-product__item">
                      <div class="latest-product__item__pic">
                        <img src="/resources/ogani/img/latest-product/lp-2.jpg" alt="">
                      </div>
                      <div class="latest-product__item__text">
                        <h6>Crab Pool Security</h6>
                        <span>$30.00</span>
                      </div>
                    </a> 
                    <a href="#" class="latest-product__item">
                      <div class="latest-product__item__pic">
                        <img src="/resources/ogani/img/latest-product/lp-3.jpg" alt="">
                      </div>
                      <div class="latest-product__item__text">
                        <h6>Crab Pool Security</h6>
                        <span>$30.00</span>
                      </div>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-9 col-md-7">
          <div class="filter__item">
            <div class="row">
              <div class="col-lg-4 col-md-5">
                <c:if test="${pageParam.productCount > 0}">
                  <div class="filter__sort">
                    <span>Sort By</span> <select>
                      <option value="0">등록일</option>
                      <option value="0">가격</option>
                    </select>
                  </div>
                </c:if>
              </div>
              <div class="col-lg-4 col-md-4">
                <div class="filter__found">
                  <h6><span>${pageParam.productCount} </span> Products found</h6>
                </div>
              </div>
            </div>
          </div>
            <c:choose>
              <c:when test="${pageParam.productCount == 0}">
                <p class="text-center lead">상품이 존재하지 않습니다.</p>
              </c:when>
              <c:otherwise>
                <div class="row">
                  <c:forEach var="product" items="${productList}">
                    <c:set var="image" value="${product.prod_imagelist[0]}"/>
                    <c:set var="imagePath" value="${uploadLoc}${image.prod_image_url}/${image.prod_image_uuid}_${image.prod_image_name}"/>
                    <div class="col-lg-4 col-md-6 col-sm-6">
                      <div class="product__item">
                        <input type="hidden" value="${product.prod_no}">
                        <div class="product__item__pic set-bg rounded" data-setbg="${imagePath}">
                          <ul class="product__item__pic__hover">
                            <li>
                              <a class="product__item__pic__hover__anchor" 
                                 href="javascript:void(0)" data-cart="${product.prod_no}">
                                <i class="fa fa-shopping-cart"></i>
                              </a>
                            </li>
                          </ul>
                        </div>
                        <div class="product__item__text">
                          <h6><a href="#">${product.prod_name}</a></h6>
                          <h5><fmt:formatNumber value="${product.prod_price}" type="currency"/> </h5>
                        </div>
                      </div>
                    </div>
                  </c:forEach>
                </div>
              </c:otherwise>
            </c:choose>
          <c:if test="${pageParam.productCount > 0}">
            <div class="product__pagination" data-block-num="${pageParam.blockNum}" data-last-block-num="${pageParam.lastBlockNum}">
              <c:set var="searchKeyword" value="${not empty keyword ? '&keyword=' : ''}${not empty keyword ? keyword : ''}"/>
              <c:if test="${not empty pageParam.category}">
                <c:set var="paginationHrefPage" value="/shop/${pageParam.category}?page="/>
              </c:if>
              <c:if test="${empty pageParam.category}">
                <c:set var="paginationHrefPage" value="/shop?page="/>
              </c:if>
              <a class="prev_bt" href="${paginationHrefPage}${pageParam.blockNum * pageParam.paginationCount}<c:out value="${searchKeyword}"/>">
                <i class="fa fa-long-arrow-left"></i>
              </a>
              <c:forEach begin="1" end="${pageParam.paginationCount}" varStatus="status">
                <c:set var="thisPage" value="${pageParam.blockNum * pageParam.paginationCount + status.index}"/>
                <c:if test="${thisPage <= pageParam.pageCount}">
                <a <c:out value="${pageParam.currentPage == thisPage ? 'class=paging-active' : ''}"/> 
                  href="${paginationHrefPage}${thisPage}<c:out value="${searchKeyword}"/>">
                  ${thisPage}</a>
                </c:if>
              </c:forEach>
              <a class="next_bt" href="${paginationHrefPage}${(pageParam.blockNum + 1) * pageParam.paginationCount + 1}<c:out value="${searchKeyword}"/>">
                <i class="fa fa-long-arrow-right"></i>
              </a>
            </div>
          </c:if>
        </div>
      </div>
    </div>
  </section>
  <!-- Product Section End -->

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp"/>

</body>
</html>