<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
 <%@taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<title>공지사항</title>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.min.js" integrity="sha384-ODmDIVzN+pFdexxHEHFBQH3/9/vQ9uori45z4JjnFsRydbmQbmL5t1tQ0culUzyK" crossorigin="anonymous"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/view.css">
<script src="${pageContext.request.contextPath}/resources/js/view2.js"></script>
<style>
#upfile{display:none}
table td {
  position: relative;
}

table td input {
  position: absolute;
  top:0;
  left:0;
  margin: 0;
  height: 100%;
  width: 100%;
  border: none;
}

[readonly]{
  background-color:#fff !important;
}
.table-active {
    --bs-table-accent-bg: rgb(119 107 204 / 15%);
    color: var(--bs-table-active-color);
}
.btn-primary {
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
 .detailform{
 	margin-top:5%;
 	margin-bottom:10%
 }
 .minheight {
  height: 1000px;
}
</style>
</head>
<title>공지사항-글 보기</title>
</head>
<body>
           <sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal" var="pinfo"/>
				</sec:authorize>
	<input type="hidden" name="num" value="${param.num}" id="comment_inquery_num">
	<div class="container  detailform">
            <hr/>
            <div class="row">
                <div class="col-md">
                    <table class="table table-condensed">
                        <thead>
                            <tr align="center">
                                <th colspan="2"><c:out value="${inquery.inquery_subject}"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th class="table-active">작성일
                                </th>
                                <td>
                                ${inquery.inquery_date}
                                </td>
                            </tr>
                            <tr>
                                <th class="table-active">글쓴이
                                </th>
                                <td>
                                 ${inquery.inquery_name} <span style='float:right'>조회 : ${inquery.inquery_readcount }</span>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <p style="height:500px">${inquery.inquery_content}</p>
                       
                                </td>
                            </tr>
                            <c:if test="${inquery.inquery_re_lev==0}">
				<%--원문글인 경우에만 첨부파일을 추가 할 수 있다. --%>
				<tr>
					<td><div>첨부파일</div></td>
					<c:if test="${!empty inquery.inquery_file }">
					<%--파일 첨부한 경우 --%>
					<td><img src="${pageContext.request.contextPath}/img/down.png" width="10px">
						<form method="post" action="../down" style="height:0px">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
							<input type="hidden" value="${inquery.inquery_file}" name="filename">
							<input type="hidden" value="${inquery.inquery_original}" name="original">
							<input type="submit" value="${inquery.inquery_original}">
							<!-- 다운로드 : 원본파일을 복사하는 것 실제 시스템에 올라간 파일명은 
								 업로드 했을 때 올라간 파일명은 original이 아님
								 중복되지 않도록 관리하기 위해 내부적으로 변경됨
								 다운로드 시 원본에 해당하는 정보는 board_file에 들어가 있고
								 original명 또한 필요하게 됨 -->
						</form></td>
					</c:if>
					<c:if test="${empty inquery.inquery_file}">
						<%--파일첨부하지 않은 경우 --%>
						<td></td>
					</c:if>
				</tr>
			</c:if>
			<tr>
					<td colspan="2" class="text-center">
						<c:choose>
    						<c:when test="${not empty pinfo}">
						<c:if test="${pinfo.username ==inquery.inquery_name  || 'admin' }">
							<a href="inquirymodify?num=${inquery.inquery_num }">
								<button class="btn btn-info">수정</button>
							</a>
							<%-- href의 주소를 #으로 설정 --%>
							<a href="#">
								<button class="btn btn-danger" data-toggle="modal" 
								data-target="#myModal">삭제</button>
							</a>
							</c:if>
							<a href="inquiryreply?num=${inquery.inquery_num }">
								<button class="btn btn-success">답글</button>
							</a>
							</c:when>
							</c:choose>
							<a href="inquiry">
								<button class="btn btn-warning">목록</button>
							</a>
					</td>
				</tr>
                        </tbody>
                    </table>
                    <div class="modal" id="myModal">
 			   <div class="modal-dialog">
      			<div class="modal-content">
		        <!-- Modal body -->
      			  <div class="modal-body">
   					 <form name="deleteForm" action="inquirydelete" method="post">
       					<%--http://localhost:8088/Board/BoardDetailAction.bo?num=22
       						주소를 보면 num을 파라미터로 넘기고 있다.
       						이 값을 가져와 ${param.num}을 사용
       						또는 ${boarddata.board_num}
       						 --%>
       					<input type="hidden" name="num" value="${param.num}" id="comment_board_num">
		     	  <div class="form-group">
		           <label for="pwd">비밀번호</label>
           			<input type="password" 
           					class="form-control" id="pass" 
                  placeholder="Enter password" name="board_pass">
       			  </div>
       			  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          <button type="submit" class="btn btn-primary">전송</button>
          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
    	 </form>
		</div>
       </div>
      </div>
     </div>
                    
                     <div class="comment-area">
                     
			<div class="comment-head">
				<h3 class="comment-count">
					댓글 <sup id="count"></sup><%--superscript(윗첨자) --%>
				</h3>
				<div class="comment-order">
					<ul class="comment-order-list">
					</ul>
				</div>
			</div><!-- comment-head end-->
			<ul class="comment-list">
			</ul>
			<c:if test="${pinfo.username=='admin'&&inquery.cnt==0}">
			<div class="commnet-write">
				<div class="comment-write-area">
					<b class="comment-write-area-name" >${id}</b> <span
						class="comment-write-area-count">0/200</span>
					<textarea placeholder="댓글을 남겨보세요" rows="1"
						class="comment-write-area-text" maxLength="200"></textarea>
					
				</div>
				<div class="register-box" >
					<div class="button btn-cancel" style="background-color:transparent;" >취소</div><%-- 댓글의 취소는 display:none, 등록만 보이도록 합니다.--%>
					<div class="button btn-register" >등록</div>
				</div>
			</div><%--commnet-write end--%>
			</c:if>
			<c:if test="${inquery.cnt!=0&&not empty pinfo}">
			<div class="commnet-write">
				<div class="comment-write-area">
					<b class="comment-write-area-name" >${id}</b> <span
						class="comment-write-area-count">0/200</span>
					<textarea placeholder="댓글을 남겨보세요" rows="1"
						class="comment-write-area-text" maxLength="200"></textarea>
					
				</div>
				<div class="register-box" >
					<div class="button btn-cancel" style="background-color:transparent;" >취소</div><%-- 댓글의 취소는 display:none, 등록만 보이도록 합니다.--%>
					<div class="button btn-register" >등록</div>
				</div>
			</div><%--commnet-write end--%>
			</c:if>
			
		</div><%-- comment-area end--%>
		
		
</div>
            </div>
            <hr/>
        </div>    
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
	<script>
	var result="${result}";
	if(result=='passFail'){
		alert("비밀번호가 일치하지 않습니다.")
	}
	$(function(){
		$("form[action=inquirydelete]").submit(function(){
			if($("#pass").val()==''){
				alert("비밀번호를 입력하세요");
				$("#pass").focus();
				return false;
			}
		})
	})
	</script>
</body>
</html>