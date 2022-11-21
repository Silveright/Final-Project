<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원관리 시스템 회원가입 페이지</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<style type="text/css">

<meta name ="google-signin-client_id" content="582427746869-m0982eg39hgivu9d2oa8vu47gfbop1e0.apps.googleusercontent.com">
@import url('https://fonts.googleapis.com/css?family=Raleway:400,700');

* {
  box-sizing: border-box;
  margin: 0;
  padding: 0; 
  font-family: Raleway, sans-serif;
}
body {
  background: linear-gradient(90deg, #C7C5F4, #776BCC);   
}

.container {
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 100vh;
}

.screen {   
  background: linear-gradient(90deg, #5D54A4, #7C78B8);   
  position: relative; 
  height: 600px;
  width: 360px; 
  box-shadow: 0px 0px 24px #5C5696;
}

.screen__content {
  z-index: 1;
  position: relative; 
  height: 100%;
  
}

.screen__background {   
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 0;
  -webkit-clip-path: inset(0 0 0 0);
  clip-path: inset(0 0 0 0);  
}

.screen__background__shape {
  transform: rotate(45deg);
  position: absolute;
}

.screen__background__shape1 {
  height: 520px;
  width: 520px;
  background: #FFF; 
  top: -50px;
  right: 120px; 
  border-radius: 0 72px 0 0;
}

.screen__background__shape2 {
  height: 220px;
  width: 220px;
  background: #6C63AC;  
  top: -172px;
  right: 0; 
  border-radius: 32px;
}

.screen__background__shape3 {
  height: 540px;
  width: 190px;
  background: linear-gradient(270deg, #5D54A4, #6A679E);
  top: -24px;
  right: 0; 
  border-radius: 32px;
}

.screen__background__shape4 {
  height: 400px;
  width: 200px;
  background: #7E7BB9;  
  top: 420px;
  right: 50px;  
  border-radius: 60px;
}

.login {
  width: 320px;
  padding: 30px;
  padding-top: 120px;
}

.login__field {
  padding: 20px 0px;  
  position: relative; 
}

.login__icon {
  position: absolute;
  top: 30px;
  color: #7875B5;
}

.login__input {
  border: none;
  border-bottom: 2px solid #D1D1D4;
  background: none;
  padding: 10px;
  padding-left: 24px;
  font-weight: 700;
  width: 75%;
  transition: .2s;
}

.login__input:active,
.login__input:focus,
.login__input:hover {
  outline: none;
  border-bottom-color: #6A679E;
}

.login__submit {
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

.login__submit:active,
.login__submit:focus,
.login__submit:hover {
  border-color: #6A679E;
  outline: none;
}

.button__icon {
  font-size: 15px;
  margin-left: auto;
  color: #7875B5;
}

.social-login { 
  position: absolute;
  height: 140px;
  width: 160px;
  text-align: center;
  bottom: 0px;
  right: 0px;
  color: #fff;
}

.social-icons {
  display: flex;
  align-items: center;
  justify-content: center;
}

.social-login__icon {
  padding: 20px 10px;
  color: #fff;
  text-decoration: none;  
  text-shadow: 0px 0px 8px #7875B5;
}

.social-login__icon:hover {
  transform: scale(1.5);  
}
</style>
<script>

Kakao.init('b0aef16567d7b964e3834d1a650e2ba5'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
	
	
	// ajax로 테이블 조회
	
	
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          data: {
      	    property_keys: ['kakao_account.email', 'kakao_account.gender'],
      	  },
          success: function (response) {
        	  console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }

//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
//처음 실행하는 함수
function init() {
	gapi.load('auth2', function() {
		gapi.auth2.init();
		options = new gapi.auth2.SigninOptionsBuilder();
		options.setPrompt('select_account');
        // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
		options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
        // 인스턴스의 함수 호출 - element에 로그인 기능 추가
        // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
		gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
	})
}

if ("${result}" == 'joinSuccess') {
	alert("회원가입을 축하합니다.")
} else if ("${loginfail}" == 'loginFailMsg') {
	alert("아이디나 비밀번호 오류입니다.");
}

$(function() {
	$(".join").click(function() {
		location.href="${pageContext.request.contextPath}/member/join";
	});
})

</script>
</head>
<body>
	<div class="container">
  <div class="screen">
    <div class="screen__content">
    <%-- <img alt="2" src="${pageContext.request.contextPath}/resources/img/final_logo.png" style="width:100px; higth:50px;"> --%>
      <form class="login" action="loginProcess" method="post">
         <div class="login__field">
          <i class="login__icon fas fa-user"></i>
          <input type="text" class="login__input" name="userid" placeholder="User name / Email">
        </div>
        <div class="login__field">
          <i class="login__icon fas fa-lock"></i>
          <input type="password" class="login__input" name="password" placeholder="Password">
          <button class="button login__submit">
          <span class="button__text"onclick="kakaoLogin();">kakao login</span>
          
        </button> 
       
        <button class="button login__submit">
          <span class="button__text"onclick="kakaoLogout();">kakao logout</span>
        </button>
        <button type="submit" class="button login__submit submitbtn">로그인</button>
		<button type="button" class="join button login__submit">회원가입</button>
		</div>
        
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">      
      </form>
      <div class="social-login">
       <!--  <h3>3.3.5.5</h3> -->
      </div>
    </div>
    <div class="screen__background">
      <span class="screen__background__shape screen__background__shape4"></span>
      <span class="screen__background__shape screen__background__shape3"></span>    
      <span class="screen__background__shape screen__background__shape2"></span>
      <span class="screen__background__shape screen__background__shape1"></span>
    </div>    
  </div>
</div>
</body>

</html>