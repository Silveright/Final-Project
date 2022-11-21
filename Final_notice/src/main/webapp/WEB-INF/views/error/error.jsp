<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>error.jsp</title>
<style>
b{color:orange}
body{text-align:center}
</style>
</head>
<body>
	<div>
		죄송합니다. <br>
		<img src="${pageContext.request.contextPath}/resources/image/tear3.png" width="100px"><br>
		요청하신 <b>${url}</b>처리에 오류가 발생했습니다.<hr>
		${message}
	</div>
</body>
</html>