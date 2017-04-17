google.charts.load('current', {'packages':['corechart','line','motionchart','table','bar']});
google.charts.setOnLoadCallback(drawCharts);

function drawCharts() {
	console.log("drawCharts()들어옴");
	for(var i in jscharts) {
		console.log(jscharts[i]);
		switch(jscharts[i]) {
		case "line" : drawLineChart();
			break;
		case "histogram" : drawHistogramChart();
			break;
		case "bubble" : drawSeriesChart();
			break;
		case "motion" : drawMotionChart();
			break;
		case "table" : drawTable();
			break;
		case "network" : drawNetworkTable();
			break;
		case "bar" : drawPercentChart();
			break;
		}
	}
}

function drawHistogramChart() {	
	var histodatas = jsdatas.slice();
	switch(part2) {
	case "KOSPI" : histodatas.unshift(["TIME","KOSPI"]);
	break;
	}
    
    var data = google.visualization.arrayToDataTable(histodatas);
    var options = {
    		title: part2,
    	    legend: { position: 'none' },
    	    colors: ['#e7711c'],
    	    histogram: { lastBucketPercentile: 5 },
    	    vAxis: { scaleType: 'mirrorLog' },
    	    width: 900,
	        height: 500
    };    
  
    $("#chartlist").append("<li></li>");
    var chart = new google.visualization.Histogram(document.querySelector("#chartlist li:last-child"));
    $("#chartlist").append("<hr>");
    chart.draw(data, options);
}

function drawLineChart() {	
	console.log("라인들어옴");
	var data = new google.visualization.DataTable();
	switch(part2) {
	case "KOSPI" :
		data.addColumn('date', 'Date');
	    data.addColumn('number', 'Kospi');
	    console.log("코스피들어옴");
		break;
	case "ROEG" : case "ROE" :
		data.addColumn('date', 'Year');
	    data.addColumn('number', 'Rate');
		break;
	case "GPC" :
		data.addColumn('date', 'Year');
	    data.addColumn('number', 'GDP per capita');
		break;
	case "UR" :
		data.addColumn('date', 'Year');
	    data.addColumn('number', 'Rate');
	    data.addColumn('number', 'Youth rate');
	    console.log("실업률들어옴");
		break;
	}
	
    var linedatas = jsdatas.slice();
    for(var i in linedatas) {
		for(var j in linedatas[i]){
			console.log(linedatas[i][j]);
		}
	}
    data.addRows(linedatas);    
    
    var options = {
    	title: part2,    		
        width: 900,
        height: 500
    };
    $("#chartlist").append("<li></li>");	      
    var chart = new google.charts.Line(document.querySelector("#chartlist li:last-child"));
    $("#chartlist").append("<hr>");
    chart.draw(data, options);
}

function drawSeriesChart() {
	var bubbledatas = jsdatas.slice();
	switch(part2) {
	case "KOSPI" : histodatas.unshift(["TIME","KOSPI"]);
	break;
	}
    var data = google.visualization.arrayToDataTable(bubbledatas);

    var options = {
      title: part2,
      hAxis: {title: bubbledatas[0][0]},
      vAxis: {title: bubbledatas[0][1]},
      bubble: {textStyle: {fontSize: 11}},
      width: 900,
      height: 500
    };

    $("#chartlist").append("<li></li>");
    var chart = new google.visualization.BubbleChart(document.querySelector("#chartlist li:last-child"));
    $("#chartlist").append("<hr>");
    chart.draw(data, options);
  }

function drawMotionChart() {
    var data = new google.visualization.DataTable();
    switch(part2) {
    case "LYRICS" :
    	data.addColumn('string', 'word');
        data.addColumn('date', 'year');
        data.addColumn('number', 'comp');
        data.addColumn('number', 'freq');
    	break;
    }
    
    var motiondatas = jsdatas.slice();
    data.addRows(motiondatas);
    
    var options = {};
    options['title'] = part2;
    options['width'] = 900;
    options['height'] = 500;    

    $("#chartlist").append("<li></li>");
    var chart = new google.visualization.MotionChart(document.querySelector("#chartlist li:last-child"));
    $("#chartlist").append("<hr>");
    chart.draw(data, options);
 }

function drawTable() {
    var data = new google.visualization.DataTable();
    switch(part2) {
	case "KOSPI" :
		data.addColumn('date', 'Date');
	    data.addColumn('number', 'Kospi');
		break;
	case "TFWORDS" :		
	    data.addColumn('string', 'Word');	    
		break;
	}
    var tabledatas = jsdatas.slice();
    data.addRows(tabledatas);
        
    var options = {
        	title: part2,
            width: 900,
            height: 500,
            showRowNumber: true
        };
    
    $("#chartlist").append("<li></li>");
    var table = new google.visualization.Table(document.querySelector("#chartlist li:last-child"));
    $("#chartlist").append("<hr>");
    table.draw(data, options);
  }

function drawNetworkTable() {
    var data = new google.visualization.DataTable();
    switch(part2) {
	case "TFWORDS" :
		data.addColumn('string', 'id');
	    data.addColumn('string', 'Word');
	    console.log("tfwords들어옴");
		break;
	}
    var tabledatas = jsdatas.slice();
    for(var i in tabledatas) {
		for(var j in tabledatas[i]){
			console.log(tabledatas[i][j]);
		}
	}
    data.addRows(tabledatas);
        
    var options = {
        	title: part2,
            width: 300,
            height: 500,
            showRowNumber: false
        };
    
    $("#chartlist").append("<li></li>");
    var table = new google.visualization.Table(document.querySelector("#chartlist li:last-child"));
    $("#chartlist").append("<hr>");
    table.draw(data, options);
    
    google.visualization.events.addListener(table, 'select', selectHandler);
    function selectHandler() {
    	  var selection = table.getSelection();
    	  var id = '';
    	  for (var i = 0; i < selection.length; i++) {
    	    var item = selection[i];
    	    if (item.row != null && item.column != null) {
      	      id = data.getFormattedValue(item.row, item.column);
      	    } else if (item.row != null) {
      	    	id = data.getFormattedValue(item.row, 0);
      	    } else if (item.column != null) {
      	      id = data.getFormattedValue(0, item.column);      	    
      	    }
      	  }
    	  console.log(id);
    	    $.ajax({
    	    	url: '/ajax/assc',
    	    	type: 'post',
    	    	data: {
    	    		id,
    	    		type: 'barChart'
    	    	},
    	    	dataType: 'json',
    	    	success: function(datas) {
    	    		google.charts.setOnLoadCallback(drawStuff(datas));
    	    	}
    	    });
    } 
  }

function drawStuff(datas) {
	for(var i=0; i<datas.length; i++) {
		datas[i][1] = Number(datas[i][1]);
	}
	datas.unshift(["Words","Association"]);
	
	for(var i in datas){
		for(var j in datas[i]){
			console.log(datas[i][j]);
		}
	}
	var data = new google.visualization.arrayToDataTable(datas);

    var options = {
      title: 'Chess opening moves',
      height: 800,
      width: 900,
      legend: { position: 'none' },
      chart: { title: 'Chess opening moves',
               subtitle: 'popularity by percentage' },
      bars: 'horizontal', // Required for Material Bar Charts.
      axes: {
        x: {
          0: { side: 'top', label: 'Association'} // Top x-axis.
        }
      },
      bar: { groupWidth: "90%" }
    };
    $("#chartlist").append("<li></li>");
    var chart = new google.charts.Bar(document.querySelector("#chartlist li:last-child"));
    chart.draw(data, options);  
  };
  
  function drawPercentChart() {
	  var stuffdatas = jsdatas.slice();
		stuffdatas.unshift(["year","경제/경영","소설","시/에세이","어린이","역사문학","외국어","인문","자기계발","정치","컴퓨터/IT","건강","여행","유아","종교","과학","만화","중고등참고서","가정/육아","요리","사회","예술/대중문화"]);
		var data = google.visualization.arrayToDataTable(stuffdatas);
		for(var i in stuffdatas) {
			for(var j in stuffdatas[i]) {
				console.log(stuffdatas[i][j]);
			}
		}
		var options_fullStacked = {
		          isStacked: 'percent',
		          height: 1000,
		          width: 1000,
		          legend: {position: 'top', maxLines: 3},
		          hAxis: {
		            minValue: 0,
		            ticks: [0, .3, .6, .9, 1]
		      },
		 };
		$("#chartlist").append("<li></li>");
		var chart = new google.visualization.BarChart(document.querySelector("#chartlist li:last-child"));
	      chart.draw(data, options_fullStacked);
  }