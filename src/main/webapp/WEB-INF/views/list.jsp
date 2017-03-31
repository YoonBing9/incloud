<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
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
	<link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/datepicker3.css" />
	<script type="text/javascript" src="/resources/bootstrap/js/bootstrap-datepicker.js"></script>
	<script type="text/javascript" src="/resources/bootstrap/js/bootstrap-datepicker.kr.js"></script>
	<!--javascript-->
    <script type="text/javascript" src="/resources/js/main.js"></script>
    <!--css-->
    <link rel="stylesheet" href="/resources/css/main.css">
</head>
<body>
	<div class="container">
		<header class="row">
			<div id="logo" class="col-sm-3" >
				<img class="img-responsive" src="/resources/images/incloud_logo.png" width=150px>
			</div>
		</header>
		<section class="row">			
			<nav class="col-sm-3">
				<div class="panel-group">
				  <div class="panel panel-default">
				  	<a class="menu" data-toggle="collapse" href="#collapse1">
				  		<div class="panel-heading">
					      <h4 class="panel-title">경제</h4>
					    </div>
				  	</a>
				    <div id="collapse1" class="panel-collapse collapse">
				      <ul class="list-group">
				        <a href="#" class="list-group-item" onclick="return false;">One</a>
				        <a href="#" class="list-group-item" onclick="return false;">Two</a>
				        <a href="#" class="list-group-item" onclick="return false;">Three</a>
				      </ul>
				    </div>
				  </div>
				  
				  <div class="panel panel-default" value="문화">
				  	<a class="menu" data-toggle="collapse" href="#collapse2">
				  		<div class="panel-heading">
					      <h4 class="panel-title">문화</h4>
					    </div>
				  	</a>				    
				    <div id="collapse2" class="panel-collapse collapse">
				      <ul class="list-group">
				        <a href="#" class="list-group-item" onclick="return false;">One</a>
				        <a href="#" class="list-group-item" onclick="return false;">Two</a>
				        <a href="#" class="list-group-item" onclick="return false;">Three</a>
				      </ul>
				    </div>
				  </div>
				  
				  <div class="panel panel-default" value="정치">
				  	<a class="menu" data-toggle="collapse" href="#collapse3">
				  		<div class="panel-heading">
					      <h4 class="panel-title">정치</h4>
					    </div>
				  	</a>				    
				    <div id="collapse3" class="panel-collapse collapse">
				      <ul class="list-group">
				        <a href="#" class="list-group-item" onclick="return false;">One</a>
				        <a href="#" class="list-group-item" onclick="return false;">Two</a>
				        <a href="#" class="list-group-item" onclick="return false;">Three</a>
				      </ul>
				    </div>
				  </div>
				  
				  <div class="panel panel-default" value="IT">
				  	<a class="menu" data-toggle="collapse" href="#collapse4">
				  		<div class="panel-heading">
					      <h4 class="panel-title">IT</h4>
					    </div>
				  	</a>				    
				    <div id="collapse4" class="panel-collapse collapse">
				      <ul class="list-group">
				        <a href="#" class="list-group-item" onclick="return false;">One</a>
				        <a href="#" class="list-group-item" onclick="return false;">Two</a>
				        <a href="#" class="list-group-item" onclick="return false;">Three</a>
				      </ul>
				    </div>
				  </div>
				</div>
			</nav>
			<main class="col-sm-9">
				<form action="/list/post" method="post">
					<div class="panel-group" id="list">
						
					</div>
					<input type="submit" class="btn btn-info" value="ANALYSIS" >
				</form>
			</main>
		</section>
		<footer class="row">
			<div class="col-sm-12">
				<h6>© Copyright 2017 Headlamp Creative  //  Hosted by MEDIA TEMPLE  //  Powered by EXPRESSION ENGINE</h6>
			</div>
		</footer>
	</div>
</body>
</html>