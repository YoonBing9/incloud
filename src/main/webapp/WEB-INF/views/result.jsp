<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.multicampus.incloud.vo.ChartVO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<!-- jQuery library -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<!-- Latest compiled JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- Mobile first -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- 확대/축소 불가능 -->
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
	<!-- google chart -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <!--css-->
    <link rel="stylesheet" href="/resources/css/result.css">
</head>
<body>
	<%
		ArrayList<ChartVO> datalist = (ArrayList<ChartVO>)request.getAttribute("datalist");
			for(int i=0; i<datalist.size(); i++) {
			ChartVO vo = datalist.get(i);
			List<String> charts = vo.getCharts();			
			String[][] datas = vo.getDatas();
			for(int j=0; j<datas.length; j++) {
				for(int h=0; h<datas[j].length; h++) {
					System.out.println(datas[j][h]);
				}System.out.println();
			}
			String part2 = vo.getPart2();		
			int cols = datas.length;
			int rows = datas[0].length;
	%>
		<script type="text/javascript">		
			/* datas jsp -> js */
			var jsdatas = new Array();
			for(var i=0; i<<%= cols %>; i++) {
				jsdatas[i] = new Array();
			}		
			<% for(int e=0; e<datas.length; e++) {
				for(int j=0; j<datas[e].length; j++) {
			%>		
				jsdatas[<%= e %>][<%= j %>] = "<%= datas[e][j] %>"; 
			<%			
				}			
			}
			%>
						
			/* charts jsp -> js */
			var jscharts = new Array();
			<%		
				for(int j=0; j<charts.size(); j++) {
			%>
					jscharts[<%= j %>] = "<%= charts.get(j) %>";
			<%	
				}
			%>
			
			var part2 = "<%= part2 %>";
			switch(part2) {			
			case "KOSPI" :
			case "ROEG" :
			case "GPC" :
			case "ROE" :
			case "UR" :
				for(var i=0; i<jsdatas.length; i++) {
					var strArray = jsdatas[i][0].split('-');
					var year = strArray[0];
					var month = strArray[1];
					jsdatas[i][0] = new Date(year, month-1);
				}				
				for(var i=0; i<jsdatas.length; i++) {
					jsdatas[i][1] = Number(jsdatas[i][1]);
				}
				if(part2=="UR"){
					for(var i=0; i<jsdatas.length; i++) {
						jsdatas[i][2] = Number(jsdatas[i][2]);
					}					
				} 
				break;
			case "BS" :
				for(var i=0; i<jsdatas.length; i++) {
					for(var j=0; j<jsdatas[i].length; j++) {
						if(j==0) {							
							var strArray = jsdatas[i][0].split('-');
							jsdatas[i][0] = strArray[0];
						} else {
							jsdatas[i][j] = Number(jsdatas[i][j]);
						}
					}
					
				}
				break;
			case "LYRICS" :
				for(var i=0; i<jsdatas.length; i++) {
					var strArray = jsdatas[i][1].split('-');
					var year = strArray[0];
					var month = strArray[1];
					jsdatas[i][1] = new Date(year, month-1);
					jsdatas[i][2] = Number(jsdatas[i][2]);
					jsdatas[i][3] = Number(jsdatas[i][3]);
				}	
				break;
			}
			$.getScript("/resources/js/drawCharts.js");
			for(var i in jsdatas) {
				for(var j in jsdatas[i]){
					console.log(jsdatas[i][j]);
				}
			}
			
			
		</script>
	<%		
		}
	%>	
	
	<div class="container">
		<section class="row">
			<ul id="chartlist">
			
			</ul>
		</section>
		<footer class="row">
			<div class="col-sm-12">				
				<h6>© Copyright 2017 Headlamp Creative  //  Hosted by MEDIA TEMPLE  //  Powered by EXPRESSION ENGINE</h6>
			</div>
		</footer>
	</div>
</body>
</html>