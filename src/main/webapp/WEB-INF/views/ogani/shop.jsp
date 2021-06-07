<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta name="description" content="Ogani Template">
<meta name="keywords" content="Ogani, unica, creative, html">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
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
                <c:forEach var="category" items="${categoryList}">
                  <li><a href="/category/${category.cate_no}">${category.cate_name}</a></li>
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
                <div class="filter__sort">
                  <span>Sort By</span> <select>
                    <option value="0">Default</option>
                    <option value="0">Default</option>
                  </select>
                </div>
              </div>
              <div class="col-lg-4 col-md-4">
                <div class="filter__found">
                  <h6><span>16</span> Products found</h6>
                </div>
              </div>
              <div class="col-lg-4 col-md-3">
                <div class="filter__option">
                  <span class="icon_grid-2x2"></span> <span class="icon_ul"></span>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-lg-4 col-md-6 col-sm-6">
              <div class="product__item">
                <div class="product__item__pic set-bg" data-setbg="/resources/ogani/img/product/product-1.jpg">
                  <ul class="product__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                  </ul>
                </div>
                <div class="product__item__text">
                  <h6><a href="#">Crab Pool Security</a></h6>
                  <h5>$30.00</h5>
                </div>
              </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6">
              <div class="product__item">
                <div class="product__item__pic set-bg" data-setbg="/resources/ogani/img/product/product-2.jpg">
                  <ul class="product__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                  </ul>
                </div>
                <div class="product__item__text">
                  <h6><a href="#">Crab Pool Security</a></h6>
                  <h5>$30.00</h5>
                </div>
              </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6">
              <div class="product__item">
                <div class="product__item__pic set-bg" data-setbg="/resources/ogani/img/product/product-3.jpg">
                  <ul class="product__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                  </ul>
                </div>
                <div class="product__item__text">
                  <h6><a href="#">Crab Pool Security</a></h6>
                  <h5>$30.00</h5>
                </div>
              </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6">
              <div class="product__item">
                <div class="product__item__pic set-bg" data-setbg="/resources/ogani/img/product/product-4.jpg">
                  <ul class="product__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                  </ul>
                </div>
                <div class="product__item__text">
                  <h6><a href="#">Crab Pool Security</a></h6>
                  <h5>$30.00</h5>
                </div>
              </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6">
              <div class="product__item">
                <div class="product__item__pic set-bg" data-setbg="/resources/ogani/img/product/product-5.jpg">
                  <ul class="product__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                  </ul>
                </div>
                <div class="product__item__text">
                  <h6><a href="#">Crab Pool Security</a></h6>
                  <h5>$30.00</h5>
                </div>
              </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6">
              <div class="product__item">
                <div class="product__item__pic set-bg" data-setbg="/resources/ogani/img/product/product-6.jpg">
                  <ul class="product__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                  </ul>
                </div>
                <div class="product__item__text">
                  <h6><a href="#">Crab Pool Security</a></h6>
                  <h5>$30.00</h5>
                </div>
              </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6">
              <div class="product__item">
                <div class="product__item__pic set-bg" data-setbg="/resources/ogani/img/product/product-7.jpg">
                  <ul class="product__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                  </ul>
                </div>
                <div class="product__item__text">
                  <h6><a href="#">Crab Pool Security</a></h6>
                  <h5>$30.00</h5>
                </div>
              </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6">
              <div class="product__item">
                <div class="product__item__pic set-bg" data-setbg="/resources/ogani/img/product/product-8.jpg">
                  <ul class="product__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                  </ul>
                </div>
                <div class="product__item__text">
                  <h6><a href="#">Crab Pool Security</a></h6>
                  <h5>$30.00</h5>
                </div>
              </div>
            </div>
            <div class="col-lg-4 col-md-6 col-sm-6">
              <div class="product__item">
                <div class="product__item__pic set-bg" data-setbg="/resources/ogani/img/product/product-9.jpg">
                  <ul class="product__item__pic__hover">
                    <li><a href="#"><i class="fa fa-heart"></i></a></li>
                    <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                    <li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>
                  </ul>
                </div>
                <div class="product__item__text">
                  <h6><a href="#">Crab Pool Security</a></h6>
                  <h5>$30.00</h5>
                </div>
              </div>
            </div>
          </div>
          <div class="product__pagination">
            <a href="#">1</a> <a href="#">2</a> <a href="#">3</a> <a href="#"><i class="fa fa-long-arrow-right"></i></a>
          </div>
        </div>
      </div>
    </div>
  </section>
  <!-- Product Section End -->

  <jsp:include page="/WEB-INF/templates/ogani/footer.jsp"/>

</body>
</html>