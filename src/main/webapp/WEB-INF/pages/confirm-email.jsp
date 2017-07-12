<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>Confirm Email</title>
<!-- header -->
<jsp:include page="header.jsp" />

<!-- menu -->
<jsp:include page="menu.jsp" />

<!-- content -->
<div class="content" id="register" ng-controller="confirmEmailCtrl">
	<div class="panel panel-default" >
		<div class="row" >
			
				<h1 style="padding:20px; text-align:center;">Welcome!</h1>
				<p style="padding-bottom:30px; text-align:center;">Your email is confirmed.</p>
			
		</div>
	</div>


	<!-- end div container -->
</div>
<!-- end div main content information -->

<!-- footer -->
<jsp:include page="footer.jsp" />




<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/scripts/confirm-email-angular.js"></script>