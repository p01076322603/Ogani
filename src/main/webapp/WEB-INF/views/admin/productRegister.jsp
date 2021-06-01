<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<s:csrfMetaTags/>

<title>Ogani Admin | Product Register</title>

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
<script defer src="/resources/admin/js/main.js"></script>
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
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item"><a href="#">상품</a></li>
              <li class="breadcrumb-item active" aria-current="page">상품 등록</li>
            </ol>
          </nav>
            
         <p class="lead text-dark">상품 등록 페이지</p>
         
           <div class="row">
             <div class="col-lg-6">
               <form action="#" method="POST">
                  <div class="card mb-4">
                    <div class="card-header">
                       상품 정보 입력
                    </div>
                    <div class="card-body">
                      <div class="col-lg-12 col-xl-4 offset-xl-2 mb-3">
                        <p class="lead">상품 카테고리</p>
                        <select class="form-control">
                          <option>테스트</option>
                          <option>테스트</option>
                          <option>테스트</option>
                        </select>
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">상품 이름</p>
                        <input class="form-control" type="text">
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">상품 가격</p>
                        <input class="form-control" type="number">
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">상품 내용</p>
                        <textarea class="form-control" rows="10"></textarea>
                      </div>                                   
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">상품 재고</p>
                        <input class="form-control" type="number" placeholder="기본값 : 0">
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2">
                        <p class="lead">상품 진열 여부</p>
                        <div class="d-flex">
                          <label><input type="radio" name="prod_display" checked> 진열</label>
                          <label class="ml-3"><input type="radio" name="prod_display"> 미진열</label>
                        </div>
                      </div>                                   
                    </div>
                  </div>
               </form>
             </div>
             <div class="col-lg-6">
               <div class="card mb-4">
                <div class="card-header">
                    상품 이미지 등록
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
                       
                  </div>
                  <button id="uploadBtn" class="btn btn-primary float-right mt-5">업로드</button>
                </div>
              </div>
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

  <jsp:include page="/WEB-INF/templates/admin/logoutModal.jsp"></jsp:include>

</body>

</html>