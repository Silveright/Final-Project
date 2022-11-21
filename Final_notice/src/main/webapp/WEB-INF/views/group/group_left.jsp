<%@ page language="java" contentType="text/html; charset=UTF-8"%> 
    
<!-- main contents -->
<style>
body {
  font-family: "Lato", sans-serif;
}

.active{
 color: #064579 !important;
}

.sidenav {
  background-color : rgb(137, 138, 197);
  width: 150px;
  z-index: 1;
  top: 200px;
  left: 100px;
  overflow-x: hidden;
  padding: 8px 0;
  text-align:center;
  position : absolute;
}



.sidenav a {
  padding: 6px 8px 6px 16px;
  text-decoration: none;
  font-size: 25px;
  color:white;
  display: block;
}

.sidenav a:hover {
  color: #064579 !important;
}

.main {
  margin-left: 140px; /* Same width as the sidebar + left position in px */
  font-size: 28px; /* Increased text to enable scrolling */
  padding: 0px 10px;
}

@media screen and (max-height: 450px) {
  .sidenav {padding-top: 15px;}
  .sidenav a {font-size: 18px;}
}
</style>
<!-- Sidebar -->
<div class="sidenav">
 
<a href="${pageContext.request.contextPath}/group/group_detail?num=${group_no}" class="nav-link">모임 메인</a>
<a href="${pageContext.request.contextPath}/group/groupboardlist?group_no=${group_no}" class="nav-link" id="board">게시판</a>
<a href="${pageContext.request.contextPath}/calendar/view?group_no=${group_no}" class="nav-link">일정</a>
<a href="${pageContext.request.contextPath}/group/chatt?group_no=${group_no}" class="nav-link">채팅</a>
<%-- <a href="${pageContext.request.contextPath}/group/groupuserinfo?group_no=${groupdata.group_no}" class="nav-link">회원관리</a> --%>

 
</div>


<script>
$(function(){
	

$(".sidenav>a").each(function() {
    var navItem = $(this);
	console.log("사이드바 "+navItem.attr("href").split('?')[0])
	console.log("경로는"+location.pathname+location.search.split('?')[0])
	console.log("경로는2"+location.pathname+location.search.split('?')[0])
	
	//console.log("포함?"+(location.pathname+location.search.split('?')[0].includes("groupboard"))
	console.log("3"+location.pathname);
	
    if (navItem.attr("href").split('?')[0] == (location.pathname+location.search.split('?')[0])) {
      navItem.addClass("active");
      console.log(navItem.attr("href").split('?')[0]);
    }else  if(location.pathname=='/test/group/groupboardmodifyView' || location.pathname=='/test/group/groupboardwrite'|| location.pathname=='/test/group/groupboarddetail' || location.pathname=='/test/group/groupboardlistsearch'){
    	$("#board").addClass("active");
    	console.log("modifyView")
    }else if(location.pathname=='/test/group/groupuserinfo'){
    	$("#userinfo").addClass("active");
    	console.log("info")
    }else if(location.pathname=='/test/group/groupjoinagree'){
    	$("#groupjoin").addClass("active");
    	console.log("joinagree")
    }
    
 });
})



$.ajax({
    url: "../group/main",
    data: {
        userid: $("#loginid").text(),
        group_no: '${group_no}'
    },
    type: "get",
    async:false,
    success: function (response) {
        authority = response;
        var loginid = $('#loginid').text();
        console.log(response);
        console.log($("#loginid").text())
        if (response.role == '0') { //모임장유저
            str='<a href="${pageContext.request.contextPath}/group/groupuserinfo?group_no=${group_no}&userid='+loginid+'"class="nav-link" id="userinfo">회원관리</a>'
            str+='<a href="${pageContext.request.contextPath}/group/groupjoinagree?group_no=${group_no}" class="nav-link" id="groupjoin">가입승인</a>'	
            		$('.sidenav').append(str);
        }
    },
    error: function (Http, status, error) {
        console.log("Http : " + Http + ", status : " + status + ", error : " + error);
    }
});

</script>
