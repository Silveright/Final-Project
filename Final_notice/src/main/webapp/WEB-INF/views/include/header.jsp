<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="apple-touch-icon" href="${pageContext.request.contextPath}/resources/img/apple-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/img/favicon.ico">
    <!-- Load Require CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/boxicon.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@300;400;600&display=swap" rel="stylesheet">
    <!-- Load Tempalte CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/templatemo.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">
    <!-- Select2 CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/select2.css" rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/resources/css/nice-select.css" rel="stylesheet"/>
    <!-- Sweetalert2 CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/sweetalert2.css" rel="stylesheet"/>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/bootstrap.js"></script>
    <!-- underscore.js -->
    <script src="https://cdn.jsdelivr.net/npm/underscore@1.13.1/underscore-umd-min.js"></script>
    <%--  Font awesome  --%>
    <script src="https://kit.fontawesome.com/c5fd5902bb.js" crossorigin="anonymous"></script>
    <meta name="_csrf" content="${_csrf.token }">
	<meta name="_csrf_header" content="${_csrf.headerName }">
</head>
<!-- Header -->
<nav id="main_nav" class="navbar navbar-expand-lg navbar-light bg-white shadow">
    <div class="container d-flex justify-content-between align-items-center" id="logoBox">
        <se:authorize access="!hasAnyAuthority('ROLE_MEMBER','ROLE_ADMIN')">
            <a class="navbar_logo" href="${pageContext.request.contextPath}/main/list">
                <img src="${pageContext.request.contextPath}/resources/img/final_logo1.png" width="150px"></span>
            </a>
        </se:authorize>
        <se:authorize access="hasAnyAuthority('ROLE_MEMBER','ROLE_ADMIN')">
            <a class="navbar_logo" href="${pageContext.request.contextPath}/main/list">
                <img class="logo_img" src="${pageContext.request.contextPath}/resources/img/final_logo1.png" alt="logo" width="150px">
            </a>
        </se:authorize>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbar-toggler-success" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="align-self-center collapse navbar-collapse flex-grow-1" id="navbar-toggler-success">
            <div class="navbar flex-fill mx-xl-5 d-flex justify-content-center">
                <div class="pe-lg-5" id="nav search">
                    <form class="form-inline" action="${pageContext.request.contextPath}/search/list" 
                    method="get">
                        <div class="input-group input-group-navbar justify-content-center" id="searchGroup">
                            <select name="search_field" class="form-control form-select-sm search" aria-label="Search"
                                    id="search_field" style="width : 80px" >
                                <option>전체</option>
                                <option>서울</option>
								<option>경기</option>
								<option>인천</option>
								<option>강원</option>
								<option>충북</option>
								<option>충남</option>
								<option>대전</option>
								<option>전북</option>
								<option>전남</option>
								<option>광주</option>
								<option>경북</option>
								<option>경남</option>
								<option>대구</option>
								<option>부산</option>
								<option>울산</option>
								<option>제주</option>
                            </select>
                            <input name="search_keyword" id="searchValue" type="search"
                                   class="form-inline form-control form-control-sm"
                                   placeholder="Search…" aria-label="Search"
                                   value="<c:out value="${search_keyword}"></c:out>">
                            <button id="searchButton" class="btn btn-sm btn-outline-secondary" type="submit"><i
                                    class="bx bx-search bx-sm"></i></button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="navbar align-self-center d-flex justify-content-center">
                <se:authorize access="!hasAnyAuthority('ROLE_MEMBER','ROLE_ADMIN')">
                    <a class="navbar-btn btn btn-primary" href="${pageContext.request.contextPath}/member/login"  style="background:rgb(119, 107, 204); border-color:rgb(119, 107, 204)">Login</a>
                </se:authorize>
                <se:authorize access="hasAuthority('ROLE_MEMBER')">
                 <se:authentication property="principal" var="pinfo"/>
                    <span id="loginid">${pinfo.username }</span>님&nbsp;&emsp;|&emsp;
                    <a class="navbar-btn btn btn-primary" href="${pageContext.request.contextPath}/member/update"  style="background:rgb(119, 107, 204); border-color:rgb(119, 107, 204)">MyPage</a>&emsp;|&emsp;


                    <a class="navbar-btn btn btn-primary" href="${pageContext.request.contextPath}/member/logout" id="logout"  style="background:rgb(119, 107, 204); border-color:rgb(119, 107, 204)">Logout</a>
                </se:authorize>
                <se:authorize access="hasAuthority('ROLE_ADMIN')">
                 <se:authentication property="principal" var="pinfo"/>
                    <span id="loginid">${pinfo.username }</span>님&nbsp;&emsp;|&emsp;
                    <a class="navbar-btn btn btn-primary" href="${pageContext.request.contextPath}/admin/dashboard"  style="background:rgb(119, 107, 204); border-color:rgb(119, 107, 204)">Admin</a>&emsp;|&emsp;
                    <a class="navbar-btn btn btn-primary" href="${pageContext.request.contextPath}/member/update"  style="background:rgb(119, 107, 204); border-color:rgb(119, 107, 204)">MyPage</a>&emsp;|&emsp;
                    <a class="navbar-btn btn btn-primary" href="${pageContext.request.contextPath}/member/logout" id="logout" style="background:rgb(119, 107, 204); border-color:rgb(119, 107, 204)">Logout</a>
                </se:authorize>
            </div>
        </div>
    </div>
</nav>
