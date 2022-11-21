<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>회원관리 시스템 회원수정 페이지</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/join.css" type="text/css" rel="stylesheet"/>
<style>
h3 {text-align: center; color: #1a92b9}
input[type=file] {display: none}
</style>
<jsp:include page="../include/header.jsp"/>
</head>
<body>
	<form name="joinform" action="updateProcess" method="post" enctype="multipart/form-data">
		<h3>회원 정보 수정</h3>
		<hr>
		<b>아이디</b>
		<input type = "text" name = "id" value="${memberinfo.userid}" required readonly>
		
		<b>비밀번호</b>
		<input type = "password" name = "pass" value="${memberinfo.password}" required readonly>
			
		<b>이름</b>
		<input type = "text" name = "name" value="${memberinfo.name}" placeholder="Enter name" required>
		
		<b>나이</b>
		<input type = "text" name = "age" value="${memberinfo.age}" maxlength="2" 
				placeholder="Enter age" required>
		
		<b>성별</b>
		<div>
			<input type = "radio" name = "gender" value="남"><span>남자</span>
			<input type = "radio" name = "gender" value="여"><span>여자</span>
		</div>
				
		<b>이메일 주소</b>
		<input type = "text" name = "email" value="${memberinfo.email}" placeholder="Enter email" required>
		<span id="email_message"></span>
		
		<div class="clearfix">
			<button type="submit" class="submitbtn">수정</button>
			<button type="button" class="cancelbtn">취소</button>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
	<script>
	//성별 체크해주는 부분
	$("input[value = '${memberinfo.gender}']").prop('checked', true);
	
	$(".cancelbtn").click(function() {
		history.back();
	});
	
	//처음 화면 로드시 보여줄 이메일은 이미 체크 완료된 것이므로 기본 checkemail = true 입니다.
	var checkemail = true;
	$("input:eq(6)").on('keyup', function() {
		$("#email_message").empty();
		//[A-Za-z0-9_]와 동일한 것이 \w입니다.
		//+는 1회 이상 반복을 의미하고 {1,}과 동일합니다.
		//\w+는 [A-Za-z0-9_]를 1개이상 사용하라는 의미입니다.
		var pattern = /^\w+@\w+[.]\w{3}$/;
		var email = $("input:eq(6)").val();
		if(!pattern.test(email)) {
			$("#email_message").css('color', 'red').html("이메일 형식이 맞지 않습니다.");
			checkemail = false;
		} else {
			$("#email_message").css('color', 'green').html("이메일 형식에 맞습니다.");
			checkemail = true;
		} 
	});//email keyup end
	
	$('form').submit(function() {
		if(!$.isNumeric($("input[name='age']").val())) {
			alert("나이는 숫자를 입력하세요.");
			$("input[name='age']").val('').focus();
			return false;
		}
		
		if(!checkemail) {
			alert("email 형식을 입력하세요.");
			$("input:eq(6)").focus();
			return false;
		}
	}); //submit end
	
	$('input[type=file]').change(function(event){
		var inputfile = $(this).val().split('\\');
		var filename = inputfile[inputfile.length - 1];
		
		var pattern = /(gif|jpg|jpeg|png)$/i; //i(ignore case)는 대소문자 무시를 의미
		
		if(pattern.test(filename)) {
			$('#filename').text(filename); //inputfile.length - 1 = 2
			
			var reader = new FileReader(); //파일을 읽기위한 객체 생성
			//DataURL 형식(접두사 data:가 붙은 URL이며 바이너리 파일을 Base64로 인코딩하여 ASCII 문자열 형식으로 변환한것)으로
			//파일을 읽어옵니다.(참고 - Base64 인코딩은 바이너리 데이터를 Text로 변경하는 Encoding입니다.)
			//네트워크탭에서 실행 후 Headers 확인 해보세요.
			
		
			//읽어온 결과는 reader 객체의 result 속성에 저장됩니다.
			//event.target.files[0] : 선택한 그림의 파일객체에서 첫번째 객체를 가져옵니다.
			reader.readAsDataURL(event.target.files[0]);
			
			reader.onload = function() { //읽기에 성공했을 때 실행되는 이벤트 핸들러
				//$('#showImage').html('<img width="20px" src="' + this.result + '">');
				$('#showImage > img').attr('src', this.result);
			};
		} else {
			alert('이미지 파일(gif, jpg, jpeg, png)이 아닌 경우는 무시됩니다.')
			$('#filename').text('');
			$('#showImage > img').attr('src', 'image/profile.png');
			$(this).val('')
		}
	}) //change() end
	</script>
</body>
</html>