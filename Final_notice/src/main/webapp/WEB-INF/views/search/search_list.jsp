<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>search</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
</head>
<body>
<!-- Header/Nav -->
<jsp:include page="../include/header.jsp"></jsp:include>

<!-- Start Banner Hero -->
<div id="work_banner" class="banner-wrapper bg-light w-100 py-0">
	<div class="banner-vertical-center-work container text-light d-flex justify-content-center align-items-center py-5 p-0">
		<div class="banner-content col-lg-8 col-12 m-lg-auto text-center">
			<h1 class="banner-heading h2 display-3 pb-1 semi-bold-600">Search</h1>
			<c:choose>
				<c:when test="${not empty search_keyword}">
					<c:choose>
						<c:when test="${search_field != '전체'}">
							<h3 class="h4 pb-0 regular-400">"${search_field}"지역의 "${search_keyword}"검색 결과 입니다.</h3>
						</c:when>
						<c:otherwise>
							<h3 class="h4 pb-0 regular-400">"전체"지역의 "${search_keyword}"검색 결과 입니다.</h3>
						</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise><!-- search_keyword 입력 안했을 때 -->
					<c:choose>
						<c:when test="${search_field != '전체'}">
							<h3 class="h4 pb-0 regular-400">"${search_field}"지역의 "전체"검색 결과 입니다.</h3>
						</c:when>
						<c:otherwise>
							<h3 class="h4 pb-0 regular-400">"전체"지역의 "전체"검색 결과 입니다.</h3>
						</c:otherwise>
					</c:choose>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>
<section class="container overflow-hidden py-5">
<div class="row gx-5 gx-sm-3 gx-lg-5 gy-lg-5 gy-3 pb-3 projects">
   <c:forEach var="search" items="${searchlist}">
      <!-- Start Recent Work -->
      <div class="col-xl-3 col-md-4 col-sm-6 project all">
         <a href="${pageContext.request.contextPath}/group/group_detail?num=${search.group_no}" class="service-work card border-0 text-white shadow-sm overflow-hidden mx-5 m-sm-0">
            <img class="service card-img" src="<spring:url value = '/upload${search.group_img}'/>" alt="Card image">
            <div class="service-work-vertical card-img-overlay d-flex align-items-end">
               <div class="service-work-content text-left text-light">
                  <span class="btn btn-outline-light rounded-pill mb-lg-3 px-lg-4 light-300">${search.area_name}</span><br>
                  <span class="btn btn-outline-light rounded-pill mb-lg-3 px-lg-4 light-300">${search.group_name}</span>
               </div>
            </div>
         </a>
      </div>
      <!-- End Recent Work -->

   </c:forEach>   
   </div>
</section>
<c:if test="${listcount == 0 && !empty search_keyword}">
	<h1>검색 결과가 없습니다.</h1>
</c:if>
<c:if test="${listcount > 0 }">
	<div class="center-block">
		<ul class="pagination justify-content-center">
			<c:if test="${page <= 1}">
				<li class="page-item">
					<a class="page-link gray">이전&nbsp;</a>
				</li>
			</c:if>
			<c:if test="${page > 1}">
				<li class="page-item">
					<a href="list?page=${page - 1}&search_field=${search_field}&search_keyword=${search_keyword}" 
					   class="page-link">이전&nbsp;</a>
				</li>
			</c:if>
				
			<c:forEach var="a" begin="${startpage}" end="${endpage}">
				<c:if test="${a == page}">
					<li class="page-item active">
						<a class="page-link">${a}</a>
					</li>
				</c:if>
				<c:if test="${a != page}">
					<li class="page-item">
						<a href="list?page=${a}&search_field=${search_field}&search_keyword=${search_keyword}" 
						   class="page-link">${a}</a>
					</li>
				</c:if>
			</c:forEach>
			
			<c:if test="${page >= maxpage}">
				<li class="page-item">
					<a class="page-link gray">&nbsp;다음</a>
				</li>
			</c:if>
			<c:if test="${page < maxpage}">
				<li class="page-item">
					<a href="list?page=${page + 1}&search_field=${search_field}&search_keyword=${search_keyword}" 
					   class="page-link">&nbsp;다음</a>
				</li>
			</c:if>
		</ul>
	</div>
</c:if><%-- <c:if test=${listcount > 0}" > end--%>
<!-- End Banner Hero -->




<!-- Footer -->
<jsp:include page="../include/footer.jsp"></jsp:include>


<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.bundle.min.js"></script>
<!-- Load jQuery require for isotope -->
<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<!-- Isotope -->
<script src="${pageContext.request.contextPath}/resources/js/isotope.pkgd.js"></script>
<!-- Page Script -->
<script>
	$(window).load(function() {
		// init Isotope
		var $projects = $('.projects').isotope({
			itemSelector: '.project',
			layoutMode: 'fitRows'
		});
	
		$(".filter-btn").click(function() {
			var data_filter = $(this).attr("data-filter");
	
			$projects.isotope({
				filter: data_filter
		});

			$(".filter-btn").removeClass("active");
			$(".filter-btn").removeClass("shadow");
			$(this).addClass("active");
			$(this).addClass("shadow");
		return false;
		});
	});
</script>

<!-- Templatemo -->
<script src="${pageContext.request.contextPath}/resources/js/templatemo.js"></script>
<!-- Custom -->
<script src="${pageContext.request.contextPath}/resources/js/custom.js"></script>
</body>
</html>