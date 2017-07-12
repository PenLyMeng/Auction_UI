<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="cambodia_auction"></spring:message></title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/static/assets/images/auction.ico">
<link
	href="${pageContext.request.contextPath}/resources/static/assets/login/css/bootstrap.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/static/assets/login/css/core.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/static/assets/login/css/components.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/static/assets/login/css/icons.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/static/assets/login/css/pages.css"
	rel="stylesheet" type="text/css" />
<link
	href="${pageContext.request.contextPath}/resources/static/assets/login/css/responsive.css"
	rel="stylesheet" type="text/css" />
	
<!-- Sweet Alert CSS -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/static/css/sweetalert.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/static/js/sweetalert.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/static/js/sweetalert-dev.js"></script>
	
<style>
#login{
	background-color: #238FC7 !important;
    border: 1px solid #238FC7 !important;
}
</style>

</head>

<body>
	<div class="account-pages"></div>
	<div class="clearfix"></div>

	<div class="wrapper-page">
		<div class="card-box">
			<div class="panel-heading">
				<h3 class="text-center">
					<spring:message code="sign_in_to"></spring:message> <strong style="color: #238FC7;"><spring:message code="denh_tlai"></spring:message></strong>
				</h3>
			</div>

			<div class="panel-body">
				<form class="form-horizontal m-t-20" id="formLogin" method="POST"
					action="/login">

					<div class="form-group ">
						<div class="col-xs-12">
							<input class="form-control" type="text" name="username" required autofocus
								placeholder="<spring:message code='username'></spring:message>"  >
						</div>
					</div>

					<div class="form-group">
						<div class="col-xs-12">
							<input class="form-control" type="password" name="password" required
								placeholder="<spring:message code='password'></spring:message>" >
						</div>
					</div>

					<div class="form-group ">
						<div class="col-xs-12">
							<div class="checkbox checkbox-primary">
								<input id="checkbox-signup" type="checkbox"> <label
									for="checkbox-signup"> <spring:message code="remember_me"></spring:message> </label>
							</div>

						</div>
					</div>

					<div class="form-group text-center m-t-40">
						<div class="col-xs-12">
							<button id="login"
								class="btn btn-pink btn-block text-uppercase waves-effect waves-light"
								type="submit"><spring:message code="sign_in"></spring:message></button>
						</div>
					</div>

					<div class="form-group m-t-20 m-b-0">
						<div class="col-sm-12">
							<a href="" class="text-dark"><i
								class="fa fa-lock m-r-5"></i> <spring:message code="sign_in_to"></spring:message>?</a>
						</div>
					</div>

					<div class="form-group m-t-20 m-b-0">
						<div class="col-sm-12 text-center">
							<h4>
								<b><spring:message code="sign_in_with"></spring:message></b>
							</h4>
						</div>
					</div>

					<div class="form-group m-b-0 text-center">
						<div class="col-sm-12">
							<button type="button"
								class="btn btn-facebook waves-effect waves-light m-t-20">
								<i class="fa fa-facebook m-r-5"></i> Facebook
							</button>

							<button type="button"
								class="btn btn-twitter waves-effect waves-light m-t-20">
								<i class="fa fa-twitter m-r-5"></i> Twitter
							</button>

							<button type="button"
								class="btn btn-googleplus waves-effect waves-light m-t-20">
								<i class="fa fa-google-plus m-r-5"></i> Google+
							</button>
						</div>
					</div>
				</form>

			</div>
		</div>
		<div class="row">
			<div class="col-sm-12 text-center">
				<p>
					<spring:message code="dont_have_an_account"></spring:message>? <a href="${pageContext.request.contextPath}/register?bidder" id="registerLoginLink"
						class="text-primary m-l-5"><b><spring:message code="sign_up"></spring:message></b></a>
				</p>
			</div>
		</div>

	</div>

</body>

<script>
	var resizefunc = [];
</script>

<!-- jQuery  -->
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/jquery.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/bootstrap.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/detect.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/fastclick.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/jquery.slimscroll.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/jquery.blockUI.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/waves.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/wow.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/jquery.nicescroll.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/jquery.scrollTo.min.js"></script>


<script
	src="${pageContext.request.contextPath}/resources/static/assets/login/js/jquery.core.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/assets/js/jquery.app.js"></script>
	
<script type="text/javascript">
$(function() {
	
	$("#formLogin").submit(function(e){		
		  
   		  e.preventDefault();
   		  console.log($("#formLogin").serialize());
   		  $.ajax({
	            url: "${pageContext.request.contextPath}/login",
	            type: "POST",
	            data: $("#formLogin").serialize(),
	            success: function(data) {
	            	
	            	if(data == "User account is locked"){
	            		alert(data);
	            	}else if(data == "User is disabled"){
	            		swal("LOGIN FAILED!", data, "error");
	            	}else if(data == "Bad credentials"){
	            		swal("LOGIN FAILED!", data, "error");
	            	}else{
	            		swal({ 
	        				title: "LOGIN SUCCESSFULLY!",
	        				text: "THANK YOU",
	        			    type: "success",
	        			    timer : 1000,
	        			    showConfirmButton : false
	        			  },
	        			  function(){
	        				  if(data=='admin'){
	          						window.location.href=data;	
	          					}else{
	          						window.location.href=data;	
	          					}
	        			});  		  
	            	}
	            },
	         	error: function(data){
	         		console.log(data);
	         	}
   		  });
		  
	});
});
</script>