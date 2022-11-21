<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
 <%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
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
 .detailform{
 	margin-top:10%;
 	margin-bottom:10%
 }
 .minheight {
  height: 400px;
}
</style>
</head>
<title>공지사항-글 보기</title>
</head>
<body>
	<div class="container detailform">
		<div class="row align-items-center justify-content-center">
			<div class="col-sm-9 ">
				<table class="table table-bordered ">
					<tr>
						<td class="table-active text-center" style="width: 20%; background-color: #776bcc;color:white">작성자</td>
						<td><input type="text" class="form-control" ReadOnly value="관리자"></td>
					</tr>
					<tr>
						<td class="table-active text-center"  style="background-color: #776bcc;color:white">제목</td>
						<td><input type="text" class="form-control" ReadOnly value="${notice.subject }"></td>
					</tr>
					<tr>
						<td colspan="2" class="minheight"><div id="ta1" style="white-space:pre;"><c:if test="${!empty notice.notice_file }"><img src="<spring:url value = '/upload${notice.notice_file}'/>" alt="Card image" style="width:25%" class="rounded mx-auto d-block"></c:if>${notice.content }
						</div></td>
					</tr>
					<tr>
						<td class="table-active text-center" style="background-color: #776bcc; color:white">첨부파일</td>
						<td>
						<c:if test="${!empty notice.notice_file }">
						<img src="${pageContext.request.contextPath}/img/down.png" width="10px">
						
						<form method="post" action="../down" style="height:0px">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							<input type="hidden" value="${notice.notice_file}" name="filename">
							<input type="hidden" value="${notice.notice_file_original}" name="original">
							<input type="submit" value="${notice.notice_file_original}">
							<!-- 다운로드 : 원본파일을 복사하는 것 실제 시스템에 올라간 파일명은 
								 업로드 했을 때 올라간 파일명은 original이 아님
								 중복되지 않도록 관리하기 위해 내부적으로 변경됨
								 다운로드 시 원본에 해당하는 정보는 board_file에 들어가 있고
								 original명 또한 필요하게 됨 -->
						</form>
						</c:if>
						</td>
					</tr>
				</table>
			 <sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="pinfo"/>
				</sec:authorize>
						<c:choose>
						<c:when test="${!empty pinfo}">
						<c:if test="${pinfo.username == 'admin' }">
					<a href="noticedelete?num=${notice.notice_no }"><button type="button" class="btn btn-primary" style="background-color:rgb(119, 107, 204); border-color:rgb(119, 107, 204)" onclick="noticedelete()">삭제하기</button></a>
					<a href="noticemodify?num=${notice.notice_no }"><button type="button" class="btn btn-primary" style="background-color:rgb(119, 107, 204); border-color:rgb(119, 107, 204)">수정하기</button></a>
				</c:if>
				</c:when>
				</c:choose>
					<button type="button" class="btn btn-primary float-sm-end" style="background-color:rgb(119, 107, 204); border-color:rgb(119, 107, 204)" onclick="history.go(-1)">글목록</button><br><br><br>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
	<script>
		function noticedelete(){
			var answer = confirm("정말 삭제하시겠습니까?");
			if(!answer) { //취소를 클릭한 경우
				event.preventDefault(); //이동하지 않습니다.
			}
		}
	</script>
</body>
</html>