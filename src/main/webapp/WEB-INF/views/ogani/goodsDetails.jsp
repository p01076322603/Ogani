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
</head>

<body>
  
  <jsp:include page="/WEB-INF/templates/ogani/header.jsp" />
  <c:set var="uploadLoc" value="/resources/upload/"/>
  <s:authentication var="principal" property="principal"/>

  <!-- Product Details Section Begin -->
  <section class="product-details spad">
    <div class="container">
      <div class="row">
        <div class="col-lg-6 col-md-6">
          <div class="product__details__pic">
            <div class="product__details__pic__item">
              <c:set var="largeImage" value="${pageProduct.prod_imagelist[0]}"/>
              <img class="product__details__pic__item--large bigImage-wrap"
              src="${uploadLoc}${largeImage.prod_image_url}/${largeImage.prod_image_uuid}_${largeImage.prod_image_name}" alt="">
            </div>
            <div class="product__details__pic__slider owl-carousel">
              <c:forEach var="image" items="${pageProduct.prod_imagelist}">
                <img data-imgbigurl="${uploadLoc}${image.prod_image_url}/${image.prod_image_uuid}_${image.prod_image_name}" 
                                src="${uploadLoc}${image.prod_image_url}/${image.prod_image_uuid}_${image.prod_image_name}" 
                                alt="product_image" class="image-wrap"> 
              </c:forEach>
            </div>
          </div>
        </div>
        <div class="col-lg-6 col-md-6">
          <div class="product__details__text">
            <h3><c:out value="${pageProduct.prod_name}"/></h3>
            <div class="product__details__rating">
              <i class="fa fa-star"></i> 
              <i class="fa fa-star"></i> 
              <i class="fa fa-star"></i> 
              <i class="fa fa-star"></i>
              <i class="fa fa-star-half-o"></i> 
              <span>(18 reviews)</span>
            </div>
            <div class="product__details__price"><fmt:formatNumber value="${pageProduct.prod_price}" type="currency"/></div>
            <p><c:out value="${pageProduct.prod_content}"/></p>
            <div class="product__details__quantity">
              <div class="quantity">
                <div class="pro-qty">
                  <input type="text" value="1" id="cart_quantity">
                </div>
                <input type="hidden" value="${pageProduct.prod_no}" id="prod_no">
                <s:authorize access="isAnonymous()">
                  <input type="hidden" value="0" id="cust_no">
                </s:authorize>
                <s:authorize access="isAuthenticated()">
                  <input type="hidden" value="${principal.cust_no}" id="cust_no">
                </s:authorize>
              </div>
            </div>
            <c:if test="${pageProduct.prod_display == 1}">
              <a href="javascript:void(0);" class="primary-btn lead" id="addCart">카트에 담기</a>
            </c:if>
            <c:if test="${pageProduct.prod_display == 0}">
              <a href="javascript:void(0);" class="secondary-btn" style="cursor: not-allowed;">구매 불가</a>
            </c:if>
            <ul>
              <li><b>상태 : </b> <span>${pageProduct.prod_display == 1 ? '재고 있음' : '재고 없음'}</span></li>
            </ul>
          </div>
        </div>
        <div class="col-lg-12">
          <div class="product__details__tab">
            <ul class="nav nav-tabs" role="tablist">
              <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab" aria-selected="true">상품 상세 정보</a></li>
              <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#tabs-2" role="tab" aria-selected="false">Reviews <span>(1)</span></a></li>
            </ul>
            <div class="tab-content">
              <div class="tab-pane active" id="tabs-1" role="tabpanel">
                <div class="product__details__tab__desc">
                  <h6>상세 정보</h6>
                  <p>Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Pellentesque in ipsum id
                    orci porta dapibus. Proin eget tortor risus. Vivamus suscipit tortor eget felis porttitor volutpat.
                    Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo eget
                    malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur arcu erat, accumsan id
                    imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non
                    nisi. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante ipsum
                    primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet
                    aliquam vel, ullamcorper sit amet ligula. Proin eget tortor risus.</p>
                  <p>Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem ipsum dolor sit
                    amet, consectetur adipiscing elit. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Cras
                    ultricies ligula sed magna dictum porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor
                    lectus nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a. Vestibulum ac diam sit
                    amet quam vehicula elementum sed sit amet dui. Sed porttitor lectus nibh. Vestibulum ac diam sit
                    amet quam vehicula elementum sed sit amet dui. Proin eget tortor risus.</p>
                </div>
              </div>
              <div class="tab-pane" id="tabs-2" role="tabpanel">
                <div class="product__details__tab__desc">
                  <h6>Products Infomation</h6>
                  <p>Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Pellentesque in ipsum id
                    orci porta dapibus. Proin eget tortor risus. Vivamus suscipit tortor eget felis porttitor volutpat.
                    Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Donec rutrum congue leo eget
                    malesuada. Vivamus suscipit tortor eget felis porttitor volutpat. Curabitur arcu erat, accumsan id
                    imperdiet et, porttitor at sem. Praesent sapien massa, convallis a pellentesque nec, egestas non
                    nisi. Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Vestibulum ante ipsum
                    primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec velit neque, auctor sit amet
                    aliquam vel, ullamcorper sit amet ligula. Proin eget tortor risus.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Product Details Section End -->

  <!-- Related Product Section Begin -->
  <section class="related-product">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="section-title related__product__title">
            <h2>같은 카테고리의 상품</h2>
          </div>
        </div>
      </div>
      <div class="row">
        <c:forEach var="product" items="${productList}">
          <c:if test="${pageProduct.prod_no != product.prod_no}">
            <c:set var="image" value="${product.prod_imagelist[0]}"/>
            <c:set var="imagePath" value="${uploadLoc}${image.prod_image_url}/${image.prod_image_uuid}_${image.prod_image_name}"/>
            <div class="col-lg-3 col-md-4 col-sm-6">
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
                  <h6>
                    <a href="#">${product.prod_name}</a>
                  </h6>
                  <h5><fmt:formatNumber value="${product.prod_price}" type="currency"/> </h5>
                </div>
              </div>
            </div>
          </c:if>
        </c:forEach>
      </div>
    </div>
  </section>
  <!-- Related Product Section End -->
  
  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp" />
 
</body>
</html>