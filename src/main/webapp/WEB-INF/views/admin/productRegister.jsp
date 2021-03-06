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
        
        <c:if test="${categoryRegisterResult}">
          <div class="alert alert-success alert-dismissible fade show" role="alert">
            ??????????????? ?????????????????????.
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
        </c:if>
        
          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="/admin">Home</a></li>
              <li class="breadcrumb-item"><a href="/admin/product">?????? ??????</a></li>
              <li class="breadcrumb-item active" aria-current="page">?????? &amp; ???????????? ??????</li>
            </ol>
          </nav>
            
         <p class="lead text-dark">?????? &amp; ???????????? ?????? ?????????</p>
         
           <div class="row">
             <div class="col-lg-6">
               <form role="product" action="/admin/product/register" method="POST">
                  <div class="card mb-4">
                    <div class="card-header">
                       ?????? ?????? ??????
                    </div>
                    <div class="card-body">
                      <div class="col-lg-12 col-xl-4 offset-xl-2 mb-3">
                        <p class="lead">?????? ????????????</p>
                        <select class="form-control" name="cate_no">
                          <option value="0">???????????????</option>
                          <c:forEach var="category" items="${categoryList}">
                            <option value="${category.cate_no}">${category.cate_name}</option>
                          </c:forEach>
                        </select>
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">?????? ??????</p>
                        <input class="form-control" type="text" name="prod_name">
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">?????? ??????</p>
                        <input class="form-control" type="number" name="prod_price">
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">?????? ??????</p>
                        <textarea class="form-control" rows="10" name="prod_content"></textarea>
                      </div>                                   
                      <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                        <p class="lead">?????? ??????</p>
                        <input class="form-control" type="number" name="prod_stock" value="0">
                      </div>
                      <div class="col-lg-12 col-xl-8 offset-xl-2">
                        <p class="lead">?????? ?????? ??????</p>
                        <div class="d-flex">
                          <label><input type="radio" name="prod_display" value="1" checked> ??????</label>
                          <label class="ml-3"><input type="radio" name="prod_display" value="0"> ?????????</label>
                        </div>
                        <s:csrfInput/>
                      </div>          
                      <button type="button" class="btn btn-primary float-right mt-5" onclick="productRegister();">?????? ??????</button>                         
                    </div>
                  </div>
               </form>
             </div>
             <div class="col-lg-6">
               <div class="card mb-4">
                <div class="card-header">
                    ?????? ????????? ??????
                </div>
                <div class="card-body">
                  <div class="bigImageWrapper">
                    <div class="bigImage"></div>
                  </div>
                  <div class="fileUpload p-2">
                    <input name="uploadImage" type="file" multiple="multiple"><br>
                    <div class="mt-3"><small>????????? ?????? ??? ????????? ????????? ???????????????</small></div>
                  </div>
                  <hr class="mx-2">
                  <div class="uploadResult d-flex flex-wrap">
                    
                  </div>
                  <button id="uploadBtn" class="btn btn-primary float-right mt-5">?????? ????????? ?????????</button>
                </div>
              </div>
              <form action="/admin/product/registerCategory" method="POST">
               <div class="card mb-4">
                 <div class="card-header">
                   ?????? ???????????? ??????
                 </div>
                 <div class="card-body">
                   <div class="col-lg-12 col-xl-4 offset-xl-2 mb-3">
                     <p class="lead">?????? ????????????</p>
                     <select class="form-control" name="cate_parentno">
                       <option value="0">(??????)</option>
                       <c:forEach var="category" items="${categoryList}">
                         <option value="${category.cate_no}">${category.cate_name}</option>
                       </c:forEach>
                     </select>
                   </div>
                   <div class="col-lg-12 col-xl-8 offset-xl-2 mb-3">
                     <p class="lead">???????????? ??????</p>
                     <input class="form-control" type="text" name="cate_name">
                   </div>
                   <button type="submit" class="btn btn-primary float-right mt-5">???????????? ??????</button>
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

  <jsp:include page="/WEB-INF/templates/admin/logoutModal.jsp"></jsp:include>

</body>

</html>