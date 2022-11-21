<%--
  Created by IntelliJ IDEA.
  User: ssyy
  Date: 2021/06/21
  Time: 11:45 오후
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<section class="container pt-5">
    <span style="font-size:30px;cursor:pointer" id="sideBtn" class="shadow-sm" onclick="openNav()">&#9776;</span>
    <div id="mySidenav" class="sidenav shadow">
        <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
        <a href="${pageContext.request.contextPath}/board_main.do?group_no=${group_no}">메인</a>
        <a href="${pageContext.request.contextPath}/board_list.do?group_no=${group_no}">게시판</a>
        <a href="${pageContext.request.contextPath}/board_diary.do?group_no=${group_no}">일정</a>
        <a href="${pageContext.request.contextPath}/board_chatting.do?group_no=${group_no}">채팅</a>
    </div>
    <br>

</section>
<script>
    window.onload = function () {
        var userid = '${sessionScope.get("userData").userid}';
        let authority_ = '';

        if (${not empty pageContext.request.userPrincipal}) {
            $.ajax({
                url: "${pageContext.request.contextPath}/side/authority",
                data: {
                    userid: userid,
                    group_no: "${group_no}"
                },
                type: "get",
                success: function (response_) {
                    authority_ = response_;
                    if (authority_ == '1') {
                        let str = "<a href='${pageContext.request.contextPath}/groupJoin.do?userid=" + userid + "'>모임관리</a>";
                        $('#mySidenav').append(str);
                    }
                }, error: function (Http, status, error) {
                    console.log("Http : " + Http + ", status : " + status + ", error : " + error);
                }
            });
        }
    }

    function openNav() {
        document.getElementById("mySidenav").style.width = "250px";
    }

    function closeNav() {
        document.getElementById("mySidenav").style.width = "0";
    }
</script>
