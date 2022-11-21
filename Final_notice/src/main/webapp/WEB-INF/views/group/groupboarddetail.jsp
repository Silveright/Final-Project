<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<style>
a {
	text-decoration: none;
	color: black
}
</style>
<!-- <script src="js/jquery-3.6.0.js"></script> -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
	integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js"
	integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK"
	crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view.css">
<script>
	var result="${result}";
	if(result == "passFail") {
		alert("비밀번호가 일치하지 않습니다.")
	}
	$(function() {
		$("form[action=delete]").submit(function() {
			if($("#board_pass").val() == '') {
				alert("비밀번호를 입력하세요.");
				$("#board_pass").focus();
				return false;
			}
		})
	})
</script>
</head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<style>

body > div > table > tbody >tr:nth-child(1) {
	text-align: center
}

td:nth-child(1) {
	width: 20%
}

a {
	color: white
}

body > div > table > tbody tr:last-child {
	text-align: center;
}

.btn-primary {
	background-color: #4f97e5
}

#myModal {
	display: none
}

#comment > table > tbody > tr > td:nth-child(2){
 width:50%
}
#count{
    position: relative;
    top: -10px;
    left: -10px;
    background: orange;
    color: white;
    border-radius: 30%;
}

textarea{resize:none}

form[action=down] > input[type=submit]{
    position: relative;
    top: -20px;
    left: 10px;
    border: none;
    cursor : pointer;
}

input {
	border: 1px solid black;
	background: none;
}

b {
	font-size: 0.9em
}

.table-active { -
	-bs-table-accent-bg: #776bcc59 !important;
	color: var(- -bs-table-active-color);
}

.btn-secondary { -
	-bs-btn-color: #fff; -
	-bs-btn-bg: #776bcc; -
	-bs-btn-border-color: #776bcc; -
	-bs-btn-hover-color: #fff; -
	-bs-btn-hover-bg: #5646c9; -
	-bs-btn-hover-border-color: #776bcc; -
	-bs-btn-focus-shadow-rgb: 49, 132, 253; -
	-bs-btn-active-color: #fff; -
	-bs-btn-active-bg: #776bcc; -
	-bs-btn-active-border-color: #776bcc; -
	-bs-btn-active-shadow: inset 0 3px 5pxrgba(0, 0, 0, 0.125); -
	-bs-btn-disabled-color: #fff; -
	-bs-btn-disabled-bg: #776bcc; -
	-bs-btn-disabled-border-color: ##776bcc;
}

.page-link {
	position: relative;
	display: block;
	padding: var(- -bs-pagination-padding-y) var(- -bs-pagination-padding-x);
	font-size: var(- -bs-pagination-font-size);
	color: #776bcc;
	text-decoration: none;
	background-color: var(- -bs-pagination-bg);
	border: var(- -bs-pagination-border-width) solid
		var(- -bs-pagination-border-color);
	transition: color .15s ease-in-out, background-color .15s ease-in-out,
		border-color .15s ease-in-out, box-shadow .15s ease-in-out;
}

.pagination { -
	-bs-pagination-padding-x: 0.75rem; -
	-bs-pagination-padding-y: 0.375rem; -
	-bs-pagination-font-size: 1rem; -
	-bs-pagination-color: var(- -bs-link-color); -
	-bs-pagination-bg: #fff; -
	-bs-pagination-border-width: 1px; -
	-bs-pagination-border-color: #dee2e6; -
	-bs-pagination-border-radius: 0.375rem; -
	-bs-pagination-hover-color: var(- -bs-link-hover-color); -
	-bs-pagination-hover-bg: #e9ecef; -
	-bs-pagination-hover-border-color: #dee2e6; -
	-bs-pagination-focus-color: var(- -bs-link-hover-color); -
	-bs-pagination-focus-bg: #e9ecef; -
	-bs-pagination-focus-box-shadow: 0 0 0 0.25remrgba(13, 110, 253, 0.25);
	-
	-bs-pagination-active-color: #fff; -
	-bs-pagination-active-bg: #776bcc; -
	-bs-pagination-active-border-color: #776bcc; -
	-bs-pagination-disabled-color: #6c757d; -
	-bs-pagination-disabled-bg: #fff; -
	-bs-pagination-disabled-border-color: #dee2e6;
	display: flex;
	padding-left: 0;
	list-style: none;
}

.cat {
	float: right;
}
</style>
<title>모임 자유게시판</title>
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<script src="${pageContext.request.contextPath}/resources/js/view.js"></script>
	<!-- <input type="hidden" id="loginid" value="${id}" name="loginid"> -->
	<div class="container">

		<div class="row align-items-center justify-content-center">
			<div class="col-sm-2 text-center">
				<aside>
					<input type="hidden" id="active" value="${active }">
					<jsp:include page="group_left.jsp" />
				</aside>
			</div>

			<div class="col-sm-9 ">
				<table class="table table-striped">
					<tr>
						<th colspan="2">게시판 상세페이지</th>
					</tr>
					<tr>
						<td><div>작성자</div></td>
						<td><div>${boarddata.BOARD_NAME}</div></td>
					</tr>
					<tr>
						<td><div>제목</div></td>
						<td><c:out value="${boarddata.BOARD_SUBJECT}" /></td>
					</tr>

					<tr>
						<td><div>내용</div></td>
						<td style="padding-right: 0px"><textarea class="form-control"
								rows="5" readOnly>${boarddata.BOARD_CONTENT}</textarea></td>
					</tr>

					<%-- 원문글인 경우에만 첨부파일을 추가 할 수 있습니다. --%>
					<tr>
						<td>
							<div>첨부파일</div>
						</td>
						<c:if test="${!empty boarddata.BOARD_FILE}">
							<%-- 파일첨부한 경우 --%>
							<td><img src="${pageContext.request.contextPath}/resources/img/down.png" width="10px">
								<form method="post" action="down" style="height: 0px">
									<input type="hidden" value="${boarddata.BOARD_FILE}"
										name="filename"> <input type="hidden"
										value="${boarddata.BOARD_ORIGINAL}" name="original">
										<input type="hidden" name="group_no" value="${param.group_no}"
										id="group_no">
										<input
										type="submit" value="${boarddata.BOARD_ORIGINAL}">
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}">	
								</form>
								</td>
						</c:if>
						<c:if test="${empty boarddata.BOARD_FILE}">
							<td></td>
						</c:if>
					</tr>

					<tr>
						<td colspan="2" class="center">
							<button class="btn btn-primary">댓글</button> <span id="count">${count}</span>
							<sec:authorize access="isAuthenticated()">
								<sec:authentication property="principal" var="pinfo" />
								<c:if
									test="${boarddata.BOARD_NAME == pinfo.username || pinfo.username == 'admin'}">
									<a href="groupboardmodifyView?num=${boarddata.BOARD_NUM}&group_no=${group_no}">
										<button class="btn btn-warning">수정</button>
									</a>
									<%-- href의 주소를 #으로 설정합니다. --%>
									<a href="#">
										<button class="btn btn-danger" data-toggle="modal"
											data-target="#myModal">삭제</button>
									</a>
								</c:if>
							</sec:authorize> <a href="replyView?num=${boarddata.BOARD_NUM}">
								
						</a> <a href="groupboardlist?group_no=${group_no}">
								<button class="btn btn-success">목록</button>
						</a>
						</td>
					</tr>
				</table>
				<%-- 게시판 view end --%>

				<%-- modal 시작 --%>
				<div class="modal" id="myModal">
					<div class="modal-dialog">
						<div class="modal-content">
							<%-- Modal body --%>
							<div class="modal-body">
								<form name="deleteForm" action="delete" method="post">
									<%-- http://localhost:8088/Board/BoardDetailAction.bo?num=22
								 주소를 보면 num을 파라미터로 넘기고 있습니다.
								 이 값을 가져와서 ${param.num}를 사용
								 또는 ${boarddata.board_num}
							--%>
									<input type="hidden" name="num" value="${param.num}"
										id="BOARD_NUM">
									<input type="hidden" name="group_no" value="${param.group_no}"
										id="group_no">
									<div class="form-group">
										<label for="pwd">비밀번호</label> <input type="password"
											class="form-control" placeholder="Enter password"
											name="BOARD_PASS" id="board_pass">
									</div>
									<button type="submit" class="btn btn-primary">전송</button>
									<button type="button" class="btn btn-danger"
										data-dismiss="modal">취소</button>
									<input type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}">
								</form>
							</div>
						</div>
					</div>
				</div>
				<%-- id="myModal" end --%>
				<div id="comment">
					<button class="btn btn-info float-left">총 50자까지 가능합니다.</button>
					<button id="write" class="btn btn-info float-right">등록</button><br><br>
					<textarea rows="3" class="form-control" id="content" maxlength="50"></textarea><br>
					<table class="table table striped">
						<thead>
							<tr>
								<td>아이디</td>
								<td>내용</td>
								<td>날짜</td>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
					<div id="message"></div>
				</div>
			</div>
		</div>
		<%--comment-area end --%>
	</div>
	<%--class="container" end --%>
	<jsp:include page="../include/footer.jsp"></jsp:include>
</body>

</html>