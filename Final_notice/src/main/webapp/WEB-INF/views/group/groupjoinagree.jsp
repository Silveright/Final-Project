<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<style>
a{text-decoration:none; color:black}
</style>
<!-- <script src="js/jquery-3.6.0.js"></script> -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>

</head>
<style>
input{border:1px solid black}
b{font-size:0.9em}
.btn-primary{

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
.table-active {
    --bs-table-accent-bg: #776bcc54  !important;
    color: black !important;
}
footer {
bottom : 0;
width : 100%;
}
</style>
<title>모임 회원 가입 승인 게시판</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
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
            <legend style="text-align:center">가입 승인 게시판</legend>
            <table class="table table-bordered text-center">
               <thead>
                  
                  <tr class="table-active" >
                     <th>번호</th>
                     <th>아이디</th>
                     <th>성별</th>
                     <th>가입일</th>
                     <th>선택</th>
                  </tr>
               </thead>
            </table>
            
            <div class="col-sm-12 text-sm-end">
               <input type="button" class="btn btn-primary" id="accept" value="가입 승인" style="background:rgb(119, 107, 204); border-color:rgb(119, 107, 204)">         
               <input type="button" class="btn btn-danger" style="color:white; background-color: #cd3342cc;" id="disagree" value="가입 거절">         
            </div>   
            
            <div class="center-block">
       <ul class="pagination justify-content-center">
          <c:if test="${page <=1 }"> <!-- 현재 페이지가 1일때 -->
             <li class="page-item">
                <a class="page-link gray">이전&nbsp; </a>
             </li>
          </c:if>
          <c:if test="${page > 1 }"> <!-- 현재 페이지가 1보다 클때 이전을 누르면 현재페이지-1 페이지로 이동 -->
             <li class="page-item">
                <a href="groupjoinagree?page=${page-1 }" 
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
                   <a href="groupjoinagree?page=${a}" 
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
                   <a href ="groupjoinagree?page=${page+1}" 
                   class="page-link">&nbsp;다음 </a>
                </li>
             </c:if>
       </ul>
    </div>
         </div>
      </div>
   </div>
   <script>
$(document).ready(function() { 
   loadRequest(1);
});
var group_no="${group_no}"
    console.log(group_no)
   function go(page){
      var limit = $('#viewcount').val();
      var data = "limit="+ limit + "&state=ajax&page=" + page;
      ajax(data);
   }


   function setPaging(href, digit){
      active ="";
      gray="";
      if(href==""){///href가 빈문자열인 경우
         if(isNaN(digit)){//이전 또는 다음
            gray=" gray";
         }else{
            active=" active";
         }
      }
      var output = "<li class=' page-item" + active + "'>";
      var anchor = "<a class='page-link" + gray + "'" + href +">" + digit + "</a></li>"
      output += anchor;
      return output;
   }


   function loadRequest(data){
      /* var token = $("meta[name='_csrf']").attr("content");
      var header = $("meta[name='_csrf_header']").attr("content"); */
      $.ajax({
         //type: "POST",
         data: {page:data, group_no: group_no},
         /* beforeSend: function(xhr){
                  xhr.setRequestHeader(header, token);
               }, */
         url: "list_ajax",
         dataType: "json",
         cache: false,
         success: function(data){
            
            if(data.listcount > 0){//총 개수가 0보다 큰 경우
               $("tbody").remove();
               var output = "<tbody>";
               $(data.list).each(
                  function(index, item){
               var num = item.rnum;
                     output += '<tr><td>' + num + '</td>'
                     
                     var userid = item.userid;
                     
                     output += '<td><div>'+ userid + '</div></td>'
                     output += '<td><div>'+ item.gender+ '</div></td>'
                     output += '<td><div>'+ item.joindate+ '</div></td>'
                     output += '<td><input type="checkbox" name="selectAgreement" value="'+ userid + '"></td></tr>'
                  })
                  output += "</tbody>"
                  $('table').append(output)//table
                  
                  $(".pagination").empty();
                  output = "";
                  
                  digit = '이전&nbsp;'
                  href="";
                  if(data.page>1){
                     href = 'href=javascript:loadRequest('+(data.page-1)+')';
                  }
                  output +=setPaging(href,digit);
                  for(var i = data.startpage; i<=data.endpage; i++){
                     digit=i;
                     href="";
                     if(i!=data.page){
                        href='href=javascript:loadRequest('+i+')';
                     }
                     output += setPaging(href,digit);
                  }
                     digit="&nbsp;다음&nbsp;";
                     href="";
                     if(data.page<data.maxpage){
                        href='href=javascript:loadRequest('+(data.page+1)+')';
                     }
                     output += setPaging(href,digit);
                     $(".pagination").append(output)
                  
            }else{
            	$("tbody").remove();
            	$("#accept").remove();
            	$("#disagree").remove();
            	$(".pagination").html("가입 신청 인원이 없습니다.");
            	$(".agree").remove();
            }
         },
         error: function(){
            console.log('에러')
         }
      })
   }


      
   $('#accept').click(function (event) {
     
      //$('tbody').children().remove();
        event.preventDefault();
        var requests = [];
        $('input[name=selectAgreement]:checked').each(function () { //체크한 정보 담기
            var chk = $(this).val();
            requests.push(chk);
        });
        console.log(requests);
        var answer = confirm("가입을 승인하시겠습니까?");
      console.log(answer);
      if(answer){
         console.log("승인")
       $.ajax({
            url: "../group/joinAccept",
            dataType: "json",
            data: {
                requestList: requests,
                group_no: group_no//임의로 값 넣었음 나중에 바꾸기
            },
            success: function (data) {
               console.log("가입승인 성공")
               alert("가입 승인되었습니다.")
               loadRequest(1);//새로고침
            },
            error: function (request, status, error) {
                console.log(error)
            }
        }) 
      }
   })
   
   $('#disagree').click(function (event) {
    	     
          //$('tbody').children().remove();
            event.preventDefault();
            var requests = [];
            $('input[name=selectAgreement]:checked').each(function () { //체크한 정보 담기
                var chk = $(this).val();
                requests.push(chk);
            });
            console.log(requests);
            var answer = confirm("가입을 거절하시겠습니까?");
          console.log(answer);
          if(answer){
             console.log("거절")
           $.ajax({
                url: "../group/DisAgree",
                dataType: "json",
                data: {
                    requestList: requests,
                    group_no: group_no//임의로 값 넣었음 나중에 바꾸기
                },
                success: function (data) {
                   console.log("가입거절 성공")
                   alert("가입 거절되었습니다.")
                   loadRequest(1);//새로고침
                },
                error: function (request, status, error) {
                    console.log(error)
                }
           }) 
        }
   })
   
   
</script>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>