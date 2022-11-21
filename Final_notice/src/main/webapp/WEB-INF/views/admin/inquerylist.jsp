<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<style>
a{text-decoration:none; color:black}
</style>
<!-- <script src="js/jquery-3.6.0.js"></script> -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
<script>
$(document).ready(function() { 
	var result="${result}";
	if(result=='emptyid'){
		alert("문의는 로그인 유저만 가능합니다.")
	}
	
	 var id = $("#loginid").text();
     console.log(id);
     $("#userid").val(id);
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
<title>문의 사항</title>
</head>
<body>
<br>
	<div class="container notice"  style="height:600px; margin-top:10%">
		<div class="row align-items-center justify-content-center">
			<div class="col-sm-9 ">
	<c:if test="${listcount > 0 }">
				<br>
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="pinfo"/>
				</sec:authorize>
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
						<c:forEach var="b" items="${inquirylist }">
				<tr>
					<td><!-- 번호 -->
						<c:out value="${num }"/><!-- num출력 -->
						<c:set var="num" value="${num-1 }"/><!-- num=num-1;의 의미 -->
					</td>
					<td><!-- 제목 -->
					
					
					
					
						<div>
							<c:if test="${b.inquery_re_lev !=0 }"><%-- 답글인 경우 --%>
								<c:forEach var="a" begin="0" end="${b.inquery_re_lev*2 }" step="1">
								&nbsp;
								</c:forEach>
								<img src="${pageContext.request.contextPath}/resources/img/line.png" style="width:20px">
							</c:if>
							
							<c:if test="${b.inquery_re_lev ==0 }"><!-- 원문인 경우 -->
								&nbsp;
							</c:if>
											<c:choose>
												<c:when
													test="${pinfo.username=='admin'&&b.inquery_secret==1||pinfo.username==b.inquery_name&&b.inquery_secret==1||b.inquery_secret==0}">
													<form style="display: inline"
														action="inquirydetail?num=${b.inquery_num }" id="form2"
														method="post">
														<input type="hidden" name="${_csrf.parameterName}"
															value="${_csrf.token}"> <input type="hidden"
															id="userid" name="userid" /> <a href="javascript:;"
															onclick="parentNode.submit();"> <c:if
																test="${b.inquery_subject.length()>=20 }">
																<c:out value="${b.inquery_subject.substring(0,20) }..." />
															</c:if> <c:if test="${b.inquery_subject.length()<20 }">
																<c:out value="${b.inquery_subject }" />
															</c:if>
														</a>
													</form>
													<span class="gray small">[<c:out value="${b.cnt}" />]
													</span>
													<c:if test="${b.cnt>0}">
														<span>[답변완료]</span>
													</c:if>
												</c:when>
												<c:otherwise>
													<img
														src="${pageContext.request.contextPath}/resources/img/lock_icon.png"
														width="10px">비밀글입니다.
					  						    </c:otherwise>
											</c:choose>
										</div>
						</td>
						<td><div>${b.inquery_name }</div></td>
						<td><div>${b.inquery_date }</div></td>
						<td><div>${b.inquery_readcount }</div></td>
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
								<li class="page-item"><a class="page-link" href="inquiry?page=${page-1 }&search_field=${search_field}&search_word=${search_word}"
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
									<c:url var="go" value="inquiry">
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
									<c:url var ="next" value="inquiry">
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
				<form action="inquiry" method="post">
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

	</c:if>
		<c:if test="${listcount==0 }"> 
		<section class="py-5">
 		<font size=5>등록된 문의사항이 없습니다.</font><br><br>
 		</section>
 	</c:if> 
 		<a href="inquerywrite"><button type="button" class="btn btn-secondary float-end back" style="background-color:#776bcc">문의 남기기</button></a>
			</div>
		</div>
	</div>
		<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>