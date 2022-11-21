$(document).ready(function(){
	
	
	$("form[name=noticeform]").submit(function(){
		
		if($.trim($("#pass").val())==""){
			alert("비밀번호를 입력하세요");
			$("#board_pass").focus();
			return false;
		}
		
		if($.trim($("#subject").val())==""){
			alert("제목을 입력하세요");
			$("#subject").focus();
			return false;
		}
		
		if($.trim($("#content").val())==""){
			alert("내용을 입력하세요");
			$("#content").focus();
			return false;
		}
	})
	
	$("#upfile").change(function(){
		console.log($(this).val())
		var inputfile = $(this).val().split('\\');
		$("#filevalue").text(inputfile[inputfile.length-1]);
	});
	
})
