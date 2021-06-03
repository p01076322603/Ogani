<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Ogani | Admin Blank Page</title>

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

<body class="product" id="page-top">

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

          <c:if test="${productRegisterResult}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
              상품이 등록되었습니다.
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
          </c:if>

          <c:if test="${productRemoveResult}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
              상품이 삭제되었습니다.
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
          </c:if>

          <c:if test="${productModifyResult}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
              상품이 수정되었습니다.
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
          </c:if>

          <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
              <li class="breadcrumb-item"><a href="/admin">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">상품 목록</li>
            </ol>
          </nav>

          <p class="lead text-dark">상품 목록 페이지</p>

          <!-- DataTales Example -->
          <div class="card shadow mb-4">
              <div class="card-header py-3">
                <div class="row">
                  <h6 class="col-sm-3 mt-2 text-dark" style="position: relative; top: 4px;">상품 목록</h6>
                  <div class="col-xl-3 col-md-6 col-sm-9 ml-auto input-group">
                    <input type="text" class="form-control" aria-label="Text input with segmented dropdown button">
                    <div class="input-group-append">
                      <button type="button" class="btn btn-outline-secondary"><i class="fas fa-search"></i></button>
                      <button type="button" class="btn btn-outline-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="sr-only">Toggle Dropdown</span>
                      </button>
                      <div class="dropdown-menu">
                        <a class="dropdown-item" href="#">Search</a>
                        <a class="dropdown-item" href="#">Another action</a>
                        <a class="dropdown-item" href="#">Something else here</a>
                        <div role="separator" class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Separated link</a>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            <div class="card-body">
              <div class="table-responsive table-wrap">
                <table class="table table-striped">
                  <thead>
                    <tr>
                      <th>상품 번호</th>
                      <th>상품 이름</th>
                      <th>상품 가격</th>
                      <th>상품 재고</th>
                      <th>총 판매량</th>
                      <th>진열 여부</th>
                    </tr>
                  </thead>

                  <tbody>
                    <c:forEach var="product" items="${productList}">
                      <tr>
                        <td><a href="/admin/product/${product.prod_no}">${product.prod_no}</a></td>
                        <td class="long-width"><a href="/admin/product/${product.prod_no}"><c:out value="${product.prod_name}"/></a></td>
                        <td><a href="/admin/product/${product.prod_no}">${product.prod_price}</a></td>
                        <td><a href="/admin/product/${product.prod_no}">${product.prod_stock}</a></td>
                        <td><a href="/admin/product/${product.prod_no}">${product.prod_salecount}</a></td>
                        <td><a href="/admin/product/${product.prod_no}">${product.prod_display == 1 ? 'O' : 'X'}</a></td>
                      </tr>
                    </c:forEach>
                  </tbody>
                  
                </table>
                <div class="d-flex flex-wrap justify-content-between">
                  <nav aria-label="Page navigation example">
                    <ul class="pagination">
                      <li class="page-item">
                        <a class="page-link" href="#" aria-label="Previous">
                          <span aria-hidden="true">&laquo;</span>
                          <span class="sr-only">Previous</span>
                        </a>
                      </li>
                      <li class="page-item"><a class="page-link" href="#">1</a></li>
                      <li class="page-item"><a class="page-link" href="#">2</a></li>
                      <li class="page-item"><a class="page-link" href="#">3</a></li>
                      <li class="page-item">
                        <a class="page-link" href="#" aria-label="Next">
                          <span aria-hidden="true">&raquo;</span>
                          <span class="sr-only">Next</span>
                        </a>
                      </li>
                    </ul>
                  </nav>
                  <a href="/admin/product/register"><button class="btn btn-primary float-right">상품 / 카테고리 등록</button></a>
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