<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
<title>모임 생성</title>
<body>
<jsp:include page="../include/header.jsp"/>

<section class="bg-light w-100">
    <div class="container">
        <div class="row d-flex align-items-center py-5">
            <div class="col-lg-6 text-start">
                <h1 class="h2 py-5 text-primary typo-space-line">3.3.5.5. 모임 만들기</h1>
                <p class="light-300">
                    지역과 관심사를 선택하고 마음이 맞는 사람들과 함께 취미 활동을 해보세요 !
                </p>
            </div>
            <div class="col-lg-6">
                <img src="${pageContext.request.contextPath}/resources/img/banner-img-02.svg">
            </div>
        </div>
    </div>
</section>
<section class="container my-lg-5">
    <form id="groupMakeFrm" method="POST" action='add' enctype="multipart/form-data">
        <input type="hidden" name="userid" value="${userid}">
        <input type="hidden" name="groupNo" value="${group_no}">

        <div class="service-wrapper py-3">
            <%-- 모임 대표 사진 --%>
            <div class="pricing-list shadow-sm rounded-top rounded-3 py-sm-0 py-5">
                <div class="row p-2">
                    <div class="pricing-list-icon col-3 text-center m-auto text-secondary ml-5 py-2">
                        <i class="display-3 bx bx-image-add"></i>
                        <p>대표 사진</p>
                    </div>
                    <div class="pricing-list-body col-md-5 align-items-center pl-3 pt-2">
                        <ul class="list-unstyled text-center light-300">
                            <div class="form-floating mb-4">
                                <c:choose>
                                    <c:when test="${not empty group_img}">
                                        <img class="img-fluid border rounded" id="preview"
                                             src="${group_img}"
                                             style="width:250px; height:250px; margin-bottom: 10px;">
                                    </c:when>
                                    <c:otherwise>
                                        <img class="img-fluid border rounded" id="preview"
                                             src="${pageContext.request.contextPath}/resources/img/work-slide-05-small.jpg"
                                             style="width:250px; height:250px; margin-bottom: 10px;">
                                    </c:otherwise>
                                </c:choose>
                                <div class="input-group">
                                    <input type="file" class="form-control" id="fileName" name="uploadfile"
                                           aria-describedby="inputGroupFileAddon04"
                                           aria-label="Upload" accept="image/*;capture=camera">
                                </div>
                            </div>
                        </ul>
                    </div>
                    <div class="pricing-list-footer col-4 text-center m-auto align-items-center">
                    </div>
                </div>
            </div>

            <%-- 모임 이름 --%>
            <div class="pricing-list shadow-sm rounded-top rounded-3 py-sm-0 py-5">
                <div class="row p-2">
                    <div class="pricing-list-icon col-3 text-center m-auto text-secondary ml-5 py-2">
                        <i class="display-3 bx bx-edit"></i>
                        <p>모임 이름</p>
                    </div>
                    <div class="pricing-list-body col-9 align-items-center pl-3 pt-2 pe-4">
                        <ul class="list-unstyled text-center light-300">
                            <div class="form-floating mb-4">
                        <textarea name="group_name" id="group_name" class="form-control form-control-lg light-300"
                                  style="resize: none; width: border-box; height: 100px; "
                                  placeholder="4 ~ 20자 이내로 입력해 주세요."></textarea>
                                <label for="group_name">4 ~ 20자 이내로 입력해 주세요.</label>
                                <p align="left" id="groupNameKeyUp"></p>

                            </div>
                        </ul>
                    </div>
                    <div class="pricing-list-footer col-4 text-center m-auto align-items-center">
                    </div>
                </div>
            </div>

            <%-- 모임 소개글 --%>
            <div class="pricing-list shadow-sm rounded-top rounded-3 py-sm-0 py-5">
                <div class="row p-2">
                    <div class="pricing-list-icon col-3 text-center m-auto text-secondary ml-5 py-2">
                        <i class="display-3 bx bx-edit"></i>
                        <p>모임 소개</p>
                    </div>

                    <div class="pricing-list-body col-9 align-items-center pl-3 pt-2 pe-4">
                        <ul class="list-unstyled text-center light-300">
                            <div class="form-floating mb-4">
                        <textarea name="group_content" id="content" class="form-control form-control-lg light-300"
                                  style="resize: none; width: border-box; height: 300px;"
                                  placeholder="10 ~ 1000자 이내로 입력해 주세요."></textarea>
                                <label for="content">10 ~ 1000자 이내로 입력해 주세요.</label>
                                <p align="left" id="contentKeyUp"></p>
                            </div>
                        </ul>
                    </div>
                    <div class="pricing-list-footer col-4 text-center m-auto align-items-center">
                    </div>
                </div>
            </div>

            <%-- 관심사 --%>
            <div class="pricing-list shadow-sm rounded-top rounded-3 py-sm-0 py-5">
                <div class="row p-2">
                    <div class="pricing-list-icon col-3 text-center m-auto text-secondary ml-5 py-2">
                        <i class="display-3 bx bx-category-alt"></i>
                        <p>관심사</p>
                    </div>
                    <div class="pricing-list-body col-9 align-items-center py-5">
                        <select name="catename" id="catename" class="form-select" style="width: 30vh; float:left;">
                            <option value="" selected disabled hidden>=== 관심사를 선택하세요 ===</option>
							<option value="음악">음악</option>
			                <option value="운동">운동</option>
			                <option value="독서">독서</option>
			                <option value="공부">공부</option>
			                <option value="게임">게임</option>
			                <option value="낚시">낚시</option>
                        </select>
                    </div>
                    <div class="pricing-list-footer col-4 text-center m-auto align-items-center">
                    </div>
                </div>
            </div>

            <%-- 지역 --%>
            <div class="pricing-list shadow-sm rounded-top rounded-3 py-sm-0 py-5">
                <div class="row p-2">
                    <div class="pricing-list-icon col-3 text-center m-auto text-secondary ml-5 py-2">
                        <i class="display-3 bx bx-location-plus"></i>
                        <p>지역</p>
                    </div>
                    <div class="pricing-list-body col-9 align-items-center py-5">
                        <select name="area_name" id="area_name" class="form-select" style="width: 30vh; float:left;">
                            <option value="" selected disabled hidden>=== 지역을 선택하세요 ===</option>
							<option value="서울">서울</option>
							<option value="경기">경기</option>
			                <option value="인천">인천</option>
			                <option value="강원">강원</option>
			                <option value="충북">충북</option>
			                <option value="충남">충남</option>
			                <option value="대전">대전</option>
			                <option value="전북">전북</option>
			                <option value="전남">전남</option>
			                <option value="광주">광주</option>
			                <option value="경북">경북</option>
			                <option value="경남">경남</option>
			                <option value="경남">대구</option>
			                <option value="부산">부산</option>
			                <option value="울산">울산</option>
			                <option value="제주">제주</option>
                        </select>
                    </div>
                    <div class="pricing-list-footer col-4 text-center m-auto align-items-center">
                    </div>
                </div>
            </div>

            <%-- 완료 --%>
            <div class="pricing-list shadow-sm rounded-top rounded-3 py-sm-0 py-5">
                <div class="row p-2">
                    <div class="col-md-12 col-12 my-5 text-center">
                        <input type="button" onclick="confirm()" value="완료" id="groupmake"
                               class="btn btn-secondary rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">
                    	<input type="button" onclick="history.go(-1)" value="취소" id="groupmodify"
                               class="btn btn-secondary rounded-pill px-md-5 px-4 py-2 radius-0 text-light light-300">
                    </div>
                </div>
            </div>
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <sec:authorize access="isAuthenticated()">
    	 <sec:authentication property="principal" var="pinfo"/>
     		<input type="hidden" id="loginid" name="userid" value="${pinfo.username }">
    	</sec:authorize>
        
    </form>
    <script>
$(function () {
    //모임 대표 이미지 프리뷰
    let file = document.querySelector('#fileName');

    file.onchange = function () {
        let fileList = file.files;
        // 읽기
        let reader = new FileReader();
        reader.readAsDataURL(fileList[0]);
        //로드 한 후
        reader.onload = function () {
            document.querySelector('#preview').src = reader.result;
        };
    };

    //모임 이름 keyUP
 $('#group_name').keyup(function () {
        var inputLength = $(this).val().length; //입력한 글자 수
        var remain = 20 - inputLength; //20자에서 남은 글자수

        $('#groupNameKeyUp').html(inputLength + '/20');

        if (inputLength >= 1 && inputLength <= 3) {
            $(this).css('color', 'red');
        } else if (inputLength >= 4 && inputLength <= 20) {
            $(this).css('color', 'grey');
        } else if(remain < 1) {
            alert("모임 이름은 20자 이내로 입력해 주세요!");
        }
    });

    //모임 소개글 keyUP
    $('#content').keyup(function () {
        var inputLength = $(this).val().length; //입력한 글자 수
        var remain = 1000 - inputLength; //1000자에서 남은 글자수

        $('#contentKeyUp').html(inputLength + '/1000');

        if (inputLength >= 1 && inputLength <= 9) {
            $(this).css('color', 'red');
        } else if (inputLength >= 10 && inputLength <= 1000) {
            $(this).css('color', 'grey');
        } else if (remain < 1) {
            alert("모임 소개글은 1000자 이내로 입력해 주세요!")
        }    
    });

});

//Form 전송
function confirm() {
    console.log($('#interest').val());
	console.log('로그인 아이디는 '+$('#loginid').val());
    if ($('#group_name').val().trim() == '') {
        alert('모임 이름을 입력해 주세요 !')
        return;
    } else if ($('#group_name').val().length < 4) {
    	alert('모임 이름을 최소 4자 이상 입력해 주세요 !')
        return;
    } else if ($('#content').val().trim() == '') {
    	alert('모임 소개글을 입력해 주세요 !')
        return;
    } else if ($('#content').val().length < 10) {
    	alert('모임 소개글을 최소 10자 이상 입력해 주세요 !')
        return;
    } else if ($('#area_name').val() == null) {
    	alert('지역을 선택해 주세요 !')
        return;
    } else if ($('#catename').val() == '') {
    	alert('관심사를 선택해 주세요 !')
        return;
    } else {
    	alert("모임 생성이 완료되었습니다.")
    	$('#groupMakeFrm').submit();
    }
}

</script>
</section>
<!-- End Service -->
<jsp:include page="../include/footer.jsp"/>
</body>
</html>