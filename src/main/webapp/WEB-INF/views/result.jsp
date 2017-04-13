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
			if(part2 == "KOSPI") {
				for(var i=0; i<jsdatas.length; i++) {
					var strArray = jsdatas[i][0].split('-');
					var year = strArray[0];
					var month = strArray[1];
					jsdatas[i][0] = new Date(year, month, 1);
				}
				for(var i=0; i<jsdatas.length; i++) {
					jsdatas[i][1] = Number(jsdatas[i][1]);
				}
			}
			
			$.getScript("/resources/js/drawCharts.js");
			
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