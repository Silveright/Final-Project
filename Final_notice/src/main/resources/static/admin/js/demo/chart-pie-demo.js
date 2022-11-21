// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

// Pie Chart Example
$.ajax({
	url:"../admin/piechart",
	//type:"post",
	dataType:"json",
	success: function(data){
		$(".mr-1").remove();
		var catename=[];
		var users=[];
		for(var i=0; i<data.piechart.length;i++) {
			catename[i]=data.piechart[i].catename;
			users[i]=data.piechart[i].users;
			console.log(catename[i])
			console.log(users[i])
		}
		console.log(data.piechart)
		var colors=[];//동적으로 차트 색상 생성
		
		for(var i=0;i<data.piechart.length;i++){
			colors.push('#'+Math.floor(Math.random()*16777215).toString(16));
			console.log(colors[i]);
			output='';
			output += "<span class='mr-1'>"
					+ " <i class='fas fa-circle' style='color:"+colors[i]+"'></i>"+ catename[i]
					+ "</span>"
					
					$(".mt-2").append(output);
		}
		//차트 라벨링 색상
		
		var ctx = document.getElementById("myPieChart");
		var myPieChart = new Chart(ctx, {
			type: 'doughnut',
			data: {
				labels: catename,
				datasets: [{
					data: users,
					backgroundColor: colors,
					/*hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],*/
					hoverBorderColor: "rgba(234, 236, 244, 1)",
				}],
			},
			options: {
				maintainAspectRatio: false,
				tooltips: {
					backgroundColor: "rgb(255,255,255)",
					bodyFontColor: "#858796",
					borderColor: '#dddfeb',
					borderWidth: 1,
					xPadding: 15,
					yPadding: 15,
					displayColors: false,
					caretPadding: 10,
				},
				legend: {
					display: false
				},
				cutoutPercentage: 80,
			},
		});
		
		/*$(data.piechart).each(function(){
			output='';
			output += "<span class='mr-2'>"
					+ " <i class='fas fa-circle' style='color:"+colors+"'></i>"+ this.catename
					+ "</span>"
			
			$(".mt-4").append(output);
		})*/
		
	}
	
})

$.ajax({
	url:"../admin/piechart2",
	//type:"post",
	dataType:"json",
	success: function(data){
		
		$(".mr-3").remove();
		var catename=["남자","여자"];
		console.log("성별비율")
		console.log(data.piechart[0].male)
		console.log(data.piechart[0].female)
		var gender=[data.piechart[0].male,data.piechart[0].female];
		
		var colors=[];//동적으로 차트 색상 생성
		
		for(var i=0;i<2;i++){
			colors.push('#'+Math.floor(Math.random()*16777215).toString(16));
			console.log(colors[i]);
			output='';
			output += "<span class='mr-3'>"
					+ " <i class='fas fa-circle' style='color:"+colors[i]+"'></i>"+ catename[i]
							+ "</span>"
							
							$(".mt-4").append(output);
		}
		//차트 라벨링 색상
		
		var ctx = document.getElementById("myPieChart2");
		var myPieChart2 = new Chart(ctx, {
			type: 'doughnut',
			data: {
				labels: ["남자","여자"],
				datasets: [{
					data: gender,
					backgroundColor: colors,
					/*hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],*/
					hoverBorderColor: "rgba(234, 236, 244, 1)",
				}],
			},
			options: {
				maintainAspectRatio: false,
				tooltips: {
					backgroundColor: "rgb(255,255,255)",
					bodyFontColor: "#858796",
					borderColor: '#dddfeb',
					borderWidth: 1,
					xPadding: 15,
					yPadding: 15,
					displayColors: false,
					caretPadding: 10,
				},
				legend: {
					display: false
				},
				cutoutPercentage: 80,
			},
		});
		
		/*$(data.piechart).each(function(){
			output='';
			output += "<span class='mr-2'>"
					+ " <i class='fas fa-circle' style='color:"+colors+"'></i>"+ this.catename
					+ "</span>"
			
			$(".mt-4").append(output);
		})*/
		
	}
	
})
