<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
<head>
<link href="${pageContext.request.contextPath}/resources/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">
        <link href="${pageContext.request.contextPath}/resources/admin/css/sb-admin-2.min.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<style>
    .bg-gradient-primary {background-image: linear-gradient(180deg,#776bcc 10%,#adb3c3 100%);}
    .btn-primary{    background-color: #776bcc; border-color: #776bcc}
    .btn-primary:hover{    background-color: #776bcc; border-color: #776bcc; opacity:0.5}
    .btn-link {
    color: #776bcc;}
a{text-decoration:none; color:black}
</style>
<script>
$(document).ready(function() { 
	
	var selectedValue='${search_field}'
	if(selectedValue !='-1')
		$("#viewcount").val(selectedValue);
	
	$(".search").click(function(){
		if($('#search').val()==''){
			alert("검색어를 입력하세요");
			$('input').focus();
			return false;
		}
	})

	
	$("#viewcount").change(function(){
		selectedValue=$(this).val();
		$("input").val('');
		message=["아이디를", "지역을", "여 또는 남을"]
		$("input").attr("placeholder", message[selectedValue]+" 입력하세요")
	})
	
	//body > div > div > div > table > tbody > tr:nth-child(2) > td:nth-child(6) > button
	$("tr>td:nth-child(6)>a").click(function(event){
		var answer = confirm("정말 삭제하시겠습니까?");
		console.log(answer);
		if(!answer){
			event.preventDefault();
		}
	})
	});
</script>
</head>
<title>회원 정보</title>
</head>
<body id="page-top">
	<div id="wrapper">
 <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <!-- <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
                <div class="sidebar-brand-icon ">rotate-n-15
                    <i class="fas fa-laugh-wink">삼삼오오</i>
                </div> -->
                <%-- <div class="sidebar-brand-text mx-3"><img src="${pageContext.request.contextPath}/resources/admin/img/final_logo.png" width="100px></div> --%>
            <!-- </a> -->

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link" href="dashboard">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span></a>
                    
            </li>

            <!-- Divider -->
          <!--   <hr class="sidebar-divider">
 -->
            <!-- Heading -->
           <!--  <div class="sidebar-heading">
                Board
            </div> -->

            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-edit"></i>
                    <span>공지사항</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Notice</h6>
                        <a class="collapse-item" href="noticewrite">작성하기</a>
                        <a class="collapse-item" href="noticelist">공지사항 목록</a>
                    </div>
                </div>
            </li>

           <!--  Nav Item - Utilities Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="inquiry">
                    <i class="fas fa-fw fa-phone"></i>
                    <span>문의처리</span>
                </a>
            </li> 

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Member
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="memberinfo" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages" -->
                    <i class="fas fa-fw fa-users"></i>
                    <span>회원관리</span>
                </a>
               <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">전체 회원</h6>
                        <a class="collapse-item" href="memberinfo">회원 목록</a>
                        <div class="collapse-divider"></div>
                        <h6 class="collapse-header">모임장</h6>
                        <a class="collapse-item" href="groupmanager">모임장 목록</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Charts -->
            <!-- <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>Charts</span></a>
            </li> -->

            <!-- Nav Item - Tables -->
           <!--  <li class="nav-item">
                <a class="nav-link" href="tables.html">
                    <i class="fas fa-fw fa-table"></i>
                    <span>Tables</span></a>
            </li>
 -->
            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

            <!-- Sidebar Message -->
            <%-- <div class="sidebar-card d-none d-lg-flex">
                <img class="sidebar-card-illustration mb-2" src="${pageContext.request.contextPath}/resources/admin/img/undraw_rocket.svg" alt="...">
                <p class="text-center mb-2"><strong>SB Admin Pro</strong> is packed with premium features, components, and more!</p>
                <a class="btn btn-success btn-sm" href="https://startbootstrap.com/theme/sb-admin-pro">Upgrade to Pro!</a>
            </div> --%>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>

                    <!-- Topbar Search -->

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">





                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-between mb-4">
                    <h1 class="h3 mb-2 text-gray-800">회원 정보</h1>
                    <a href="${pageContext.request.contextPath}/main/list" class="d-none d-sm-inline-block btn btn-sm btn-primary shadow-sm"><i
                                class="fas fa-angle-left"></i> 메인화면</a>
                                </div>
                    <!-- <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                        For more information about DataTables, please visit the <a target="_blank"
                            href="https://datatables.net">official DataTables documentation</a>.</p>
 -->
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <c:if test="${listcount > 0 }">
                                
                                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
									<tr class="table-active1">
										<th>번호</th>
										<th>아이디</th>
										<th>지역</th>
										<th>성별</th>
										<th>이메일</th>
										<th>삭제</th>
									</tr>
								</thead>
                                <tbody>
									<c:set var="num" value="${listcount-(page-1)*limit }"/>
									<c:forEach var="m" items="${memberlist }">
									<tr>
										<td>
											<c:out value="${m.rnum }"/>
										</td>
											<td><a href="info?id=${m.userid }">${m.userid }</a></td>
										<td>${m.area_name }</td>
										<td>${m.gender }</td>
										<td>${m.email }</td>
										<!-- <a class="btn" href="/test/member/login" role="button" style="background:#4C489D; color:white">회원삭제</a> -->
										<td style="text-align: center"><a href="delete?userid=${m.userid }" class="btn btn-danger btn-circle"><i class="fas fa-trash"></i></a>
										</td>
									</tr>
									</c:forEach>
								</tbody>
                                
                                
                                
                                </table>
                                <div class="center-block">
								<div class="container">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center">
										<c:if test="${page <=1 }">
											<li class="page-item"><a class="page-link disabled"
												aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
											</a></li>
										</c:if>
										<c:if test="${page >1 }">
											<li class="page-item"><a class="page-link" href="memberinfo?page=${page-1 }&search_field=${search_field}&search_word=${search_word}"
												aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
											</a></li>
										</c:if>
										
										
										
										<c:forEach var="a" begin="${startpage }" end="${endpage }">
											<c:if test="${a==page}">
											<li class="page-item active">
												<a class="page-link">${a }</a>
											</li>
											</c:if>
											<c:if test="${a!=page}">
												<c:url var="go" value="memberinfo">
					 							<c:param name="search_field" value="${search_field}"/>
					 							<c:param name="search_word" value="${search_word }"/>
					 							<c:param name="page" value="${a }"/>
					 							</c:url>
											<li class="page-item">
												<a href="${go}" 
												class="page-link">${a }</a>
											</li>
											</c:if>
										</c:forEach>
											
											<c:if test="${page >=maxpage}">
											<li class="page-item">
											<a class="page-link disabled"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
											</c:if>
											<c:if test="${page <maxpage}">
											<c:url var ="next" value="memberinfo">
							 					<c:param name="search_field" value="${search_field}"/>
							 					<c:param name="search_word" value="${search_word }"/>
							 					<c:param name="page" value="${page+1 }"/>
							 				</c:url>
											<li class="page-item">
											<a class="page-link" href="${next}"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
											</c:if>
										</ul>
									</nav>
								</div>
							</div>
							<form action="memberinfo" method="get">
					<div class="input-group">
						<select id="viewcount" name="search_field">
							<option value="0" selected>아이디</option>
							<option value="1">지역</option>
							<option value="2">성별</option>
						</select>
						 <input id="search" name="search_word" type="text"  placeholder="아이디를 입력하세요" value="${search_word }">
						<button class="btn" class="search" type="submit" style="background:#4C489D; color:white">검색</button>
					</div>
				</form>
                                </c:if>
                                 <c:if test="${listcount==0 }"> 
		<section class="py-5">
 		<font size=5>회원이 존재하지 않습니다.</font><br><br>
 		<a href="main.net"><button type="button" class="btn btn-secondary float-left back">메인으로</button></a>
 		</section>
  </c:if> 
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2020</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->
         <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>


    <!-- Bootstrap core JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/admin/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/admin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${pageContext.request.contextPath}/resources/admin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${pageContext.request.contextPath}/resources/admin/js/sb-admin-2.min.js"></script>


    </div>
    <!-- End of Page Wrapper -->
</body>
</html>