<%@page import="java.util.List"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="com.ogani.domain.ProductCategoryDTO"%>
<%@page import="com.ogani.service.ProductService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<% 
ServletContext servletContext = getServletContext();
WebApplicationContext webApplicationContext = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);
ProductService productService = (ProductService) webApplicationContext.getBean("ProductService");

List<ProductCategoryDTO> categoryList = productService.getAllCategory();
pageContext.setAttribute("categoryList", categoryList);
%>
<!-- Page Preloder -->
<!-- <div id="preloder">
  <div class="loader"></div>
</div>
 -->
<!-- Humberger Begin -->
<div class="humberger__menu__overlay"></div>
<div class="humberger__menu__wrapper">
  <div class="humberger__menu__logo">
    <a href="index"><img src="/resources/ogani/img/logo.png" alt=""></a>
  </div>
  <div class="humberger__menu__cart">
    <ul>
      <li><a href="#"><i class="fa fa-heart"></i> <span>1</span></a></li>
      <li><a href="#"><i class="fa fa-shopping-bag"></i> <span>3</span></a></li>
    </ul>
    <div class="header__cart__price">
      item: <span>$150.00</span>
    </div>
  </div>
  <div class="humberger__menu__widget">
    <div class="header__top__right__auth">
      <a href="/login"><i class="fa fa-user"></i> Login</a>
    </div>
  </div>
  <nav class="humberger__menu__nav mobile-menu">
    <ul>
      <li><a href="/">Home</a></li>
      <li><a href="/shop">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/contact">Contact</a></li>
    </ul>
  </nav>
  <div id="mobile-menu-wrap"></div>
  <div class="header__top__right__social">
    <a href="#"><i class="fa fa-facebook"></i></a> <a href="#"><i class="fa fa-twitter"></i></a> <a href="#"><i
      class="fa fa-linkedin"></i></a> <a href="#"><i class="fa fa-pinterest-p"></i></a>
  </div>
  <div class="humberger__menu__contact">
    <ul>
      <li><i class="fa fa-envelope"></i> Ogani@colorlib.com</li>
    </ul>
  </div>
</div>
<!-- Humberger End -->

<!-- Header Section Begin -->
<header class="header">
  <div class="header__top">
    <div class="container">
      <div class="row">
        <div class="col-lg-6">
          <div class="header__top__left">
            <ul>
              <li><i class="fa fa-envelope"></i> Ogani@colorlib.com</li>
            </ul>
          </div>
        </div>
        <div class="col-lg-6">
          <div class="header__top__right">
            <div class="header__top__right__auth d-flex float-right" style="position: relative; top: 3px;">        
              <s:authorize access="isAnonymous()">
                <a href="/login" class="px-3"><i class="fa fa-user"></i>로그인</a>
                <a href="register"><i class="fa fa-user"></i>회원 가입</a>
              </s:authorize>
              <s:authorize access="hasRole('ROLE_USER')">
                <s:authentication var="principal" property="principal"/>
                <p class="m-0" style="position: relative; bottom: 3px;"><c:out value="${principal.cust_id}"/></p>
                <a href="/logout" class="px-3"><i class="fa fa-user"></i>로그아웃</a>
                <a href="/member"><i class="fa fa-user"></i>회원 정보</a>
              </s:authorize>
              <s:authorize access="hasRole('ROLE_ADMIN')">
                <s:authentication var="principal" property="principal"/>
                <p class="m-0" style="position: relative; bottom: 3px;"><c:out value="${principal.admin_id}"/></p>
                <a href="/logout" class="px-3"><i class="fa fa-user"></i>로그아웃</a>
                <a href="/admin"><i class="fa fa-user"></i>Admin</a>
              </s:authorize>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="container">
    <div class="row">
      <div class="col-lg-3">
        <div class="header__logo">
          <a href="/"><img src="/resources/ogani/img/logo.png" alt=""></a>
        </div>
      </div>
      <div class="col-lg-6">
        <nav class="header__menu">
          <ul class="text-center">
            <li><a href="/">Home</a></li>
            <li><a href="/shop">Shop</a></li>
            <li><a href="/blog">Blog</a></li>
            <li><a href="/contact">Contact</a></li>
          </ul>
        </nav>
      </div>
      <div class="col-lg-3">
        <div class="header__cart">
          <div class="header__cart__price">
            <a href="/cart" class="text-dark"><i class="fa fa-shopping-bag"></i> 장바구니</a>
          </div>
        </div>
      </div>
    </div>
    <div class="humberger__open">
      <i class="fa fa-bars"></i>
    </div>
  </div>
</header>
<!-- Header Section End -->

<!-- Hero Section Begin -->
<section class="hero hero-normal">
  <div class="container">
    <div class="row">
      <div class="col-lg-3">
        <div class="hero__categories">
          <div class="hero__categories__all">
            <i class="fa fa-bars"></i> <span style="position: relative; top: 2px;">카테고리</span>
          </div>
          <ul>
            <c:forEach var="category" items="${categoryList}">
              <li><a href="/shop/${category.cate_no}">${category.cate_name}</a></li>
            </c:forEach>
          </ul>
        </div>
      </div>
      <div class="col-lg-9">
        <div class="hero__search">
          <div class="hero__search__form">
            <form action="#">
              <input type="text" placeholder="검색">
              <button type="submit" class="site-btn">SEARCH</button>
            </form>
          </div>
          <div class="hero__search__phone">
            <div class="hero__search__phone__icon">
              <i class="fa fa-phone"></i>
            </div>
            <div class="hero__search__phone__text">
              <h5>010-7632-2603</h5>
              <span>연락처</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- Hero Section End -->