// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}

// Area Chart Example 주소/areachart
$.ajax({
	/*var token = $("meta[name='_csrf']").attr("content");
	var header = $("meta[name='_csrf_header']").attr("content");*/
	url: "../admin/areachart",
	//type:"post",
    dataType: "json",
  /*  beforeSend: function(xhr){
		xhr.setRequestHeader(header, token);
	},*/
    success: function (data){
		
		//console.log("날짜 길이"+data.chartdate.length)
		//console.log("회원 수 길이"+data.chartusers.length)
		//console.log(data.chartusers)
		//console.log(data.chartdate);
		//console.log(Object.values(data.chartdate));
		//console.log(Object.values(data.chartusers));
		
		/*(2) [{…}, {…}]
				0: {cnt: '1'}
				1: {cnt: '2'}
				
				=>> ['1', '2'] 받아온 json 형식의 데이터를 배열로 변환해줘야 함
		 * 
		 * [{…}, {…}]
				0:{date: '2022-09-20'}
				1:{date: '2022-09-21'}*/
		var date=[];
		for(var i=0; i<data.chartdate.length; i++) {
			//console.log(data.chartdate[i].date)
			date[i]=data.chartdate[i].date
			console.log(date)
		}
		
		var users=[];
		for(var i=0; i<data.chartdate.length; i++) {
			//console.log(data.chartdate[i].date)
			users[i]=data.chartdate[i].cnt
					console.log(users)
		}
		/*$(data.chartdate).each(function(){
			console.log(this.date);
		})
		$(data.chartusers).each(function(){
			console.log(this.cnt);
		})*/

		var ctx = document.getElementById("myAreaChart");
		var myLineChart = new Chart(ctx, {
			type: 'line',
			data: {
				labels: date,
				datasets: [{
					label: "가입자 수",
					lineTension: 0.3,
					backgroundColor: "rgba(78, 115, 223, 0.05)",
					borderColor: "rgba(78, 115, 223, 1)",
					pointRadius: 3,
					pointBackgroundColor: "rgba(78, 115, 223, 1)",
					pointBorderColor: "rgba(78, 115, 223, 1)",
					pointHoverRadius: 3,
					pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
					pointHoverBorderColor: "rgba(78, 115, 223, 1)",
					pointHitRadius: 10,
					pointBorderWidth: 2,
					data: users,
				}],
			},
			options: {
				maintainAspectRatio: false,
				layout: {
					padding: {
						left: 10,
						right: 25,
						top: 25,
						bottom: 0
					}
				},
				scales: {
					xAxes: [{
						time: {
							unit: 'date'
						},
						gridLines: {
							display: false,
							drawBorder: false
						},
						ticks: {
							maxTicksLimit: 7
						}
					}],
					yAxes: [{
						ticks: {
							maxTicksLimit: 3,//y축 구분선 개수
							padding: 10,
							// Include a dollar sign in the ticks
							callback: function(value, index, values) {
								return  number_format(value)+'명';
							}
						},
						gridLines: {
							color: "rgb(234, 236, 244)",
							zeroLineColor: "rgb(234, 236, 244)",
							drawBorder: false,
							borderDash: [2],
							zeroLineBorderDash: [2]
						}
					}],
				},
				legend: {
					display: false
				},
				tooltips: {
					backgroundColor: "rgb(255,255,255)",
					bodyFontColor: "#858796",
					titleMarginBottom: 10,
					titleFontColor: '#6e707e',
					titleFontSize: 14,
					borderColor: '#dddfeb',
					borderWidth: 1,
					xPadding: 15,
					yPadding: 15,
					displayColors: false,
					intersect: false,
					mode: 'index',
					caretPadding: 10,
					callbacks: {
						label: function(tooltipItem, chart) {
							var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
							return datasetLabel+ ': ' + number_format(tooltipItem.yLabel)  + '명';
						}
					}
				}
			}
		});
	}
})
