<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<s:csrfMetaTags/>

<title>Ogani Admin | Product Info</title>

<!-- Custom fonts for this template-->
<link href="/resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">

<!-- Custom styles for this template-->
<link href="/resources/admin/css/sb-admin-2.min.css" rel="stylesheet">
<link href="/resources/admin/css/main.css" rel="stylesheet">

<!-- Bootstrap core JavaScript-->
<script defer src="/resources/admin/vendor/jquery/jquery.min.js"></script>
<script defer src="/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script defer src="/resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script defer src="/resources/admin/js/sb-admin-2.min.js"></script>
<script defer src="/resources/admin/js/main.js" charset="UTF-8"></script>
</head>

<body id="page-top" class="productRegister">

  <!-- Page Wrapper -->
  <div id="wrapper">

    <jsp:include page="/WEB-INF/templates/admin/sidebar.jsp"></jsp:include>
    
    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">

      <!-- Main Content -->
      <div id="content">

        <jsp:include page="/WEB-INF/templates/admin/topbar.jsp"></jsp:include>

        <!-- Begin Page Content -->
        <div class="container-fluid">
        
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="/admin">Home</a></li>
              <li class="breadcrumb-item"><a href="/admin/product">상품 목록</a></li>
              <li class="breadcrumb-item active" aria-current="page">상품 조회 &amp; 수정</li>
            </ol>
          </nav>
            
         <p class="lead text-dark">상품 조회 &amp; 수정 페이지</p>
         
           <div class="row">
             <div class="col-lg-6">
               <form role="product" action="/admin/product/modify" method="POST">
                  <div class="card mb-4">
                    <div class="card-header">
                       상품 정보
                    </div>
                    <div class="card-body">
                      <div class="col-lg-12 col-xl-4 offset-xl-2 mb-3">
                        <p class="lead">상품 카테고리</p>
                        <select class="form-control" name="cate_no">
                          <option value="0">선택하세요</option>
                          <c:forEach var="category" items="${categoryList}">
                            <option value="${category.cate_no}" <c:out value="${category.cate_no == product.cate_no ? 'selected' : ''}"/>>${category.cate_name}</option>
                          </c:forEach>
                        </select>
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">상품 이름</p>
                        <input class="form-control" type="text" name="prod_name" value="${product.prod_name}">
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">상품 가격</p>
                        <input class="form-control" type="number" name="prod_price" value="${product.prod_price}">
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">상품 내용</p>
                        <textarea class="form-control" rows="10" name="prod_content"><c:out value="${product.prod_content}"/></textarea>
                      </div>                                   
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">상품 재고</p>
                        <input class="form-control" type="number" name="prod_stock" value="${product.prod_stock}">
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2">
                        <p class="lead">상품 진열 여부</p>
                        <div class="d-flex">
                          <label><input type="radio" name="prod_display" value="1" <c:out value="${product.prod_display == 1 ? 'checked' : ''}"/>> 진열</label>
                          <label class="ml-3"><input type="radio" name="prod_display" value="0" <c:out value="${product.prod_display == 1 ? '' : 'checked'}"/>> 미진열</label>
                        </div>
                        <s:csrfInput/>
                        <input type="hidden" value="${product.prod_no}" name="prod_no" data-prod_no="${product.prod_no}">
                      </div>          
                      <button type="button" class="btn btn-primary float-right mt-5" onclick="productRegister();">상품 수정</button>
                      <button type="button" class="btn btn-primary mt-5" data-toggle="modal" data-target="#deleteProductModal">상품 삭제</button>
                      <!-- Button trigger modal -->
                    </div>
                  </div>
               </form>
             </div>
             <div class="col-lg-6">
               <div class="card mb-4">
                <div class="card-header">
                    상품 이미지 수정
                </div>
                <div class="card-body">
                  <div class="bigImageWrapper">
                    <div class="bigImage"></div>
                  </div>
                  <div class="fileUpload p-2">
                    <input name="uploadImage" type="file" multiple="multiple"><br>
                    <div class="mt-3"><small>파일을 선택 후 업로드 버튼을 눌러주세요</small></div>
                  </div>
                  <hr class="mx-2">
                  <div class="uploadResult d-flex flex-wrap">
                    <c:forEach var="image" items="${product.prod_imagelist}">
                      <c:set var="fileCallPath" value="${image.prod_image_url}/thumb_${image.prod_image_uuid}_${image.prod_image_name}"/>
                      <c:set var="originPath" value="${image.prod_image_url}/${image.prod_image_uuid}_${image.prod_image_name}"/>
                    
                      <div class="m-2">
                        <a href="javascript:showImage('${originPath}')" style="text-decoration: none;">
                          <img src="/admin/product/displayImage?imageName=${fileCallPath}"/><br>
                          ${image.prod_image_name}
                        </a>
                        <span data-image="${fileCallPath}" style="color: #CA010B;">
                          <i class='far fa-minus-square' style='position: relative; top: 2px; cursor: pointer;'></i>
                        </span>
                        <div class="image-data">
                          <input type="hidden" value="${image.prod_image_name}" name="prod_image_name[]">
                          <input type="hidden" value="${image.prod_image_url}"  name="prod_image_url[]">
                          <input type="hidden" value="${image.prod_image_uuid}" name="prod_iage_uuid[]">
                        </div>
                      </div>
                    </c:forEach>
                  </div>
                  <button id="uploadBtn" class="btn btn-primary float-right mt-5">상품 이미지 업로드</button>
                </div>
              </div>
              <form action="/admin/product/registerCategory" method="POST">
               <div class="card mb-4">
                 <div class="card-header">
                   상품 카테고리 수정
                 </div>
                 <div class="card-body">
                   <div class="col-lg-12 col-xl-4 offset-xl-2 mb-3">
                     <p class="lead">카테고리 선택</p>
                     <select class="form-control" name="cate_parentno">
                       <option value="0">(선택하세요)</option>
                       <c:forEach var="category" items="${categoryList}">
                         <option value="${category.cate_no}">${category.cate_name}</option>
                       </c:forEach>
                     </select>
                   </div>
                   <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                     <p class="lead">카테고리 이름</p>
                     <input class="form-control" type="text" name="cate_name">
                   </div>
                   <button type="submit" class="btn btn-primary float-right mt-5">카테고리 수정</button>
                   <s:csrfInput/> 
                 </div>
               </div>
               </form>
             </div>
           </div>    
        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- End of Main Content -->

      <jsp:include page="/WEB-INF/templates/admin/footer.jsp"></jsp:include>

    </div>
    <!-- End of Content Wrapper -->

  </div>
  <!-- End of Page Wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top"> <i class="fas fa-angle-up"></i></a>
  
  <!-- deleteProductModal -->
  <div class="modal fade" id="deleteProductModal" data-backdrop="static" data-keyboard="false" tabindex="-1" 
       aria-labelledby="deleteProductTitle" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="deleteProductTitle">삭제 확인</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true"><i class="fas fa-times"></i></span>
          </button>
        </div>
        <div class="modal-body text-center">
          정말로 삭제하시겠습니까? 복구할 수 없습니다.
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
          <button type="button" class="btn btn-primary" onclick="productRemove();">삭제</button>
        </div>
      </div>
    </div>
  </div>
  
  <jsp:include page="/WEB-INF/templates/admin/logoutModal.jsp"></jsp:include>

</body>

</html>