<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 정보 수정페이지</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<style>
body {font-family: Arial, Helvetica, sans-serif;box-sizing: border-box;
  margin: 0;
  padding: 0; 
  font-family: Raleway, sans-serif; background: linear-gradient(90deg, #C7C5F4, #776BCC);   }
* {box-sizing: border-box; border-radius: 40px 40px; }

input{border-radius:3px;border:1px solid lightgray}
input[type=text], input[type=password] {
    width: 100%;
    padding: 10px;
    margin: 5px 0 22px 0;
    display: inline-block;
}

input[type=radio]{
	width: 5%;
    display: inline-block;
    border: none;
}

input[type=text]:focus, input[type=password]:focus {
  box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
    outline: none;
}

button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
   
    width: 100%;
    opacity: 0.8;
}

button:hover {
    opacity:1;
     cursor: pointer; 
    
}
button:focus{
   outline:none;
}


.cancelbtn {
    background: #fff;
  font-size: 14px;
  margin-top: 20px;
  padding: 10px 15px;
  border-radius: 26px;
  border: 1px solid #D4D3E8;
  text-transform: uppercase;
  font-weight: 700;
  display: flex;
  align-items: center;
  width: 100%;
  color: #4C489D;
  box-shadow: 0px 2px 2px #5C5696;
  cursor: pointer;
  transition: .2s;
}

.cancelbtn, .submitbtn {
  background: #fff;
  font-size: 14px;
  margin-top: 20px;
  padding: 10px 15px;
  border-radius: 26px;
  border: 1px solid #D4D3E8;
  text-transform: uppercase;
  font-weight: 700;
  display: flex;
  align-items: center;
  width: 100%;
  color: #4C489D;
  box-shadow: 0px 2px 2px #5C5696;
  cursor: pointer;
  transition: .2s;
}

form[name="joinform"] {
    background-color: #fefefe;
    margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
    border: 1px solid lightgray;
    width: 600px; /* Could be more or less, depending on screen size */
    padding: 16px;
    box-shadow: 0 20px 20px rgba(0, 0, 0, .5), 0px 0px 50px rgba(0, 0, 0, .5);
  border-radius: 30px;
}

hr {
    border: 1px solid #f1f1f1;
    margin-bottom: 25px;
}
 
b + div{width: 100%;
    padding: 10px;
    margin: 5px 0 22px 0;
    display: inline-block;
    border: none;
    background: #f1f1f1;}

/* Clear floats */
.clearfix::after {
    content: "";
    clear: both;
    display: table; 
}

h1{text-align:center}

b {
	width: 100%;
	display: block
}

span{display:inline-block;margin-top:-20px;}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
    .cancelbtn, .signupbtn {
       width: 100%;
    }
}
</style>
<script>
	$(function() {
		var checkemail = true;
		
		$("input:eq(0)").on('keyup', function () {
			$("#message").empty(); //처음에 pattern에 적합하지 않은 경우 메시지 출력 후 적합한 데이터를 입력해도 계속 같은
			//[A-Za-z0-9_]의 의미가 \w
			var pattern = /^\w{5,12}$/;
			var id = $("input:eq(0)").val();
			if(!pattern.test(id)) {
				$("#message").css('color', 'red').html("영문자 숫자 _로 5~12자 가능합니다.");
				checkid = false;
				return;
			}
			
		
		});// id keyup end
		
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
		
	})
</script>
</head>
<body>
	<form name="joinform" action="updateProcess" method="post" enctype="multipart/form-data">
		<h1 style="font-style:italic; color:#776BCC;">회원정보 수정</h1>
		<hr>
		<b style="font-style:italic; color:#776BCC;">ID</b>
		<input type = "text" name = "userid" placeholder="Enter id" value="${memberinfo.userid}" readonly maxlength="12" style="margin-bottom:0px">
		<span id="message" style="margin-bottom:0px"></span>
		
		<b style="font-style:italic; color:#776BCC;">Password</b>
		<input type = "password" name = "password" placeholder="Enter password" value="${memberinfo.password}" readonly>
			
		<b style="font-style:italic; color:#776BCC;">Name</b>
		<input type = "text" name = "name" placeholder="Enter name" value="${memberinfo.name}" maxlength="20" required>
		
		<b style="font-style:italic; color:#776BCC;">Age</b>
		<input type = "text" name = "age" maxlength="2" placeholder="Enter age" value="${memberinfo.age}" required>
		
		 <div class="area">
		 <b style="font-style:italic; color:#776BCC;">Area</b>
            <select id="area" name="area_name">
                <option>지역을 선택하세요.</option>
                <option value="서울">서울</option>
                <option value="인천">인천</option>
                <option value="충청도">충청도</option>
                <option value="전라도">전라도</option>
                <option value="부산">부산</option>
                <option value="경상도">경상도</option>
            </select>
            <div id="areaError" class="error"></div>
        </div><br>
		<div>
		<b style="font-style:italic; color:#776BCC;">Gender</b>
			<input type = "radio" name = "gender" value="남"><span style="font-style:italic; color:#776BCC;">남자</span>
			<input type = "radio" name = "gender" value="여"><span style="font-style:italic; color:#776BCC;">여자</span>
		</div>
				
		<b style="font-style:italic; color:#776BCC;">User-Email</b>
		<input type = "text" name = "email" placeholder="Enter email" value="${memberinfo.email}" maxlength="30" required style="margin-bottom:0px">
		<span id="email_message"></span>
		<div class="clearfix">
			<button type="submit" class="submitbtn">Submit</button>
			<button type="submit" class="cancelbtn">Cancel</button>
		</div>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
	<script>
	
	//지역 체크해주는 부분
	$("option[value = '${memberinfo.area_name}']").prop('selected', true);
	
	//성별 체크해주는 부분
	$("input[value = '${memberinfo.gender}']").prop('checked', true);
	
	//지역 체크해주는 부분
	function ChangeValue(){
		var value_str = document.getElementById('select_value');
	}
		
	$(".cancelbtn").click(function() {
		history.back();
	});
	</script>
</body>
</html>