google.charts.load('current', {'packages':['corechart','line','motionchart']});
google.charts.setOnLoadCallback(drawCharts);

function drawCharts() {
	for(var i in jscharts) {
		switch(jscharts[i]) {
		case "line" : drawLineChart();
		break;
		case "histogram" : drawHistogramChart();
		break;
		case "bubble" : drawSeriesChart();
		break;
		case "motion" : drawMotionChart();
		break;
		}
	}
}

function drawHistogramChart() {	
	var histodatas = jsdatas;
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
	var data = new google.visualization.DataTable();
	data.addColumn('date', 'Date');
    data.addColumn('number', 'Kospi');
    var linedatas = jsdatas;
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
	var bubbledatas = jsdatas;
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
    data.addColumn('date', 'Date');
    data.addColumn('number', 'Kospi');
    var linedatas = jsdatas;
    data.addRows(linedatas);
    
    var options = {};
    options['title'] = part2;
    options['width'] = 900;
    options['height'] = 500;    

    $("#chartlist").append("<li></li>");
    var chart = new google.visualization.MotionChart(document.querySelector("#chartlist li:last-child"));
    $("#chartlist").append("<hr>");
    chart.draw(data, options);
 }