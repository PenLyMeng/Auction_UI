<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="cambodia_auction"></spring:message></title>

<!-- header -->
<jsp:include page="header.jsp" />
<!-- menu -->
<jsp:include page="menu.jsp" />
<!-- left content -->
<jsp:include page="left-content.jsp" />

<style type="text/css">
.btn-primary {
	background: #238FC7;
}

.glyphicon-map-marker, .glyphicon-earphone, .glyphicon-envelope {
	color: #238FC7;
}

.btnsend {
	color: white;
}

.section-title {
	background-color: #FFFFFF;
}

.section-title span {
	margin-left: 3%;
}
</style>

<!-- right content -->
<div class="col-md-9"  id="right-content" ng-controller="mailCtrl">
	
	<!-- ================ Contact US ================ -->
	<br>

	<div class="col-xs-12">
		<div class="well well-sm section-title text-muted">
			<span><strong><spring:message code="contact_us"></spring:message></strong></span>
		</div>
		<div class="panel panel-default">
			<div class="row">
				<div class="col-xs-12 col-md-6">
					<br> <br>
					<form class="form-horizontal" id="ContactUsForm" method="POST" name="myForm">
						<div class="form-group">
							<label for="FirstName" class="col-md-3 control-label required">
								<spring:message code="first_name"></spring:message><span
								class="text-danger">*</span>
							</label>
							<div class="col-md-9">
								<input class="form-control" id="first_name" name="first_name"
									type="text" ng-model="first_name" required>
							</div>
						</div>
						<div class="form-group">
							<label for="LastName" class="col-md-3 control-label required">
								<spring:message code="last_name"></spring:message><span
								class="text-danger">*</span>
							</label>
							<div class="col-md-9">
								<input class="form-control" id="last_name" name="last_name"
									type="text"  ng-model="last_name" required>
							</div>
						</div>
						<div class="form-group">
							<label for="Email" class="col-md-3 control-label required"><spring:message
									code="email"></spring:message><span class="text-danger">*</span></label>
							<div class="col-md-9">
								<input class="form-control" id="email" name="email" type="email"
									 ng-model="email" required>
							</div>
						</div>
						<div class="form-group">
							<label for="Message" class="col-md-3 control-label required"><spring:message
									code="message"></spring:message><span class="text-danger">*</span></label>
							<div class="col-md-9">
								<textarea class="form-control" cols="20" id="message"
									name="message" rows="2" ng-model="message" required></textarea>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-3 control-label"></label>
							<div class="col-md-9">

								<button class="btn btn-primary pull-right" id="SendMessage"
									ng-click="sendMail()" ng-disabled="myForm.$invalid" type="button">
									<span class="glyphicon glyphicon-envelope btnsend"> </span>
									<spring:message code="send"></spring:message>
								</button>

								
							</div>
						</div>
					</form>
					
				</div>
				<br>

				<!-- TODO: RIGH SECTION | DENH TLAI -->
				<div class="col-xs-12 col-md-6" style="">
					<h4>
						<strong> <a
							href="${pageContext.request.contextPath}/index"> <span
								style="color: #238FC7"> <spring:message code="denh"></spring:message></span>
								<span style="color: #515153"><spring:message code="tlai"></spring:message></span>
						</a>
						</strong>
					</h4>
					<div class="pi-col-md-4 pi-col-sm-6 pi-padding-bottom-30"
						style="color: gray">
						<br>
						<ul class="list-unstyled">
							<li><a href="#"> <span
									class="glyphicon glyphicon-map-marker"></span>
							</a> <spring:message code="about_us_address"></spring:message></li>
							<li><a href="#"> <span
									class="glyphicon glyphicon-earphone"></span>
							</a> <span class="pi-weight-600 pi-text-white"><spring:message
										code="tel"></spring:message>:&nbsp;&nbsp;</span> (855)97 989 9689</li>
							<li><span class="pi-weight-600 pi-text-white">&nbsp;
									&nbsp; &nbsp;</span>(855)77 77 12 36 (<spring:message code="khmer"></spring:message>,
								<spring:message code="english"></spring:message>)</li>
							<li><span class="pi-weight-600 pi-text-white">&nbsp;
									&nbsp; &nbsp;</span>(855)15 4 5555 2 (<spring:message code="khmer"></spring:message>,
								<spring:message code="english"></spring:message>)</li>
							<li><span class="pi-weight-600 pi-text-white">&nbsp;
									&nbsp; &nbsp;</span>(855)17 52 81 69(<spring:message code="korean"></spring:message>,
								<spring:message code="english"></spring:message>)</li>

							<li><a href="#"> <span
									class="glyphicon glyphicon-envelope"></span>
							</a> <span class="pi-weight-600 pi-text-white"><spring:message
										code="email"></spring:message>:</span> <a
								href="mailto:info.denhtlai@gmail.com">info.denhtlai@gmail.com</a>
							</li>
						</ul>

					</div>

				</div>

			</div>
		</div>
	</div>


</div>

<!-- footer -->
<jsp:include page="footer.jsp" />

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/scripts/send-mail.js"></script>


<script type="text/javascript">
	$(document).ready(function() {
		$("#menustand").hide(function() {
			$("#right-content").removeClass('col-md-9');
		});
		$('#searchPanel').hide();
	});
</script>