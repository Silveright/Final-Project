<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>main</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
</head>
<body>
<!-- Header/Nav -->
<jsp:include page="../include/header.jsp"></jsp:include>

<div class="banner-wrapper bg-light">
        <div id="index_banner" class="banner-vertical-center-index container-fluid pt-5">

            <!-- Start slider -->
            <div id="carouselExampleIndicators" class="carousel slide pointer-event" data-bs-ride="carousel">
                <ol class="carousel-indicators">
                    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></li>
                    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" class=""></li>
                    <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" class=""></li>
                </ol>
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="py-5 row d-flex align-items-center">
                            <div class="banner-content col-lg-8 col-8 offset-2 m-lg-auto text-left py-5 pb-5">
                                <h1 class="banner-heading h1 text-secondary display-3 mb-0 pb-3 mx-0 px-0 light-300">
                                    Meeting!!!
                                </h1>
                                <p class="banner-body text py-3" style="color : white; font-size : 30pt;">
                                    관심사가 맞는 모임을 찾아,
								<br>
									모임 멤버들만의 특별한 공간을 만들어보세요.
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="carousel-item">
                        <div class="py-5 row d-flex align-items-center">
                            <div class="banner-content col-lg-8 col-8 offset-2 m-lg-auto text-left py-5 pb-5">
                                <h1 class="banner-heading h1 text-secondary display-3 mb-0 pb-3 mx-0 px-0 light-300">
                                    Planning!!!
                                </h1>
                                <p class="banner-body text py-3" style="color : white; font-size : 30pt;">
                                    모임 안에서 서로의 일정을 공유하여, 
                                <br>
                                    특별한 만남을 가져보세요.
                                </p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="carousel-item">
                        <div class="py-5 row d-flex align-items-center">
                            <div class="banner-content col-lg-8 col-8 offset-2 m-lg-auto text-left py-5 pb-5">
                                <h1 class="banner-heading h1 text-secondary display-3 mb-0 pb-3 mx-0 px-0 light-300">
                                    Chatting!!!
                                </h1>
                                <p class="banner-body text py-3" style="color : white; font-size : 30pt;">
                                    채팅방 안에서 자유롭게 대화하면서,
								<br>
									재밌는 시간을 가져보세요.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <a class="carousel-control-prev text-decoration-none" href="#carouselExampleIndicators" role="button" data-bs-slide="prev">
                    <i class="bx bx-chevron-left"></i>
                    <span class="visually-hidden">Previous</span>
                </a>
                <a class="carousel-control-next text-decoration-none" href="#carouselExampleIndicators" role="button" data-bs-slide="next">
                    <i class="bx bx-chevron-right"></i>
                    <span class="visually-hidden">Next</span>
                </a>
            </div>
            <!-- End slider -->

        </div>
    </div>

<!-- 로그인 했을 때 보여지는 화면 -->
<se:authorize access="hasAnyAuthority('ROLE_MEMBER','ROLE_ADMIN')">
<section class="bg-secondary service-wrapper py-3">
   <div class="container py-5" >
      <div class="row d-flex justify-content-center text-center">
         <div class="col-lg-2 col-12 text-light align-items-center">
            <span><img src="${pageContext.request.contextPath}/resources/img/group2.png" width="100px"></span>
         </div>
         <div class="col-lg-7 col-12 text-light pt-2">
                <h3 class="h3 regular-400">다양한 모임들을 둘러보고 가입하세요 !</h3>
                <h5 class="h5 regular-400">
                    마음에 드는 모임이 없다면 모임을 만들어보세요 :)
                </h5>
         </div>
         <div class="col-lg-3 col-12 pt-4">
            <a href="${pageContext.request.contextPath}/group/groupMake" id="groupmake"
               class="btn btn-primary rounded-pill btn-block shadow px-4 py-2"  >모임 만들러 가기 => </a>
         </div>
      </div>
   </div>
</section>

<c:if test="${empty usergroup}">
<section class="container overflow-hidden py-5">
	<div class="container-fluid pb-3">
		<div class="row">
			<div class="service-header col-2 col-lg-3">
				<span><img src="${pageContext.request.contextPath}/resources/img/group3.png" width="50px"></span>
				<div class="service-heading col-10 col-lg-9 text-start float-end ">
					<h2 class="h3 pb-4 typo-space-line">&nbsp;가입한 모임</h2>
				</div>
			</div>	
		</div>
	</div>
	
	<div class="container-fluid pb-3">
		<div class="container">
		
		<div class="row gy-5 g-lg-5 mb-4">
			<!-- Start Recent Work -->
			<div class="col-md-4 mb-3">
				<a href="#" class="recent-work card border-0 shadow-lg overflow-hidden">
					<img class="recent-work-img card-img" src="${pageContext.request.contextPath}/resources/img/recent-work-01.jpg" alt="Card image">
					<div class="recent-work-vertical card-img-overlay d-flex align-items-end">
						<div class="recent-work-content text-start mb-3 ml-3 text-dark">
							<h4 class="card-title light-300">가입하신 모임이 없습니다.</h4>
							<p class="card-text">모임을 만들거나 가입해주세요.</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4 mb-3">
				<a href="#" class="recent-work card border-0 shadow-lg overflow-hidden">
					<img class="recent-work-img card-img" src="${pageContext.request.contextPath}/resources/img/recent-work-02.jpg" alt="Card image">
					<div class="recent-work-vertical card-img-overlay d-flex align-items-end">
						<div class="recent-work-content text-start mb-3 ml-3 text-dark">
							<h4 class="card-title light-300">가입하신 모임이 없습니다.</h4>
							<p class="card-text">모임을 만들거나 가입해주세요.</p>
						</div>
					</div>
				</a>
			</div>

			<div class="col-md-4 mb-3">
				<a href="#" class="recent-work card border-0 shadow-lg overflow-hidden">
					<img class="recent-work-img card-img" src="${pageContext.request.contextPath}/resources/img/recent-work-03.jpg" alt="Card image">
					<div class="recent-work-vertical card-img-overlay d-flex align-items-end">
						<div class="recent-work-content text-start mb-3 ml-3 text-dark">
							<h4 class="card-title light-300">가입하신 모임이 없습니다.</h4>
							<p class="card-text">모임을 만들거나 가입해주세요.</p>
						</div>
					</div>
				</a>
			</div>
			<!-- End Recent Work -->
		</div>
		</div>
	</div>
</section>
</c:if>

<c:if test="${!empty usergroup}">
<section class="container overflow-hidden py-5">
   <div class="container-fluid pb-3">
      <div class="row">
         <div class="service-header col-2 col-lg-3">
            <span><img src="${pageContext.request.contextPath}/resources/img/group3.png" width="50px"></span>
            <div class="service-heading col-10 col-lg-9 text-start float-end ">
               <h2 class="h3 pb-4 typo-space-line">&nbsp;가입한 모임</h2>
            </div>
         </div>   
      </div>
   </div>
   
   <div class="container-fluid pb-3">
      <div class="container">
      <div class="row gy-5 g-lg-5 mb-4">
         <c:forEach var="a" items="${usergroup}">
         <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/group/group_detail?num=${a.group_no}" class="recent-work card border-0 shadow-lg overflow-hidden">
               <img class="recent-work-img card-img" src="<spring:url value = '/upload${a.group_img}'/>" alt="Card image">
               <div class="recent-work-vertical card-img-overlay d-flex align-items-end">
                  <div class="recent-work-content text-start mb-3 ml-3 text-dark">
                  <h3 class="card-title light-300">${a.group_name}</h3>
                  <hr>
                  <p class="card-text">${a.group_content}</p>
                  </div>
               </div>
            </a>
         </div>
         </c:forEach>
      </div>
      </div>
   </div>
</section>
</c:if>
</se:authorize>
<!-- 로그인 했을 때 보여지는 화면 끝-->

<section class="bg-secondary service-wrapper py-3">
   <div class="bg-secondary service-tag py-5">
      <div class="bg-secondary col-md-12">
         <ul class="nav d-flex justify-content-center">
            <li class="nav-item mx-lg-4">
               <a class="filter-btn nav-link btn-outline-primary rounded-pill text-light px-4 light-300" href="#" data-filter=".new">NEW</a>
            </li>
            <li class="nav-item mx-lg-4">
               <a class="filter-btn nav-link btn-outline-primary rounded-pill text-light px-4 light-300" href="#" data-filter=".best">BEST</a>
            </li>
            <li class="nav-item mx-lg-4">
               <a class="filter-btn nav-link btn-outline-primary active shadow rounded-pill text-light px-4 light-300" href="#" data-filter=".all">ALL</a>
            </li>
         </ul>
      </div>
   </div>
</section>

<section class="container overflow-hidden py-5">
   <div class="container-fluid pb-3">
      <div class="row">
         <div class="service-header col-2 col-lg-3">
            <span><img src="${pageContext.request.contextPath}/resources/img/group.png" width="50px"></span>
            <div class="service-heading col-10 col-lg-9 text-start float-end ">
               <h2 class="h3 pb-4 typo-space-line">&nbsp;&nbsp;추천&nbsp;모임</h2>
            </div>
         </div>
      </div>
   </div>
   <div class="row gx-5 gx-sm-3 gx-lg-5 gy-lg-5 gy-3 pb-3 projects">
   <c:forEach var="n" items="${newgrouplist}">
      <div class="col-xl-3 col-md-4 col-sm-6 project new ">
         <a href="${pageContext.request.contextPath}/group/group_detail?num=${n.group_no}" onclick="isUser()" class="service-work card border-0 text-white shadow-sm overflow-hidden mx-5 m-sm-0">
            <img class="service card-img" src="<spring:url value = '/upload${n.group_img}'/>" alt="Card image">
            <div class="service-work-vertical card-img-overlay d-flex align-items-end">
               <div class="service-work-content text-left text-light">
                  <span class="btn btn-outline-light rounded-pill mb-lg-3 px-lg-4 light-300">${n.area_name}</span><br>
                  <p class="card-text">${n.group_name}<br>
                  <hr>
                  ${n.group_content}
                  </p>
               </div>
            </div>
         </a>
      </div>
   </c:forEach>
   
   <c:forEach var="b" items="${bestgrouplist}">
      <div class="col-xl-3 col-md-4 col-sm-6 project best">
         <a href="${pageContext.request.contextPath}/group/group_detail?num=${b.group_no}" onclick="isUser()" class="service-work card border-0 text-white shadow-sm overflow-hidden mx-5 m-sm-0">
            <img class="service card-img" src="<spring:url value = '/upload${b.group_img}'/>" alt="Card image">
            <div class="service-work-vertical card-img-overlay d-flex align-items-end">
               <div class="service-work-content text-left text-light">
                  <span class="btn btn-outline-light rounded-pill mb-lg-3 px-lg-4 light-300">${b.area_name}</span><br>
                  <p class="card-text">${b.group_name}<br>
                  <hr>
                  ${b.group_content}
                  </p>
               </div>
            </div>
         </a>
      </div>
   </c:forEach>
   
   <c:forEach var="a" items="${grouplist}">
      <div class="initial-filter-class col-xl-3 col-md-4 col-sm-6 project all">
         <a href="${pageContext.request.contextPath}/group/group_detail?num=${a.group_no}" onclick="isUser()" class="service-work card border-0 text-white shadow-sm overflow-hidden mx-5 m-sm-0">
            <img class="service card-img" src="<spring:url value = '/upload${a.group_img}'/>" alt="Card image">
            <div class="service-work-vertical card-img-overlay d-flex align-items-end">
               <div class="service-work-content text-left text-light">
                  <span class="btn btn-outline-light rounded-pill mb-lg-3 px-lg-4 light-300">${a.area_name}</span><br>
                  <p class="card-text">${a.group_name}<br>
                  <hr>
                  ${a.group_content}
                  </p>
               </div>
            </div>
         </a>
      </div>
   </c:forEach>
   </div>
</section>

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
$(function(){
	var result="${result}";
	console.log(result)
	if(result=='roleupdateSuccess'){
		alert("모임장을 위임했습니다.");
	}
	$("body").on("click","#groupmake" , function(event){
		
		$.ajax({
		    url: "../group/groupcount",
		    data: {
		        userid: $("#loginid").text()
		    },
		    type: "get",
		    async: false,
		    success: function (response) {
		        
		        var buttonArea = $('#buttonArea');
		        var loginid = $('#loginid').text();
		        console.log(response);
		        console.log($("#loginid").text())
		        if (response >= 3) { //가입 모임 수
		        	alert("모임은 3개까지 가능합니다.")
					event.preventDefault();
		           
		        	
		        } else { //모임원유저
		        	//$("#groupmake").unbind();
		        	
		        } 
		    },
		    error: function (Http, status, error) {
		        console.log("Http : " + Http.status + ", status : " + status + ", error : " + error);
		    }
		});
		
		/* if(a==1){
			alert("모임 가입은 3개만 가능합니다.")
			event.preventDefault();
		} */
		
	})
})
   function isUser(){
      if($('#loginid').text()==''){
         alert("로그인이 필요합니다.")
         event.preventDefault();
      }else{
         return true;
      }
   }
   
   $(window).load(function() {
     
      // init Isotope
      var $projects = $('.projects').isotope({
         itemSelector: '.project',
         filter : '.all',
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