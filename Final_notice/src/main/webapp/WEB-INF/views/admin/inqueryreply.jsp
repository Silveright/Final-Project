<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>공지사항 작성</title>
<!-- <script src="js/jquery-3.6.0.js"></script> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script> 
<script src="${pageContext.request.contextPath}/resources/js/inquerywriteform.js"></script>
</head>
<style>
table td {
  position: relative;
}
#upfile{display:none}

table td input {
  position: absolute;
  top:0;
  left:0;
  margin: 0;
  height: 100%;
  width: 100%;
  border: none;
}
.table-active {
    --bs-table-accent-bg: rgb(119 107 204 / 15%);
    color: var(--bs-table-active-color);
}
.btn-primary {
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
 .writeform{
 	margin-top:10%
 }
</style>
<title>MVC 게시판</title>
</head>

<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	<div class="container writeform">
	<form action="replyaction" method="post" enctype="multipart/form-data" name="noticeform">
	<input type="hidden" name="inquery_re_ref" value="${inquery.inquery_re_ref }">
			<input type="hidden" name="inquery_re_lev" value="${inquery.inquery_re_lev }">
			<input type="hidden" name="inquery_re_seq" value="${inquery.inquery_re_seq }">
	<sec:authorize access="isAuthenticated()">
          <sec:authentication property="principal" var="pinfo"/>
		<div class="row align-items-center justify-content-center">
			<div class="col-sm-9 align-items-center">
				<table class="table table-bordered ">
					<tr>
						<td class="table-active text-center" style="width: 20%">작성자</td>
						<td><input type="text" class="form-control" name="inquery_name" readOnly value="${pinfo.username}" ></td>
					</tr>
					<tr>
						<td class="table-active text-center">제목</td>
						<td><input name="inquery_subject" id="subject" type="text" class="form-control" value="Re:${inquery.inquery_subject }"></td>
					</tr>
					<tr>
						<td colspan="2"><textarea rows="10" cols="50" name="inquery_content" id="content"
								class="form-control"></textarea></td>
					</tr>
					<tr>
						<td class="table-active text-center">비밀번호</td>
						<td><input name="inquery_pass" id="pass" type="password" class="form-control"></td>
					</tr>
				</table>
				<div class="float-end">
						<input type="checkbox" name="inquery_secret" id="input_check" checked/>
						 비밀글
				</div>
				<div style="text-align: center">
					<button type="submit" class="btn btn-primary float-right ml-1">등록하기</button>
					<a href="inquiry"><button type="button" id="cancel" class="btn btn-primary float-right ml-1"
						data-mdb-ripple-color="dark " style="width: 90px">취소</button></a>
				</div>
			</div>
		</div>
		 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		 </sec:authorize>
		</form>
	</div>
	<br>
	<br>
	<br>
	<script>
	$('#input_check').on('change', function(){
		   this.value = this.checked ? 1 : 0;
		   console.log($('#input_check').val());
		}).change();
	</script>
</body>
</html>