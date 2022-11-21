<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 가입한 모임</title>

<style>
@charset "UTF-8";

*{
	box-sizing: border-box;
}

#chatt{
	width: 800px;
	margin: 20px auto;
}

#chatt #talk{
	width: 800px;
	height: 400px;
	overflow: auto;
}
#chatt #msg{
	width: 740px;
	height:50px;
	display: inline-block;
	border-radius: 8px;
}

#chatt #sendZone > *{
	vertical-align: top;
	
	
}
#chatt #btnSend{
	width: 54px;
	height: 50px;
	background: rgb(119, 107, 204);
	color: white;
	border-radius: 12px;
}

#chatt #talk div{
	width: 70%;
	display: inline-block;
	padding: 6px;
	border-radius:10px;
	
}

#chatt .me{
	background-color : rgb(119, 107, 204);
	margin : 1px 0px 2px 30%;
	color : white;	
}

#chatt .other{
	background-color : #E8D9FF;
	margin : 2px;
}

</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	<div id='chatt'>
	<aside>
		<input type="hidden" id="active" value="${active }">
		<jsp:include page="../group/group_left.jsp" />
	</aside>
		<h1><h1> 채팅방</h1></h1>
		<input type='hidden' id='mid' value='${userid}'>
		
		<br/> 
		<div id='talk'></div>
		<div id='sendZone'>
			<textarea id='msg' ></textarea>
			<input type='button' value='전송' id='btnSend'>
		</div>
	</div>
<script>
function getId(id){
	return document.getElementById(id);
}

var data = {};//전송 데이터(JSON)

var ws ;
//var mid = getId('mid');
//console.log(mid);
//var id=mid.getAttribute('value');
//console.log(id);
var btnLogin = getId('btnLogin');
var btnSend = getId('btnSend');
var talk = getId('talk');
var msg = getId('msg');
 function user(){
	window.onbeforeunload = function() {
    		data.mid = getId('mid').value;
		console.log(data.mid);
		data.msg =data.mid+'님이 퇴장하셨습니다.';
		data.date = new Date().toLocaleString();
		var temp = JSON.stringify(data);
		ws.send(temp);
		ws.close();
    	};	    	
	window.beforeunload = function() {
    		data.mid = getId('mid').value;
		console.log(data.mid);
		data.msg =data.mid+'님이 퇴장하셨습니다.';
		data.date = new Date().toLocaleString();
		var temp = JSON.stringify(data);
		ws.send(temp);
		ws.close();
    	};

    	ws = new WebSocket("ws://" + location.host + "/test/group/chatt?group_no=" + ${group_no});
    	mid.setAttribute("value",mid.value);
    	ws.onopen = function(msg){
    		data.mid = getId('mid').value;
    		console.log(data.mid);
    		data.msg = data.mid+'님이 입장하셨습니다.';
    		data.date = new Date().toLocaleString();
    		var temp = JSON.stringify(data);
    		ws.send(temp);
    	}
    	ws.onclose = function(msg){
    		console.log('onclose실행');
    		data.mid = getId('mid').value;
    		console.log(data.mid);
    		data.msg = '퇴장하셨습니다.';
    		data.date = new Date().toLocaleString();
    		var temp = JSON.stringify(data);
    		ws.send(temp);
    		ws.close();
    	}
    	console.log(mid.value);
    	ws.onmessage = function(msg){
    		var data = JSON.parse(msg.data);
    		console.log(data);
    		var css;
    		console.log(data.mid)
    		if(data.mid == mid.value){
    			css = 'class=me';
    		}else{
    			css = 'class=other';
    		}
		
		var item = "<div " + css + ">"+
		              "<span><b>" + data.mid+  "</b></span>" + "["+ data.date + " ]" + "<br/>"
                   +   "<span>" + data.msg + "</span></div>";
		console.log(item)			
		talk.innerHTML += item;
		talk.scrollTop=talk.scrollHeight;//스크롤바 하단으로 이동
	}
}
 
 user();

msg.onkeyup = function(ev){
	if(ev.keyCode == 13){
		send();
	}
}

btnSend.onclick = function(){
	send();
}

function send(){
	if(msg.value.trim() != ''){
		data.mid = getId('mid').value;
		data.msg = msg.value;
		data.date = new Date().toLocaleString();
		var temp = JSON.stringify(data);
		ws.send(temp);
	}
	msg.value ='';
	
}
</script>
</body>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</html>
