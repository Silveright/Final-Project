<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.js"></script>
<link href='${pageContext.request.contextPath}/resources/fullcalendar/main.css' rel='stylesheet' />
    <script src='${pageContext.request.contextPath}/resources/fullcalendar/main.js'></script>
    <script src='${pageContext.request.contextPath}/resources/fullcalendar/lib/locales/ko.js'></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e0bcd3b3132ff2c2897199023d1833c7&libraries=services"></script>
 <style>
.left-bar{
	/* position:absolute;
	top:200px */
}
  body {
    margin-top: 40px;
    font-size: 14px;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
  }

  #external-events {
    position: fixed;
    left: 1500px;
    top: 200px;
   width: 160px;
    padding: 0 10px;
    border: 1px solid #ccc;
    background: #eee;
    text-align: left;
  }

  #external-events h4 {
    font-size: 16px;
    margin-top: 0;
    padding-top: 1em;
  }

  #external-events .fc-event {
    margin: 3px 0;
    cursor: move;
  }

  #external-events p {
    margin: 1.5em 0;
    font-size: 11px;
    color: #666;
  }

  #external-events p input {
    margin: 0;
    vertical-align: middle;
  }

  #calendar-wrap {
    margin-top:100px;
    margin-bottom:100px;
    margin-left: 200px;
  }

  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }
  .fc-h-event3{
  	background-color:#3e2eb1e0;
  	border-color:#3e2eb1e0;
  	color:#fff
  }
  .fc-h-event1{
  	background-color:#2000ff59  ;
  	border-color:#2000ff59  ;
  	color:#fff
  }
  .fc-h-event2{
  	background-color:#584bafcf  ;
  	border-color:#584bafcf  ;
  	color:#fff
  }
  a {
    color: #4232c2;
    text-decoration: none  !important;
}
.fc .fc-button-primary:hover,.fc .fc-button-primary, .fc .fc-button-primary:disabled {
    color: #fff !important;
    color: var(--fc-button-text-color, #fff);
    background-color: #776bcc;
    border-color: #776bcc;
}
.fc .fc-button-primary:not(:disabled):active, .fc .fc-button-primary:not(:disabled).fc-button-active {
    color: #fff;
    color: var(--fc-button-text-color, #fff);
    background-color:#564aad;
    border-color: #564aad;
}
</style>
<title>3355 일정관리</title>
</head>
<body>
<jsp:include page="../include/header.jsp"/>
  <div id='wrap'>
    <div id='external-events'>
      <small>일정을 드래그하세요!</small>

      <div id='external-events-list'>
        <div class='fc-event fc-h-event1 fc-daygrid-event fc-daygrid-block-event'>
          <div class='fc-event-main'>정모</div>
        </div>
        <div class='fc-event fc-h-event2 fc-daygrid-event fc-daygrid-block-event'>
          <div class='fc-event-main'>번개</div>
        </div>
        <div class='fc-event fc-h-event3 fc-daygrid-event fc-daygrid-block-event'>
          <div class='fc-event-main'>비대면</div>
        </div>
      </div>

      <p>
        <input type='checkbox' id='drop-remove' />
        <label for='drop-remove'>remove after drop</label>
      </p>
    </div>
    </div>

    <div id='calendar-wrap'>
	<div class="container-fluid">
  <div class="row">
    <div class="col-sm-2">
	<jsp:include page="../group/group_left.jsp" />
	</div>
    <div class="col-sm-6">
      <div id='calendar'></div>
	</div>
	</div>
    </div>

  </div>

<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">일정 정보</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
        <form>
      <div class="modal-body">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          <input type="hidden" name="calendar_no" id="calendar_no" value=""/>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label" >제목</label>
            <input type="text" class="form-control" id="subject" name="subject">
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label" >모임유형</label>
            <input type="text" class="form-control" name="title" id="title">
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label" >날짜</label>
            <input type="text" class="form-control" id="date" name="startdate">
          </div>
          <div class="mb-3">
            <label for="recipient-name" class="col-form-label" >장소</label>
            <input type="text" onkeyup=searchMap() class="form-control" id="location" name="location">
          </div>
          <div class="mb-3">
            <label for="message-text" class="col-form-label">내용</label>
            <textarea class="form-control" id="content" name="content"></textarea>
          </div>
          <input type="hidden" name="xcoord" id="xcoord" value="126.99224354616133"/>
          <input type="hidden" name="ycoord" id="ycoord" value="37.57295805285539"/>
          <div class="mb-3">
            <div id="map" style="width: 465px; height: 300px;"></div>
          </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="save">Save</button>
      </div>
        </form>
    </div>
  </div>
</div>
   <script>
   var click=0;
   
   var group_no='${group_no}'//더미용
    console.log(group_no);
   var myModal = new bootstrap.Modal(document.getElementById('exampleModal'))
   $(".btn-close").click(function(){
	   myModal.hide();
   })

    var containerEl = document.getElementById('external-events-list');
    new FullCalendar.Draggable(containerEl, {
      itemSelector: '.fc-event',
      eventData: function(eventEl) {
        return {
          title: eventEl.innerText.trim()
        }
      }
    });

    var calendarEl = document.getElementById('calendar');
    var calendar;
    calendar = new FullCalendar.Calendar(calendarEl, {
      dateClick: function(){
    	  alert('clicked!!');
      },
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
      },
      editable: true,
      droppable: true, // this allows things to be dropped onto the calendar
      eventSources: [{
  		events: function(info, successCallback, failureCallback) {
  			$.ajax({
  				url: 'loadevent',
  				dataType: 'json',
  				data: {
  					"group_no": "${group_no}"// group_no
  				},
  				success: function(data) {
  					for(idx in data){
  					    console.log(data[idx]);
  					    console.log(data[idx].title);
  					    if(data[idx].title=='번개'){
  					    	data[idx].color='#584bafcf';
  					    }else if(data[idx].title=='정모'){
  					    	data[idx].color='#2000ff59';
  					    }else{
  					    	data[idx].color='#3e2eb1e0';
  					    }
  					};
  					
  					successCallback(data);
  					console.log("이벤트 소스")
  					console.log(data)
  				}
  			});
  		}
  	}],
      
      eventClick: function (event) {//세부 일정 확인
    	  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
    	  
          $('#map').empty();
    	  $('.btn-close').show();
          //console.log(event)
          $('#content').val('');
          $('#subject').val('');
          var calendar_no = event.event.extendedProps.calendar_no//클릭한 이벤트의 스케쥴넘버(DB)
          console.log("캘린더 번호:"+calendar_no)
          //ajax로 해당 스케줄의 정보 가져와서 출력
          $.ajax({
              url: "detail",
              dataType: 'JSON',
              data: {
                  group_no: group_no,
                  calendar_no: calendar_no
              },
              success: function (response) {
            	  $('.modal-footer>button').remove();
            	  output='';
            	  output += '<button type="button" class="btn btn-primary" id="delete">삭제</button>'
            	  output += '<button type="button" class="btn btn-primary" id="modify">수정</button>'
            	  output += "<input type='hidden' value='"+ response.calendar_no+"'>"
            	 $(".modal-footer").append(output);
                  var data = new Date(response.startdate);
                  var date = data.getFullYear() +"-" + (data.getMonth()+1) + "-" + data.getDate()
                  
                  $('#title').val(response.title);
                  $('#date').val(date);
                  $('#content').val(response.content);
                  $('#subject').val(response.subject);
                  $('#location').val(response.location);
                  $('#xcoord').val(response.xcoord);
                  $('#ycoord').val(response.ycoord);
                  console.log(response.xcoord)
                  makeMap();
              },
              error: function (Http, status, error) {
                  console.log(error);
              }
          });

          myModal.show();
      },
      drop: function(info,revertFunc) {
    	  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
    	  
    	   myModal.show();//일정 등록 폼 띄우기
    	   $('#map').empty();

    	   
    	   $('.btn-close').hide();
    	   $('.modal-footer>button').remove();
     	  output='';
     	  output += '<button type="button" class="btn btn-primary" id="save">저장</button>'
     	  output += '<button type="button" class="btn btn-primary" id="close">닫기</button>'
     	 $(".modal-footer").append(output);
    	   $('#content').val('');
           $('#subject').val('');
           $('#location').val('');
    	  $('#title').val(info.draggedEl.innerText);//input tag-모임 유형 입력
          $('#date').val(info.dateStr); //input tag-모임 날짜 입력
          $('#xcoord').val('126.99224354616133');
          $('#ycoord').val('37.57295805285539');//기본 좌표 설정 
           makeMap();
        // is the "remove after drop" checkbox checked?
        if (document.getElementById('drop-remove').checked) {
          // if so, remove the element from the "Draggable Events" list
          arg.draggedEl.parentNode.removeChild(arg.draggedEl);
        }
         
       $('#close').click(function(){
        	alert("일정 적용이 취소됩니다.")
        	 $('.btn-close').click();
        	calendar.removeAllEvents();
            calendar.refetchEvents();
        });
          
          
      },
      eventDrop: function (info) { //이벤트를 옮겼을때 수정함
    	  var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
    	  var year = (info.event._instance.range.start.getFullYear()); //옮긴 달력의 날짜
          var month = info.event._instance.range.start.getMonth() + 1; //옮긴 달력의 날짜
          var day = info.event._instance.range.start.getDate(); //옮긴 달력의 날짜


          var modifyDate = year + '-' + month + '-' + day;
          console.log(modifyDate)
          var calendar_no = info.event._def.extendedProps.calendar_no;// 옮긴이벤트번호
          console.log(modifyDate)
          console.log(calendar_no)

          $.ajax({
              url: "modifydate",
              type: 'post',
              data: {
            	  startdate: modifyDate,
                  calendar_no: calendar_no
              },
              beforeSend: function(xhr){
  				xhr.setRequestHeader(header, token);
  			},
              success: function (response) {
                  alert('날짜가 변경되었습니다!')
              },
              error: function (Http, status, error) {
                  alert('날짜변경에 실패했습니다.')
              }
          });


      },
      locale:'ko'//한글 처리
    });
  
    calendar.render();

   
   //일정 만들기 확인 클릭
   $(".modal-footer").on('click', '#save', function (e) {
	   var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
	   console.log( $('#title').val())
	   console.log($('#xcoord').val())
       if ($("#subject").val() == "") {
           alert('일정 제목을 입력해주세요 !')
           return;
       } else if ($("#content").val().trim() == "") {
           alert('일정 내용을 입력해주세요 !')
           return;
       } else if ($("#location").val().trim() == "") {
           alert('장소를 입력해주세요 !')
           return;
       }else if (click == 0) {
           alert('지도의 장소를 선택해 주세요 !')
           return;
       }
       else {

           $.ajax({
               url: "add",
               type: "post",
               data: {
                   group_no: group_no,
                   title: $('#title').val(),
                   startdate: $('#date').val(),
                   subject: $('#subject').val(),
                   content: $('#content').val(),
                   location: $('#location').val(),
                   xcoord: $('#xcoord').val(),
                   ycoord: $('#ycoord').val()
               },
               beforeSend: function(xhr){
     				xhr.setRequestHeader(header, token);
     			},
               success: function (response) {
                   alert( '일정이 추가되었습니다!')
                  myModal.hide(); 
                 calendar.removeAllEvents();
                  calendar.refetchEvents();
                   console.log(calendar)
               }
               ,
               error: function (Http, status, error) {
                   console.log(error);
               }
           });
       }
   });
   
   
	$(".modal-footer").on('click', '#delete',function(){
		var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		var calendar_no = $(this).next().next().val();//댓글번호
		console.log(calendar_no)
		if(!confirm('정말 삭제하시겠습니까?')) {
			return;
		}
		$.ajax({
			//type: "post",
			url:"delete",
			data : {
				"calendar_no":calendar_no
			},
			success:function(result){
				if(result==1) {
					alert( '일정이 삭제되었습니다!')
					 myModal.hide(); 
					calendar.removeAllEvents();
	                  calendar.refetchEvents();//삭제 후 해당 페이지의 내용을 보여준다.
				}
			}
		})
	})
   
   
	$(".modal-footer").on('click', '#modify',function(){
		var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
		  
		var calendar_no = $(this).next().val();//댓글번호
		console.log(calendar_no)
		if(!confirm('수정하시겠습니까?')) {
			return;
		}
		$.ajax({
			type: "post",
			url:"modify",
			data : {
				group_no: group_no,
                title: $('#title').val(),
                startdate: $('#date').val(),
                subject: $('#subject').val(),
                content: $('#content').val(),
                location: $('#location').val(),
                xcoord: $('#xcoord').val(),
                ycoord: $('#ycoord').val(),
                calendar_no : calendar_no
			},
			 beforeSend: function(xhr){
  				xhr.setRequestHeader(header, token);
  			},
			success:function(result){
				if(result==1) {
					alert( '일정이 수정되었습니다!')
				  myModal.hide(); 
				 calendar.removeAllEvents();
                  calendar.refetchEvents();
				}
			}
		})
	})
	
function makeMap() { //지도만들기
		var token = $("meta[name='_csrf']").attr("content");
		  var header = $("meta[name='_csrf_header']").attr("content");
        $('#map').empty();

        var xcoord = $('#xcoord').val(); //x축 좌표
        var ycoord = $('#ycoord').val(); //y축 좌표
        var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
        var options = { //지도를 생성할 때 필요한 기본 옵션
            center: new kakao.maps.LatLng(ycoord, xcoord), //지도의 중심좌표.
            level: 3 //지도의 레벨(확대, 축소 정도)
        };

        var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴


        // 지도를 클릭한 위치에 표출할 마커입니다
        var marker = new kakao.maps.Marker({
            // 지도 중심좌표에 마커를 생성합니다
            position: map.getCenter()
        });
        // 지도에 마커를 표시합니다
        marker.setMap(map);

        // 지도에 클릭 이벤트를 등록합니다
        // 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
        setTimeout(function () {
            map.relayout();
            map.setCenter(new kakao.maps.LatLng(ycoord, xcoord));
            // map.setLevel(2); 필요하면 레벨조정
        }, 200);
		var destination=$('#location').val();
		console.log(destination)
        var iwContent = '<a href="https://map.kakao.com/link/to/' +
        destination + ',' + ycoord + ',' + xcoord + '" style="color:#000000" target="_blank"><div style="text-align: center; padding-left: 10px; width:120px">길찾기' +
            '&#129306;</a>' +
            '<a href="https://map.kakao.com/link/to/' +
            destination + ',' + ycoord + ',' + xcoord + '" style="color:#000000" target="_blank">📌</a></div>',
            iwPosition = new kakao.maps.LatLng(ycoord, xcoord); //인포윈도우 표시 위치입니다

        // 인포윈도우를 생성합니다
        var infowindow = new kakao.maps.InfoWindow({
            position: iwPosition,
            content: iwContent
        });
        // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
        infowindow.open(map, marker);
    }
	
	
function searchMap(){
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
	
//마커를 클릭하면 장소명을 표출할 인포윈도우 입니다

var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 

// 키워드로 장소를 검색합니다
ps.keywordSearch($('#location').val(), placesSearchCB); 

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
	var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x) 
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        click++;
    	// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
        $('#location').val(place.place_name);
        $('#xcoord').val(place.x);
        $('#ycoord').val(place.y);
        console.log("마커 클릭"+click);
    });
}
}
</script>
<jsp:include page="../include/footer.jsp"></jsp:include>
</body>
</html>