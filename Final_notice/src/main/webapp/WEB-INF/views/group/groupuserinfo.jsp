<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="se" uri="http://www.springframework.org/security/tags" %>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!DOCTYPE html>
<html>
<head>
<style>
a{text-decoration:none; color:black}

.table-active {
    --bs-table-accent-bg: #776bcc54  !important;
    color: black !important;
}
footer {
bottom : 0;
width : 100%;
}
</style>
<script>
$(document).ready(function() { 
   //console.log($("body > div > div > div.col-sm-9 > table > tbody > tr:nth-child(1) > td:nth-child(2)").text())
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
		      $("#search").val('');
		      message=["아이디", "지역", "여 또는 남"]
		      $("#search").attr("placeholder", message[selectedValue]+"을 입력하세요")
		   })

   
   //body > div > div > div > table > tbody > tr:nth-child(2) > td:nth-child(6) > button
	$("body > div > div > div.col-sm-9 > table > tbody > tr > td:nth-child(6) > a > input").click(function(event){
		var answer = confirm("정말 강퇴하시겠습니까?");
		console.log(answer);
		if(!answer){
			event.preventDefault();
		}
	})
	
	$("body").on("click", "#roleupdate" , function(event){
		var answer = confirm("정말 위임하시겠습니까?");
		console.log(answer);
		if(!answer){
			event.preventDefault();
		}else{
			
		var a=0;
		var userid=$(this).parent().parent().prev().prev().prev().text();
		console.log("위임 대상은 "+userid)
		$.ajax({
		    url: "../group/groupcount",
		    data: {
		        userid:userid
		    },
		    type: "get",
		    async: false,
		    success: function (response) {
		        
		        if (response >= '3' ) { //가입 모임 수
		        	//return false;
		        	//alert("모임 가입은 3개만 가능합니다.")
		           
		        	a=1;
		        	
		        } else { //모임원유저
		        	$("#roleupdate").unbind();
		        	alert("모임장 위임");
		        } 
		    },
		    error: function (Http, status, error) {
		        console.log("Http : " + Http.status + ", status : " + status + ", error : " + error);
		    }
		});
		
		if(a==1){
			alert("해당 회원은 더이상 모임을 가질 수 없습니다.")
			event.preventDefault();
		}
			
		}
		
	})
	
	
	
   
   });
</script>
</head>
<style>
input{border:1px solid black}
b{font-size:0.9em}

.btn-secondary {
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
    .page-link {
    position: relative;
    display: block;
    padding: var(--bs-pagination-padding-y) var(--bs-pagination-padding-x);
    font-size: var(--bs-pagination-font-size);
    color: #776bcc;
    text-decoration: none;
    background-color: var(--bs-pagination-bg);
    border: var(--bs-pagination-border-width) solid var(--bs-pagination-border-color);
    transition: color .15s ease-in-out,background-color .15s ease-in-out,border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}
.pagination {
    --bs-pagination-padding-x: 0.75rem;
    --bs-pagination-padding-y: 0.375rem;
    --bs-pagination-font-size: 1rem;
    --bs-pagination-color: var(--bs-link-color);
    --bs-pagination-bg: #fff;
    --bs-pagination-border-width: 1px;
    --bs-pagination-border-color: #dee2e6;
    --bs-pagination-border-radius: 0.375rem;
    --bs-pagination-hover-color: var(--bs-link-hover-color);
    --bs-pagination-hover-bg: #e9ecef;
    --bs-pagination-hover-border-color: #dee2e6;
    --bs-pagination-focus-color: var(--bs-link-hover-color);
    --bs-pagination-focus-bg: #e9ecef;
    --bs-pagination-focus-box-shadow: 0 0 0 0.25remrgba(13, 110, 253, 0.25);
    --bs-pagination-active-color: #fff;
    --bs-pagination-active-bg: #776bcc;
    --bs-pagination-active-border-color: #776bcc;
    --bs-pagination-disabled-color: #6c757d;
    --bs-pagination-disabled-bg: #fff;
    --bs-pagination-disabled-border-color: #dee2e6;
    display: flex;
    padding-left: 0;
    list-style: none;
}
.cat{float:right;}

</style>
<title>모임 회원 정보 게시판</title>
</head>
<body>
<br>

   <div class="container" style="height:700px;">

      <div class="row align-items-center justify-content-center">
      <div class="col-sm-2 text-center">
            <aside>
               <input type="hidden" id="active" value="${active }">
               <jsp:include page="group_left.jsp" />
            </aside>
         </div>
         <div class="col-sm-9 ">
         
         <!--  
         <form action="memberinfocat" method="post" class="cat">            
            
            <input type="button" class="btn btn-secondary" value="회원 정보"
                  onclick="location.href='groupuserinfo'">
                  
            <input type="button" class="btn btn-secondary" value="가입 승인"
                  onclick="location.href='groupjoinagree'">      
            
            <input type="button" class="btn btn-secondary" value="모임 해산"
                  onclick="location.href='groupDisband'">
         </form>
         -->
         
         <br>
         <c:if test="${listcount != 0 }">
         <form action="groupuserinfo" method="get">
               <div class="input-group center-block">
               <input type="hidden" name="group_no" value="${param.group_no}"
										id="group_no">
                  <select id="viewcount" name="search_field">
                     <option value="0" selected>아이디</option>
                     <option value="1">지역</option>
                     <option value="2">성별</option>
                  </select>
                  <input id="search" name="search_word" type="text" placeholder="아이디를 입력하세요" value="${search_word }">
                 <se:authentication property="principal" var="pinfo"/>
                  <input type="hidden" name="userid" value=${pinfo.username }>
                  <button class="btn btn-sm btn-outline-secondary search" type="submit"><i class="bx bx-search bx-sm"></i></button>                  
               </div>
         </form>
            <br>
            <legend style="text-align:center">회원 정보 게시판</legend>
            <table class="table table-bordered text-center">
               
                  <colgroup>
                     <col width="10%"/>
                     <col width="30%"/>
                     <col width="30%"/>
                     <col width="10%"/>
                     <col width="12%"/>
                     <col width="8%"/>
                  </colgroup>
               <thead>   
                  <tr class="table-active">
                     <th>번호</th>
                     <th>아이디</th>
                     <th>지역</th>
                     <th>성별</th>
                     <th>모임장위임</th>
                     <th>강퇴</th>
                  </tr>
               </thead>
               
               <se:authentication property="principal" var="pinfo"/>
               <tbody>
                  <c:set var="num" value="${listcount-(page-1)*limit }"/>
                  <c:set var="num2" value="1"/>
                  <c:forEach var="m" items="${memberlist }">
                  <c:if test="${m.userid != pinfo.username}">
                  <tr>
                     <td>
                        <c:out value="${num2}"/>
		                  <c:set var="num2" value="${num2+1 }"/>
                     </td>
                     <td>${m.userid }</td>
                     <td>${m.area_name}</td>
                     <td>${m.gender }</td>

                     <td><a href='grouproleupdate?userid=${m.userid}&group_no=${group_no}&manager=${pinfo.username }'>
                     	 <input type="button" class="btn btn-secondary btn-sm" id="roleupdate" style="color:white" value="모임장 위임"></a></td>
                     <td><a href='groupuserdelete?userid=${m.userid}&group_no=${group_no}'>
                         <input type="button" class="btn btn-danger btn-sm" 
                     			style="color:white" value="회원 강퇴"></a></td>
                  </tr>
                  </c:if>
                  </c:forEach>
               </tbody>
            </table>

            <div class="center-block">
       <ul class="pagination justify-content-center">
          <c:if test="${page <=1 }"> <!-- 현재 페이지가 1일때 -->
             <li class="page-item">
                <a class="page-link gray">이전&nbsp; </a>
             </li>
          </c:if>
          <c:if test="${page > 1 }"> <!-- 현재 페이지가 1보다 클때 이전을 누르면 현재페이지-1 페이지로 이동 -->
             <li class="page-item">
                <a href="groupuserinfo?page=${page-1}&group_no=${group_no}" 
                class="page-link">이전&nbsp; </a>
             </li>
          </c:if>
          
          <c:forEach var="a" begin="${startpage }" end="${endpage }">
             <c:if test="${a==page}"> 
                <li class="page-item active">
                   <a class="page-link">${a } </a>
                </li>
             </c:if>
             <c:if test="${a!=page}"> 
                <li class="page-item">
                   <a href="groupuserinfo?page=${a}&group_no=${group_no}" 
                   class="page-link">${a } </a>
                </li>
             </c:if>
          </c:forEach>
          
             <c:if test="${page >=maxpage}"> 
                <li class="page-item">
                   <a class="page-link gray">&nbsp;다음 </a>
                </li>
             </c:if>
             <c:if test="${page <maxpage}"> 
                <li class="page-item">
                   <a href ="groupuserinfo?page=${page+1}&group_no=${group_no}" 
                   class="page-link">&nbsp;다음 </a>
                </li>
             </c:if>
       </ul>
    </div>
            
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</c:if> 
<c:if test="${listcount==0 }"> 
      <section class="py-5">
       <font size=5>회원이 존재하지 않습니다.</font><br><br>
       <a href="/test/main/list"><button type="button" class="btn btn-secondary float-left back" style="color:white">메인으로</button></a>
       </section>
  </c:if> 
         </div>
      </div>
   
    
   </div>
   <jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>
