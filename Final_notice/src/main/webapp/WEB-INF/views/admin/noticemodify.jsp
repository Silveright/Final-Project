<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>공지사항- 수정</title>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<script src="${pageContext.request.contextPath}/resources/js/noticemodifyform.js"></script>
<style>
#upfile{display:none}

table td {
  position: relative;
}

table td input {
  position: absolute;
  top:0;
  left:0;
  margin: 0;
  height: 100%;
  width: 100%;
  border: none;
}

[readonly]{
  background-color:#fff !important;
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
 .modifyform{
 	margin-top:10%
 }
</style>
</head>
<body>
<form action="modifyaction" method="post" enctype="multipart/form-data" name="modifyform">
	<input type="hidden" name="notice_no" value="${notice.notice_no }">
	<input type="hidden" name= "notice_file" value="${notice.notice_file }">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	<div class="container modifyform">
		<div class="row align-items-center justify-content-center">
			<div class="col-sm-9 ">
				<table class="table table-bordered ">
					<tr>
						<td class="table-active text-center" style="width: 20%">작성자</td>
						<td><input type="text" class="form-control" ReadOnly value="관리자"></td>
					</tr>
					<tr>
						<td class="table-active text-center">제목</td>
						<td><input id="subject" type="text" name="subject" class="form-control" value="${notice.subject }"></td>
					</tr>
					<tr>
						<td colspan="2"><textarea rows="10" cols="50" 
							id="content"	name="content" class="form-control">${notice.content }</textarea></td>
					</tr>
					<tr>
						<td class="table-active text-center">첨부파일</td>
						<td><label for="upfile"> <img src="${pageContext.request.contextPath}/img/attach.png"
								alt="파일첨부" width="20px">
						</label> <input type="file" id="upfile" name="uploadfile" accept="image/*">
						 <span id="filevalue">${notice.notice_file_original}</span>
							<img src="${pageContext.request.contextPath}/img/remove.png" alt="파일삭제" width="10px" class="remove"></td>
					</tr>
				</table>
				<div style="text-align: center">
					<button type="submit" class="btn btn-primary float-right ml-1">수정하기</button>
					<button type="reset" class="btn btn-primary float-right ml-1"
						data-mdb-ripple-color="dark " onClick="history.go(-1)" style="width: 90px">취소</button>
				</div>
			</div>
		</div>
	</div>
	<input id="pass" value="notice" type="hidden" >
	</form>
	<br>
	<br>
	<br>
</body>
</html>