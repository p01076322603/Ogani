<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

  <jsp:include page="/WEB-INF/templates/ogani/header.jsp"/>
  <c:set var="uploadLoc" value="/resources/upload/"/>
  <s:authorize access="hasRole('ROLE_USER')">
    <s:authentication var="principal" property="principal"/>
    <input type="hidden" value="${principal.cust_no}" id="cust_no">
  </s:authorize>

  <!-- leaveResultAlert -->
  <c:if test="${leaveResult}">
    <div class="container">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        성공적으로 탈퇴 처리 되었습니다. 이용해주셔서 감사합니다.
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true"> <i class="fas fa-times"></i> </span>
        </button>
      </div>
    </div>
  </c:if>
  <!-- /leaveResultAlert -->
  
  <!-- Categories Section Begin -->
  <section class="categories">
    <div class="container">
      <div class="row">
        <div class="categories__slider owl-carousel">
          <div class="col-lg-3">
            <div class="categories__item set-bg" data-setbg="/resources/ogani/img/categories/cat-1.jpg">
              <h5>
                <a href="#">과일 · 견과 · 쌀</a>
              </h5>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="categories__item set-bg" data-setbg="/resources/ogani/img/categories/cat-2.jpg">
              <h5>
                <a href="#">간식 · 과자 · 떡</a>
              </h5>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="categories__item set-bg" data-setbg="/resources/ogani/img/categories/cat-3.jpg">
              <h5>
                <a href="#">채소</a>
              </h5>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="categories__item set-bg" data-setbg="/resources/ogani/img/categories/cat-4.jpg">
              <h5>
                <a href="#">샐러드 · 간편식</a>
              </h5>
            </div>
          </div>
          <div class="col-lg-3">
            <div class="categories__item set-bg" data-setbg="/resources/ogani/img/categories/cat-5.jpg">
              <h5>
                <a href="#">정육 · 계란</a>
              </h5>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Categories Section End -->

  <!-- Featured Section Begin -->
  <section class="featured spad">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="section-title">
            <h2>최근 등록된 상품</h2>
          </div>
        </div>
      </div>
      <div class="row featured__filter">
        <c:forEach var="product" items="${newProductList}">
        <c:set var="image" value="${product.prod_imagelist[0]}"/>
        <c:set var="imagePath" value="${uploadLoc}${image.prod_image_url}/${image.prod_image_uuid}_${image.prod_image_name}"/>
          <div class="col-lg-3 col-md-4 col-sm-6">
            <div class="featured__item">
              <input type="hidden" value="${product.prod_no}">
              <div class="featured__item__pic set-bg rounded" data-setbg="${imagePath}">
                <ul class="featured__item__pic__hover">
                  <li>
                    <a class="featured__item__pic__hover__anchor" data-cart="${product.prod_no}" href="javascript:void(0)">
                      <i class="fa fa-shopping-cart"></i>
                    </a>
                  </li>
                </ul>
              </div>
              <div class="featured__item__text">
                <h6>
                  <a href="/goods/${product.prod_no}">${product.prod_name}</a>
                </h6>
                <h5><fmt:formatNumber value="${product.prod_price}" type="currency"/></h5>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>
  </section>
  <!-- Featured Section End -->

  <!-- Banner Begin -->
  <div class="banner">
    <div class="container">
      <div class="row">
        <div class="col-lg-6 col-md-6 col-sm-6">
          <div class="banner__pic">
            <img src="/resources/ogani/img/banner/banner-1.jpg" alt="">
          </div>
        </div>
        <div class="col-lg-6 col-md-6 col-sm-6">
          <div class="banner__pic">
            <img src="/resources/ogani/img/banner/banner-2.jpg" alt="">
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Banner End -->

  <!-- Latest Product Section Begin -->
  <section class="latest-product spad">
    <div class="container">
      <div class="row">
        <div class="col-lg-4 col-md-6">
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
                </a> <a href="#" class="latest-product__item">
                  <div class="latest-product__item__pic">
                    <img src="/resources/ogani/img/latest-product/lp-2.jpg" alt="">
                  </div>
                  <div class="latest-product__item__text">
                    <h6>Crab Pool Security</h6>
                    <span>$30.00</span>
                  </div>
                </a> <a href="#" class="latest-product__item">
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
        <div class="col-lg-4 col-md-6">
          <div class="latest-product__text">
            <h4>Top Rated Products</h4>
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
        <div class="col-lg-4 col-md-6">
          <div class="latest-product__text">
            <h4>Review Products</h4>
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
  </section>
  <!-- Latest Product Section End -->

  <!-- Blog Section Begin -->
  <section class="from-blog spad">
    <div class="container">
      <div class="row">
        <div class="col-lg-12">
          <div class="section-title from-blog__title">
            <h2>From The Blog</h2>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-6">
          <div class="blog__item">
            <div class="blog__item__pic">
              <img src="/resources/ogani/img/blog/blog-1.jpg" alt="">
            </div>
            <div class="blog__item__text">
              <ul>
                <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                <li><i class="fa fa-comment-o"></i> 5</li>
              </ul>
              <h5>
                <a href="#">Cooking tips make cooking simple</a>
              </h5>
              <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam quaerat</p>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6">
          <div class="blog__item">
            <div class="blog__item__pic">
              <img src="/resources/ogani/img/blog/blog-2.jpg" alt="">
            </div>
            <div class="blog__item__text">
              <ul>
                <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                <li><i class="fa fa-comment-o"></i> 5</li>
              </ul>
              <h5>
                <a href="#">6 ways to prepare breakfast for 30</a>
              </h5>
              <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam quaerat</p>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6">
          <div class="blog__item">
            <div class="blog__item__pic">
              <img src="/resources/ogani/img/blog/blog-3.jpg" alt="">
            </div>
            <div class="blog__item__text">
              <ul>
                <li><i class="fa fa-calendar-o"></i> May 4,2019</li>
                <li><i class="fa fa-comment-o"></i> 5</li>
              </ul>
              <h5>
                <a href="#">Visit the clean farm in the US</a>
              </h5>
              <p>Sed quia non numquam modi tempora indunt ut labore et dolore magnam aliquam quaerat</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Blog Section End -->

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp"/>
  
</body>
</html>