<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<title>공지사항</title>
<style>
a{text-decoration:none !important; color:black}
</style>
<!-- <script src="js/jquery-3.6.0.js"></script> -->
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
		message=["제목", "내용"]
		$("input").attr("placeholder", message[selectedValue]+"을 입력하세요")
	})
	
	});
</script>
</head>
<style>
input{border:1px solid black}
b{font-size:0.9em}

			.table-active {
    --bs-table-accent-bg: #7177eb8c;
    color: #000000;
}
a{text-decoration:none;
color: #4232c2;}
.notice{margin-bottom:10%}
</style>
</head>
<body>
<br>
	<div class="container notice"  style="height:600px; margin-top:10%">
	<c:if test="${listcount > 0 }">
		<div class="row align-items-center justify-content-center">
			<div class="col-sm-9 ">
				<br>

				<table class="table table-bordered">
					<thead>
						<tr class="table-active" >
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="num" value="${listcount-(page-1)*limit }"/>
						<c:forEach var="r" items="${noticelist }"> 
						<tr>
							<td>
								<c:out value="${r.rnum }"/>
								<%-- <c:set var="num" value="${num-1 }"/> --%>
							</td>
							<td>
							<a href="noticedetail?num=${r.notice_no }">
							<%-- <c:if test="${r.subject.length()>=30 }">
							<c:out value="${r.subject.substring(0,30) }..."/>
								</c:if>
								<c:if test="${r.subject.length()<20 }"> --%>
								<c:out value="${r.subject }"/>
								<%-- </c:if> --%>
							</a>
							</td>
							<td>관리자</td>
							<td>${r.writedate }</td>
							<td>${r.readcount }</td>
						</tr>
						</c:forEach> 
					</tbody>
				</table>

				<div class="center-block">
					<div class="container">
						<nav aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
							<c:if test="${page <=1 }"> 
								 <li class="page-item"><a class="page-link" href="#"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li> 
							</c:if>
							<c:if test="${page > 1 }"> 
								<li class="page-item"><a class="page-link" href="noticelist?page=${page-1 }&search_field=${search_field}&search_word=${search_word}"
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
									<c:url var="go" value="noticelist">
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
								<a class="page-link gray"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
								</c:if>
								<c:if test="${page <maxpage}"> 
									<c:url var ="next" value="noticelist">
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
				<form action="noticelist" method="post">
					<div class="input-group">
						<select id="viewcount" name="search_field">
							<option value="0" selected>제목</option>
							<option value="1">내용</option>
						</select>
						 <input id="search" name="search_word" type="text"  placeholder="제목을 입력하세요" value="${search_word }">
						 <button id="searchButton" class="btn btn-sm btn-outline-secondary search" type="submit"><i
                                    class="bx bx-search bx-sm"></i></button>
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>

			</div>
		</div>
	</c:if>
		<c:if test="${listcount==0 }"> 
		<section class="py-5">
 		<font size=5>등록된 공지사항이 없습니다.</font><br><br>
 		<a href="main.net"><button type="button" class="btn btn-secondary float-left back">메인으로</button></a>
 		</section>
 	</c:if> 
	</div>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>