<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<style>
a{text-decoration:none; color:black}
</style>
<!-- <script src="js/jquery-3.6.0.js"></script> -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
<script srca="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

</head>
<style>
input{border:1px solid black}
b{font-size:0.9em}

.btn-secondary {
    --bs-btn-color: #fff;
    --bs-btn-bg: #776bcc;
    --bs-btn-border-color: #776bcc;
    --bs-btn-hover-color: #fff;
    --bs-btn-hover-bg: #5646c9;
    --bs-btn-hover-border-color: #776bcc;
    --bs-btn-focus-shadow-rgb: 49,132,253;
    --bs-btn-active-color: #fff;
    --bs-btn-active-bg: #776bcc;
    --bs-btn-active-border-color: #776bcc;
    --bs-btn-active-shadow: inset 0 3px 5pxrgba(0, 0, 0, 0.125);
    --bs-btn-disabled-color: #fff;
    --bs-btn-disabled-bg: #776bcc;
    --bs-btn-disabled-border-color: ##776bcc;}
    .page-link {
    position: relative;
    display: block;
    padding: var(--bs-pagination-padding-y) var(--bs-pagination-padding-x);
    font-size: var(--bs-pagination-font-size);
    color: #776bcc;
    text-decoration: none;
    background-color: var(--bs-pagination-bg);
    border: var(--bs-pagination-border-width) solid var(--bs-pagination-border-color);
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.pagination {
    --bs-pagination-padding-x: 0.75rem;
    --bs-pagination-padding-y: 0.375rem;
    --bs-pagination-font-size: 1rem;
    --bs-pagination-color: var(--bs-link-color);
    --bs-pagination-bg: #fff;
    --bs-pagination-border-width: 1px;
    --bs-pagination-border-color: #dee2e6;
    --bs-pagination-border-radius: 0.375rem;
    --bs-pagination-hover-color: var(--bs-link-hover-color);
    --bs-pagination-hover-bg: #e9ecef;
    --bs-pagination-hover-border-color: #dee2e6;
    --bs-pagination-focus-color: var(--bs-link-hover-color);
    --bs-pagination-focus-bg: #e9ecef;
    --bs-pagination-focus-box-shadow: 0 0 0 0.25remrgba(13, 110, 253, 0.25);
    --bs-pagination-active-color: #fff;
    --bs-pagination-active-bg: #776bcc;
    --bs-pagination-active-border-color: #776bcc;
    --bs-pagination-disabled-color: #6c757d;
    --bs-pagination-disabled-bg: #fff;
    --bs-pagination-disabled-border-color: #dee2e6;
    display: flex;
    padding-left: 0;
    list-style: none;
}
.cat{float:right;}

</style>
<title>모임 자유게시판</title>
</head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<br>

   <div class="container">
   
      <div class="row align-items-center justify-content-center">
      <div class="col-sm-2 text-center">
            <aside>
               <input type="hidden" id="active" value="${active }">
               <jsp:include page="group_left.jsp" />
            </aside>
         </div>
          
         <div class="col-sm-9 ">
         <div class="container">
		<sec:authorize access="isAuthenticated()">
          <sec:authentication property="principal" var="pinfo"/>
		<form action="boardadd" method="post" enctype="multipart/form-data" name="boardform">
			<legend style="text-align:center">게시판 작성 </legend>
			<div class="form-group">
				<label for="board_name">글쓴이</label>
				<input name="BOARD_NAME" id="board_name" value="${pinfo.username}" readonly
						type="text" class="form-control" placeholder="Enter board_name">
			</div>
			<div class="form-group">
				<label for="board_pass">비밀번호</label>
				<input name="BOARD_PASS" id="board_pass" type="password" maxlength="30"
						class="form-control" placeholder="Enter board_pass">			
			</div>
			<div class="form-group">
				<label for="board_subject">제목</label>
				<input name="BOARD_SUBJECT" id="board_subject" type="text" maxlength="100"
						class="form-control" placeholder="Enter board_subject">
			</div>
			<div class="form-group">
				<label for="board_content">내용</label>
				<textarea name="BOARD_CONTENT" id="board_content" rows="10" class="form-control"></textarea>
			</div><br>
			<div class="form-group">
				<label for="BOARD_FILE">파일 첨부</label>
				<label for="upfile">
					<img src="${pageContext.request.contextPath}/resources/img/attach.png" alt="파일첨부" width="25px">
				</label>
				<input type="file" id="upfile" name="uploadfile">
				
				<span id="filevalue"></span>
			<input type="hidden" name="GROUP_NO" value="${group_no }">			
			</div>
			<br>
			<div class="form-group">
				<button type="submit" class="btn btn-primary">등록</button>
				<button type="reset" class="btn btn-danger" onclick="history.back()">취소</button>
			</div>
			<br>
			<br>
			<br>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
		</form>
		</sec:authorize>
	</div>
         </div>
      </div>
    
   </div>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>