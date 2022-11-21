<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<body>
<!-- Header / <head> -->
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<!-- Close Header / <head> -->
<!-- Start Work Sigle -->
<c:set var="userid" value="${sessionScope.get('userData').userid}"/>

<!-- Start Board SideBar -->
<jsp:include page="board_sidebar.jsp"/>
<!-- End Board SideBar -->

<section class="container">
    <%-- 모임 이름 --%>
    <div class="row pt-5">
        <div class="worksingle-content col-lg-8 m-auto text-left justify-content-center">
            <h2 class="worksingle-heading h3 pb-3 light-300 typo-space-line mb-4">
                <c:choose>
                    <c:when test="${group.group_no == adminGroup.group_no}">
                        <i class="fas fa-crown m-1"></i><c:out value="${group.group_name}"/>
                    </c:when>
                    <c:otherwise>
                        <i class="fas fa-user m-1"></i></i><c:out value="${group.group_name}"/>
                    </c:otherwise>
                </c:choose>
            </h2>
        </div>
    </div>

    <%-- 대표 사진, 지역, 관심사--%>
    <div class="row justify-content-center pb-4">
        <div class="col-lg-5 mt-3">
            <h6 class="objective-heading h6 mb-1 text-end light-300">
                <i class="fas fa-map-marker-alt m-3"> <c:out value="${group.area_name}"/></i>
                <i class="fas fa-bookmark m-3"> <c:out value="${group.catename}"/></i>
            </h6>
            <div id="templatemo-slide-link-target" class="card mb-3">
                <c:choose>
                    <c:when test="${empty group.group_img}">
                        <img class="border rounded card-img-top"
                             src="./assets/img/work-slide-05-small.jpg"
                             style="object-fit: contain; width: content-box;" alt="Card image cap">
                    </c:when>
                    <c:otherwise>
                        <img class="img-fluid border rounded card-img-top"
                             src="./upload/groupimg/${group.group_img}"
                             style="object-fit: contain; width: content-box;" alt="Card image cap">
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <%-- 회원 수, 소개 글--%>
    <div class="row justify-content-center">
        <div class="col-lg-8 ml-auto mr-auto pt-3 pb-4">
            <h2 class="objective-heading h3 mb-5 mb-sm-4 text-center light-300">
                <button type="button" class="btn btn-outline-primary btn-lg my-md-4" data-bs-toggle="modal" id="modalBtn">
                    회원<i class="bx bx-user bx-lg"></i> : <c:out value="${joinUser}"></c:out> 명
                </button>
            </h2>
            <h5 class="objective-heading h5 mb-3 text-center light-300"><p><i class="fas fa-angle-double-left"></i> 모임
                소개 <i class="fas fa-angle-double-right"></i></p></h5>
            <h6 class="text-center h6">
                <c:out value="${group.content}"/>
            </h6>
        </div>
    </div>
    <hr>

    <%-- 권한에 따라 다르게 보여지는 버튼 영역 --%>
    <div id="buttonArea" style="text-align: center">
    </div>
    <br>
    <br>

</section>


<!-- Vertically centered scrollable modal -->
<div class="modal fade py-5" id="groupMemberListModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="staticBackdropLabel"> <strong class="text-primary text-decoration-underline"> ${group.group_name}</strong> <i class="bx bxs-user align-text-bottom"></i> 멤버 리스트</h5>
                <button type="button" class="btn btn-lg btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-2 my-2 d-flex flex-column align-items-center">
                <c:forEach items="${groupMemberList}" var="member">
                    <c:set var="imgSrc" value="${member.profile_img}"/>
                    <c:set var="memberId" value="${member.userid}"/>
                    <c:choose>
                        <c:when test="${memberId.equals(groupLeader)}">
                            <div class="team-member row d-flex justify-content-center py-2 order-first w-100">
                        </c:when>
                        <c:otherwise>
                            <div class="team-member row d-flex justify-content-center py-2 w-100">
                        </c:otherwise>
                    </c:choose>
                        <div class="col-4 col-md-4 d-flex align-items-center">
                            <c:choose>
                                <c:when test="${fn:startsWith(imgSrc, 'http')}">
                                    <img class="team-member-img img-fluid img-thumbnail rounded-circle p-2" src="${member.profile_img}" alt="profileImage" style="object-fit: cover; max-width: 110px; min-height: 110px;">
                                </c:when>
                                <c:when test="${fn:contains(imgSrc, memberId)}">
                                    <img class="team-member-img img-fluid img-thumbnail rounded-circle p-2" src="./upload/profileimg/${member.profile_img}" alt="profileImage" style="object-fit: cover; max-width: 110px; min-height: 110px;">
                                </c:when>
                                <c:otherwise>
                                    <img class="team-member-img img-fluid img-thumbnail rounded-circle p-2" src="./assets/img/work-slide-06-small.jpg" alt="profileImage" style="object-fit: cover; max-width: 110px; min-height: 110px;">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-6 col-md-6 text-center">
                            <c:choose>
                                <c:when test="${memberId.equals(groupLeader)}">
                                    <p class="team-member-caption fs-5 py-4 mt-2"><i class="fas fa-crown text-primary"></i> ${member.nickname}</p>
                                </c:when>
                                <c:otherwise>
                                    <p class="team-member-caption fs-5 py-4 mt-2">${member.nickname}</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>


<!-- Start Footer / Script -->
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
<!-- End Footer / Script -->
<script>
    $(function () {
        openNav();
    });
    var modalBtn = $('#modalBtn');
    var length = ${length}; //모임 가입 전체 개수

    var buttonArea = $('#buttonArea');
    var userid = '${sessionScope.get("userData").userid}';
    var authority = '';
    $.ajax({
        url: "group/main",
        data: {
            userid: userid,
            group_no: '${group.group_no}'
        },
        type: "get",
        success: function (response) {
            authority = response;

            console.log(response);

            if (response == '1') { //모임장유저
                buttonArea.append("<button onclick='update()' class='banner-button btn rounded-pill btn-primary btn-lg px-4 my-lg-5' style='margin-right: 10px;'> 수정하기</button>");
                buttonArea.append("<button onclick='out()' class='banner-button btn rounded-pill btn-primary btn-lg px-4 my-lg-5'>탈퇴하기</button>");
                modalBtn.attr('data-bs-target', '#groupMemberListModal');
            } else if (response == '2') { //모임원유저
                buttonArea.append("<button onclick='out()' class='banner-button btn rounded-pill btn-primary btn-lg px-4 my-lg-5'>탈퇴하기</button>");
                modalBtn.attr('data-bs-target', '#groupMemberListModal');
            } else { //비로그인유저, 모임미가입유저
                buttonArea.append("<button onclick='join()' class='banner-button btn rounded-pill btn-primary btn-lg px-4 my-lg-5'>가입하기</button>");
                modalBtn.attr('onclick', 'memberListAlert()');
            }
        },
        error: function (Http, status, error) {
            console.log("Http : " + Http + ", status : " + status + ", error : " + error);
        }
    });

    function memberListAlert(){
        Swal.fire({
            title: "모임 멤버 리스트",
            text: "모임 멤버만 확인 할 수 있습니다.",
            icon: "error",
            buttons: '확인',
            confirmButtonColor: '#A0A0FF'
        })
    }

    function join() {

        console.log(length);

        if (length >= 3) { //모임 가입 개수 체크
            Swal.fire({
                title: "모임 가입 개수는 3개로 제한됩니다.",
                text: "가입한 모임 탈퇴 후 새로운 모임에 가입할 수 있습니다.",
                confirmButtonText: '마이페이지로 이동',
                confirmButtonColor: '#A0A0FF',
                showCancelButton: true,
                cancelButtonText: '취소',
                cancelButtonColor: '#aaaaaa'
            }).then((result) => {
                if (result.isConfirmed) {
                    location.href = "myPage.do";
                }
            })
        } else {
            if (userid == '') {
                Swal.fire({
                    title: "비로그인 유저입니다.",
                    text: "로그인 후 가입을 진행해 주세요.",
                    icon: "error",
                    buttons: '확인',
                    confirmButtonColor: '#A0A0FF'
                }).then((value) => {
                    if (value) {
                        location.href = 'login';
                    }
                });
            } else {
                let json = {"userid": userid, "group_no": '${group.group_no}'}
                $.ajax({
                    url: "group/insert",
                    dataType: "text",
                    type: "POST",
                    data: JSON.stringify(json),
                    contentType: "application/json; charset=UTF-8",
                    success: function (response) {
                        if (response == "success") {
                            Swal.fire({
                                title: "모임 가입신청이 완료되었습니다.",
                                text: "모임장이 신청을 수락할 때까지 기다려주세요!",
                                confirmButtonColor: '#A0A0FF',
                                response
                            });
                        } else if (response == "warning") {
                            Swal.fire({
                                title: "이미 모임 가입신청이 되어있습니다.",
                                text: "모임장이 신청을 수락할 때까지 기다려주세요!",
                                confirmButtonColor: '#A0A0FF',
                                response
                            });
                        }
                    },
                    error: function (Http, status, error) {
                        console.log("Http : " + Http + ", status : " + status + ", error : " + error);
                        Swal.fire({
                            title: "모임 가입신청에 실패했습니다.",
                            text: "모임 가입신청을 다시 확인해주세요.",
                            confirmButtonColor: '#A0A0FF',
                            error
                        });
                    }
                });
            }
        }

    }

    function out() {
        if (authority == '1') {
            Swal.fire({
                title: "모임장 권한을 가지고 있습니다.",
                text: "탈퇴하시려면 모임장 권한을 양도하고 탈퇴해주세요.",
                icon: "error",
                buttons: '확인',
                confirmButtonColor: '#A0A0FF'
            }).then((value) => {
                if (value) {
                    location.href = 'groupMemberManage.do?userid=' + userid;
                }
            });
        } else {
            let json = {"userid": userid, "group_no": '${group.group_no}'}
            $.ajax({
                url: "group/insert",
                dataType: "text",
                type: "DELETE",
                data: JSON.stringify(json),
                contentType: "application/json; charset=UTF-8",
                success: function (response) {
                    Swal.fire({
                        title: "모임에서 탈퇴되었습니다.",
                        text: "모임에 대한 권한이 사라집니다.",
                        icon: response,
                        buttons: '확인',
                        confirmButtonColor: '#A0A0FF'
                    }).then((value) => {
                        if (value) {
                            location.href = 'index.do';
                        }
                    });
                },
                error: function (Http, status, error) {
                    console.log("Http : " + Http + ", status : " + status + ", error : " + error);
                    Swal.fire({
                        title: "모임 탈퇴에 실패했습니다.",
                        text: "다시 확인해 주세요.",
                        confirmButtonColor: '#A0A0FF',
                        error
                    });
                }
            });
        }
    }

    function update() {
        let groupNo = "${group.group_no}";
        location.href = "groupUpdate.do?group_no=" + groupNo;
    }

</script>
</body>
</html>
