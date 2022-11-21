<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<style>
    td {
        text-align: center;
        /* center checkbox horizontally */
        vertical-align: middle;
        /* center checkbox vertically */
    }

    img {
        width: 50%;
        height: 50%;
        text-align: center;
    }
</style>
<body>
<!-- Header / <head> -->

<!-- Close Header / <head> -->


<!-- Start Feature Work -->
<section class="bg-light py-5 ">

    <c:choose>
        <c:when test="${empty groupJoinRequest}">
            <h1 class="text-center"> 가입신청이 없습니다! </h1>
            <div class="text-center img-fluid">
                <img src="${pageContext.request.contextPath}/upload/chting/groupJoin.jpg" class="rounded" alt="...">
            </div>
        </c:when>
        <c:otherwise>
            <table class="table w-75 text-center m-auto">
                <thead class="table-primary">
                <tr>
                    <th>이름</th>
                    <th>소개</th>
                    <th>성별</th>
                    <th>신청일</th>
                    <th>선택</th>
                </tr>
                </thead>
                <tbody id="joinRequestList">

                </tbody>
            </table>
            <div class="col-lg-8 col-12 m-lg-auto text-center">
                <input type="button" class="banner-button btn rounded-pill btn-accept text-white btn-lg px-4 mt-lg-5 "
                       id="accept" value="가입 승인">
                <input type="button" class="banner-button btn rounded-pill btn-cancel text-white btn-lg px-4 mt-lg-5 "
                       id="refuse" value="가입 거절">
            </div>
        </c:otherwise>
    </c:choose>

</section>
<!-- End Feature Work -->
<div id="footerDiv" style="height: 300px"></div>

</body>
<script type="text/javascript">

    //Table에 회원정보 넣기
    $(document).ready(function () {
        loadRequest();
    });

    //가입신청 Table 생성
    function loadRequest() {

        var tableNum = 0;

        <c:forEach items="${groupJoinRequest}" var="joinRequest">
        (function () {
            $('#joinRequestList').append(
                '<tr>'
                + '<td>${joinRequest.nickname}</td>'
                + '<td>${joinRequest.content}</td>'
                + '<td>${joinRequest.gender}</td>'
                + '<td>${joinRequest.joindate}</td>'
                + '<td>'
                + '<div>'
                + '<input class="form-check-input  m-auto" type="checkbox" id="selectAgreement' + tableNum + '" name="selectAgreement" value="${joinRequest.userid}" >'
                + '<label for="selectAgreement' + tableNum + '"></label>'
                + '</div>'
                + '</td>'
                + '</tr>'
            );
            tableNum++;
        })();
        </c:forEach>
    }


    //체크 후 가입승인 클릭 이벤트
    $(function () {
        $('#accept').click(function (event) {
            event.preventDefault();
            var requests = [];
            $('input[name=selectAgreement]:checked').each(function () { //체크한 정보 담기
                var chk = $(this).val();
                requests.push(chk);
            });
            console.log(requests);

            Swal.fire({
                title: '가입 승인',
                text: "가입을 승인하시겠습니까?",
                icon: 'danger',
                showCancelButton: true,
                confirmButtonColor: '#A0A0FF',
                cancelButtonColor: '#aaaaaa',
                confirmButtonText: '가입을 승인합니다',
                cancelButtonText: '아니오'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/groupadmin/joinAccept.do",
                        dataType: "json",
                        data: {
                            requestList: requests,
                            groupNo: '${group_no}'
                        },
                        success: function (data) {
                            $('#joinRequestList').children().remove();
                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                title: '가입이 승인되었습니다',
                                showConfirmButton: false,
                                timer: 2500
                            });
                            console.log(Object.keys(data).length); // json갯수
                            var tableNum = 0;
                            $.each(data, function (index, item) {
                                $('#joinRequestList').append(
                                    '<tr>'
                                    + '<td>' + item.nickname + '</td>'
                                    + '<td>' + item.content + '</td>'
                                    + '<td>' + item.gender + '</td>'
                                    + '<td>' + item.joindate + '</td>'
                                    + '<td>'
                                    + '<div>'
                                    + '<input type="checkbox" id="selectAgreement' + tableNum + '" name="selectAgreement" value="' + item.userid + '" >'
                                    + '<label for="selectAgreement' + tableNum + '"></label>'
                                    + '</div>'
                                    + '</td>'
                                    + '</tr>'
                                );
                                tableNum++; //테이블 NUM으로 테이블 구분

                            });
                            console.log(requests);
                        },
                        error: function (request, status, error) {
                            console.log(error)
                        }
                    })
                } else {
                    Swal.fire(
                        '취소했습니다',
                        '가입을 승인하지 않았습니다',
                        'error'
                    )
                }
            });
        });
    });

    //체크 후 가입거절절 클릭이벤트, 가입승인 이벤트와 로직은 동일
    $(function () {
        $('#refuse').click(function (event) {
            event.preventDefault();
            var requests = [];
            $('input[name=selectAgreement]:checked').each(function () {
                var chk = $(this).val();
                requests.push(chk);
            });
            console.log(requests);

            Swal.fire({
                title: '가입 거절',
                text: "가입을 거절하시겠습니까?",
                icon: '경고',
                showCancelButton: true,
                confirmButtonColor: '#A0A0FF',
                cancelButtonColor: '#aaaaaa',
                confirmButtonText: '가입을 거절합니다',
                cancelButtonText: '아니오'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/groupadmin/joinDeny.do",
                        dataType: "json",
                        data: {
                            requestList: requests,
                            groupNo: '${groupNo}'
                        },
                        success: function (data) {
                            $('#joinRequestList').children().remove();

                            Swal.fire({
                                position: 'center',
                                icon: 'success',
                                iconColor: 'red',
                                title: '가입이 거절되었습니다',
                                showConfirmButton: false,
                                timer: 2500
                            });

                            var tableNum = 0;
                            $.each(data, function (index, item) {
                                $('#joinRequestList').append(
                                    '<tr>'
                                    + '<td>' + item.nickname + '</td>'
                                    + '<td>' + item.content + '</td>'
                                    + '<td>' + item.gender + '</td>'
                                    + '<td>' + item.joindate + '</td>'
                                    + '<td>'
                                    + '<div>'
                                    + '<input class="form-check-input  m-auto" type="checkbox" id="selectAgreement' + tableNum + '" name="selectAgreement" value="${joinRequest.userid}" >'
                                    + '<label for="selectAgreement' + tableNum + '"></label>'
                                    + '</div>'
                                    + '</td>'
                                    + '</tr>'
                                );
                                tableNum++;
                            });
                        },
                        error: function (request, status, error) {
                            console.log(error)
                        }
                    })
                } else {
                    Swal.fire(
                        '취소했습니다',
                        '가입을 거절하지 않았습니다',
                        'error'
                    )
                }
            })
        });
    });


    function checkEmpty() {

    }

</script>
</html>
