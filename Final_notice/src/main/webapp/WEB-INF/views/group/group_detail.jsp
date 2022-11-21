<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<style>
a{
    color: #ffffff !important;
}
</style>

<body>
<!-- Header / <head> -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- Close Header / <head> -->
<!-- Start Work Sigle -->
<c:set var="userid" value="${sessionScope.get('userData').userid}"/>

<!-- Start Board SideBar -->

<!-- End Board SideBar -->
<section class="container">

    <%-- 모임 이름 --%>
    
    <div class="row pt-5">
    
        <div class="worksingle-content col-sm-9 m-auto text-left justify-content-center">
        
            <h2 class="worksingle-heading h3 pb-3 light-300 typo-space-line mb-4">
            
                <c:choose>
                    <c:when test="${groupdata.group_no == adminGroup.group_no}">
                        <i class="fas fa-crown m-1"></i><c:out value="${groupdata.group_name}"/>
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-user m-1"></i></i><c:out value="${groupdata.group_name}"/>
                    </c:otherwise>
                </c:choose>
            </h2>
        </div>
    </div>
    
    <%-- 대표 사진, 지역, 관심사--%>
    <div class="row justify-content-center pb-4">
    <div class="col-sm-2 text-center">
				<aside>
					<input type="hidden" id="active" value="${active }">
					<jsp:include page="group_left.jsp" />
				</aside>
			</div>
        <div class="col-sm-9 mt-3 " style="width:500px; margin:0px 360px 0px 140px">
            <h6 class="objective-heading h6 mb-1 text-end light-300">
                <i class="fas fa-map-marker-alt m-3"> <c:out value="${groupdata.area_name}"/></i>
                <i class="fas fa-bookmark m-3"> <c:out value="${groupdata.catename}"/></i>
            </h6>
            <div id="templatemo-slide-link-target" class="card mb-3">
                <c:choose>
                    <c:when test="${empty groupdata.group_img}">
                        <img class="service card-img" src="<spring:url value = '/upload${groupdata.group_img}'/>" alt="Card image">
                    	
                    </c:when>
                    <c:otherwise>
                        <img class="service card-img" src="<spring:url value = '/upload${groupdata.group_img}'/>" alt="Card image">
                    </c:otherwise>
                    
                </c:choose>
            </div>
        </div>
    </div>

    <%-- 회원 수, 소개 글--%>
    <div class="row justify-content-center">
        <div class="col-lg-8 ml-auto mr-auto pt-3 pb-4">
            <h2 class="objective-heading h3 mb-5 mb-sm-4 text-center light-300">
                <button type="button" class="btn btn-outline-primary btn-lg my-md-4" data-bs-toggle="modal" id="modalBtn">
                    회원<i class="bx bx-user bx-lg"></i> : <c:out value="${count}"></c:out> 명
                </button>
            </h2>
            
            <h5 class="objective-heading h5 mb-3 text-center light-300"><p><i class="fas fa-angle-double-left"></i> 모임
                소개 <i class="fas fa-angle-double-right"></i></p></h5>
            <h6 class="text-center h6">
                <c:out value="${groupdata.group_content}"/>
                <%-- <sec:authorize access="isAuthenticated()">
    	 <sec:authentication property="principal" var="pinfo"/>
     		<input type="hidden" id="loginid" name="userid" value="${pinfo.username }">
    	</sec:authorize> --%>
            </h6>
        </div>
    </div>
    <hr>

    <%-- 권한에 따라 다르게 보여지는 버튼 영역 --%>
    <div id="buttonArea" style="text-align: center">
    <!-- <button class="btn btn-success">가입하기</button>
    <button class="btn btn-danger" onclick="history.back()">취소</button> -->
    </div>
    <br>
    <br>

</section>


<!-- Vertically centered scrollable modal -->
<div class="modal fade py-5" id="groupMemberListModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel"> <strong class="text-primary text-decoration-underline"> ${grouplist.group_name}</strong> <i class="bx bxs-user align-text-bottom"></i> 멤버 리스트</h5>
                <button type="button" class="btn btn-lg btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-2 my-2 d-flex flex-column align-items-center">
                <c:forEach items="${groupMemberList}" var="member">
                    <c:set var="imgSrc" value="${member.profile_img}"/>
                    <c:set var="memberId" value="${member.userid}"/>
                    <c:choose>
                        <c:when test="${memberId.equals(groupLeader)}">
                            <div class="team-member row d-flex justify-content-center py-2 order-first w-100">
                        </c:when>
                        <c:otherwise>
                            <div class="team-member row d-flex justify-content-center py-2 w-100">
                        </c:otherwise>
                    </c:choose>
                        <div class="col-4 col-md-4 d-flex align-items-center">
                            <c:choose>
                                <c:when test="${fn:startsWith(imgSrc, 'http')}">
                                    <img class="team-member-img img-fluid img-thumbnail rounded-circle p-2" src="${member.profile_img}" alt="profileImage" style="object-fit: cover; max-width: 110px; min-height: 110px;">
                                </c:when>
                                <c:when test="${fn:contains(imgSrc, memberId)}">
                                    <img class="team-member-img img-fluid img-thumbnail rounded-circle p-2" src="./upload/profileimg/${member.profile_img}" alt="profileImage" style="object-fit: cover; max-width: 110px; min-height: 110px;">
                                </c:when>
                                <c:otherwise>
                                    <img class="team-member-img img-fluid img-thumbnail rounded-circle p-2" src="./assets/img/work-slide-06-small.jpg" alt="profileImage" style="object-fit: cover; max-width: 110px; min-height: 110px;">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-6 col-md-6 text-center">
                            <c:choose>
                                <c:when test="${memberId.equals(groupLeader)}">
                                    <p class="team-member-caption fs-5 py-4 mt-2"><i class="fas fa-crown text-primary"></i> ${member.nickname}</p>
                                </c:when>
                                <c:otherwise>
                                    <p class="team-member-caption fs-5 py-4 mt-2">${member.nickname}</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>


<!-- Start Footer / Script -->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<!-- End Footer / Script -->
<script>
$(function(){
	$("body").on("click","#join a" , function(event){
		
		var a=0;
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
		        if (response >= '3' ) { //가입 모임 수
		        	//return false;
		        	//alert("모임 가입은 3개만 가능합니다.")
		           
		        	a=1;
		        	
		        } else { //모임원유저
		        	$("#join").unbind();
		        	alert("가입 신청 되셨습니다.");
		        } 
		    },
		    error: function (Http, status, error) {
		        console.log("Http : " + Http.status + ", status : " + status + ", error : " + error);
		    }
		});
		
		if(a==1){
			alert("모임 가입은 3개만 가능합니다.")
			event.preventDefault();
		}
		
	})
})
function join(e){
	//event.preventDefault();
		$.ajax({
		    url: "../group/groupcount",
		    data: {
		        userid: $("#loginid").text()
		    },
		    type: "get",
		    success: function (response) {
		        
		        var buttonArea = $('#buttonArea');
		        var loginid = $('#loginid').text();
		        console.log(response);
		        console.log($("#loginid").text())
		        if (response >= '3' ) { //가입 모임 수
		        	//return false;
		        	e.stopPropagation();
		        	alert("모임 가입은 3개만 가능합니다.")
		        } else { //모임원유저
		        	$("#join").unbind();
		        	alert("가입 신청 되셨습니다.");
		        } 
		    },
		    error: function (Http, status, error) {
		        console.log("Http : " + Http + ", status : " + status + ", error : " + error);
		    }
		});
		
		
	/* var answer = confirm("가입 신청 하시겠습니까?");
	console.log(answer); //취소를 클릭한 경우 false
	if(!answer) { //취소를 클릭한 경우
		event.preventDefault(); //이동하지 않습니다.
	}else{
		
		//event.preventDefault();
	} */
}
$("#buttonArea > button:nth-child(2)").click(function(event) {
    var answer = confirm("정말 삭제하시겠습니까?");
    console.log(answer); //취소를 클릭한 경우 false
    if(!answer) { //취소를 클릭한 경우
       event.preventDefault(); //이동하지 않습니다.
    }
 })//삭제 클릭이벤트 end

function joinalert(){
	alert("이미 신청하셨습니다.")
}

function update(){
	 location.href="groupmodifyView?num=${groupdata.group_no}&group_no=${group_no}"
}

function groupdelete(){
	 
	if(confirm("정말 삭제하시겠습니까?")){
		location.href="groupdelete?num=${groupdata.group_no}&group_no=${group_no}"
		alert("모임 삭제가 완료되었습니다.")
	}else{
		return
	}
	// location.href="groupdelete?num=${groupdata.group_no}&group_no=${group_no}"
	 //alert("모임이 삭제되었습니다.")
}




$.ajax({
    url: "../group/main",
    data: {
        userid: $("#loginid").text(),
        group_no: '${groupdata.group_no}'
    },
    type: "get",
    success: function (response) {
        authority = response.role;
        var buttonArea = $('#buttonArea');
        var loginid = $('#loginid').text();
        console.log(response);
        console.log($("#loginid").text())
        if (authority == '0') { //모임장유저
            
        	buttonArea.append("<button onclick='update()' class='banner-button btn rounded-pill btn-primary btn-lg px-4 my-lg-5' style='margin-right: 10px;'>수정하기</button>");
            buttonArea.append("<button onclick='groupdelete()' class='banner-button btn rounded-pill btn-primary btn-lg px-4 my-lg-5'>모임해산</button>");
            
            //modalBtn.attr('data-bs-target', '#groupMemberListModal');
        } else if (authority == '1') { //모임원유저
            buttonArea.append("<button onclick='out()' class='banner-button btn rounded-pill btn-primary btn-lg px-4 my-lg-5'>탈퇴하기</button>");
            //modalBtn.attr('data-bs-target', '#groupMemberListModal');
        } else { //비로그인유저, 모임미가입유저
           if(response.join=='-1'){
        	buttonArea.append('<button type="button" class="banner-button btn rounded-pill btn-primary btn-lg px-4 my-lg-5" id="join"><a href="insert?userid='+loginid+'&group_no=${groupdata.group_no}">가입하기</a></button>');
        	$('aside').remove();    
           }else if(response.join=='1'){
        	   buttonArea.append('<button onclick="joinalert()" class="banner-button btn rounded-pill btn-primary btn-lg px-4 my-lg-5">가입 신청 중...</button>');
           		$('aside').remove();    
           }
        	
        //modalBtn.attr('onclick', 'memberListAlert()');
        }
    },
    error: function (Http, status, error) {
        console.log("Http : " + Http + ", status : " + status + ", error : " + error);
    }
});

</script>
</body>
</html>
