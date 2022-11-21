<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		message=["아이디", "지역", "여 또는 남"]
		$("input").attr("placeholder", message[selectedValue]+"을 입력하세요")
	})
	
	});
</script>
</head>
<style>
input{border:1px solid black}
b{font-size:0.9em}
footer{
			bottom:0px; 
			height:3rem;
			background:#ccc;
			width:100%; 
			text-align:center;
			}
			.table-active {
    --bs-table-accent-bg: #776bcc59;
    color: #000000;
}
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
<title>모임 해산 게시판</title>
</head>
<body>
<!-- Header / <head> -->

<br>

	<div class="container">
	
		<div class="row align-items-center justify-content-center">
			<div class="col-sm-2 text-center">
				<aside>
					<input type="hidden" id="active" value="${active }">
					<jsp:include page="group_left.jsp" />
				</aside>
			</div>
			<div class="col-sm-9 ">
			<form action="memberinfocat" method="post" class="cat">				
				
				<input type="button" class="btn btn-secondary" value="회원 정보"
					   onclick="location.href='groupuserinfo'">
					   
				<input type="button" class="btn btn-secondary" value="가입 승인"
					   onclick="location.href='groupjoinagree'">	   
				
				<input type="button" class="btn btn-secondary" value="모임 해산"
					   onclick="location.href='groupDisband'">
			</form>
			
			
			<br>
			<br>
			
				<br>
				<legend style="text-align:center">모임 해산 게시판</legend>
				
				<p class="feature-work-body text-muted light-300 text-center">
                    <br>모임 해산시 해당 정보는 되돌릴 수 없습니다!<br>
                    <br>1) 해당 모임의 활동기록은 사라지게 됩니다.<br>
                    <br>2) 모임에 속해있던 모임원들은 자동으로 모임에서 탈퇴됩니다.<br>
                    <br>3) 모임에서 작성한 게시글은 더이상 볼 수 없게됩니다.<br>
                    <br>4) 모임해산은 되돌릴 수 없습니다!
                    <br>	
                    <br>			

                </p>
		
				
				<div class="col-sm-12 text-sm-center">
					<input type="button" class="btn btn-secondary" value="확인">			
					<input type="button" class="btn btn-secondary" value="취소"
						   onclick='history.go(-1)'>			
				</div>	
				
				
				
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
			</div>
		</div>
	 
	</div>
</body>
<!-- Start Footer / Script -->

</html>