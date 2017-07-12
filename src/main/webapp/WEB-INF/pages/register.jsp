<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="register_new_account"></spring:message></title>
<!-- header -->
<jsp:include page="header.jsp" />

<!-- menu -->
<jsp:include page="menu.jsp" />

<!-- content -->
<div class="content" id="register" ng-controller="addUserCtrl">
	<div class="container" style="padding-right: 0;">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-body">
					<small><spring:message code="create_an_account"></spring:message></small>
				</div>
			</div>
		</div>
		<!-- form register -->
		<form class="form-horizontal" role="form" id="myForm">
			<div class="row">
				<div class="col-md-12">
					<div class="list-group">
						<div class="list-group-item">
							<small><spring:message code="create_login"></spring:message></small>
						</div>
						<div class="list-group-item">
							<div class="form-group">
								<label class="control-label col-sm-3" for="uname"><spring:message
										code="username"></spring:message> <sup><i
										class="glyphicon glyphicon-star"></i></sup></label>
								<div class="col-sm-7">
									<input type="text" class="form-control" id="uname"
										ng-model="user_name" onkeyup="checkUsername();" required>
									<p>
										<spring:message code="user_bid_buy_sell"></spring:message>
									</p>
									<span id="uname_msg"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-3" for="pwd"><spring:message
										code="password"></spring:message> <sup><i
										class="glyphicon glyphicon-star"></i></sup></label>
								<div class="col-sm-7">
									<input type="password" class="form-control" id="pwd"
										ng-model="password" required onkeyup="checkPassword();">
									<p>
										<spring:message code="password_policy"></spring:message>
									</p>
									<span id="pass"></span>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-3" for="cpwd"><spring:message
										code="confirm_password"></spring:message> <sup><i
										class="glyphicon glyphicon-star"></i></sup></label>
								<div class="col-sm-7">
									<input type="password" class="form-control" id="cpwd" required
										onkeyup="checkPasswordMatch();"> <span id="confirm"></span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- end div col-md-9 -->

			</div>
			<div class="col-md-12">
				<div class="list-group">
					<div class="list-group-item">
						<small><spring:message code="your_contact_information"></spring:message></small>
					</div>
					<div class="list-group-item">
						<div class="form-group">
							<label class="control-label col-sm-3" for="email"><spring:message
									code="email"></spring:message> <sup><i
									class="glyphicon glyphicon-star"></i></sup></label>
							<div class="col-sm-7">
								<input type="email" class="form-control" id="email"
									ng-model="email" required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3" for="cemail"><spring:message
									code="confirm_email"></spring:message> <sup><i
									class="glyphicon glyphicon-star"></i></sup></label>
							<div class="col-sm-7">
								<input type="email" class="form-control" id="cemail" required
									onkeyup="checkEmailMatch();"> <span id="conemail"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3" for="contact"><spring:message
									code="contact"></spring:message> <sup><i
									class="glyphicon glyphicon-star"></i></sup></label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="contact" required
									placeholder="Ex: 012 345 678" ng-model="contact">
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end div col-md-12 -->

			<div class="col-md-12">
				<div class="list-group">
					<div class="list-group-item">
						<small><spring:message code="additional_information"></spring:message></small>
					</div>
					<div class="list-group-item">
						<div class="form-group">
							<label class="control-label col-sm-3" for="fname"><spring:message
									code="first_name"></spring:message> <sup><i
									class="glyphicon glyphicon-star"></i></sup></label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="fname"
									ng-model="first_name" required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3" for="lname"><spring:message
									code="last_name"></spring:message> <sup><i
									class="glyphicon glyphicon-star"></i></sup></label>
							<div class="col-sm-7">
								<input type="text" class="form-control" id="lname"
									ng-model="last_name" required>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3" for="gender"><spring:message
									code="gender"></spring:message> <sup><i
									class="glyphicon glyphicon-star"></i></sup></label>
							<div class="col-sm-7">
								<select class="form-control select2" ng-model="gender" required>
									<option value="female"><spring:message code="female"></spring:message></option>
									<option value="male"><spring:message code="male"></spring:message></option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3" for="gender"><spring:message
									code="dob"></spring:message> <sup><i
									class="glyphicon glyphicon-star"></i></sup></label>
							<div class="col-sm-7">
								<div class="input-group">
									<input type="text" class="required form-control"
										placeholder="mm/dd/yyyy" id="datepicker" ng-model="dob"
										required> <span
										class="input-group-addon bg-custom b-0 text-white"><i
										class="glyphicon glyphicon-calendar"></i></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-sm-3" for="gender"><spring:message
									code="address"></spring:message> <sup><i
									class="glyphicon glyphicon-star"></i></sup></label>
							<div class="col-sm-7">
								<textarea class="required form-control" rows="5"
									ng-model="address" required></textarea>
							</div>
						</div>

						<div class="form-group">
							<div class="col-sm-3"></div>
							<div class="col-sm-3">
								<button type="button" class="btn btn-primary btn-block"
									ng-click="addUser()">
									<spring:message code="complete_registration"></spring:message>
								</button>
							</div>
							<div class="col-sm-4">
								<p>
									<small><spring:message code="all_fields_marked_with"></spring:message>
										" <sup><i class="glyphicon glyphicon-star"></i></sup> " <spring:message
											code="are_required"></spring:message></small>
								</p>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end div col-md-12 -->
		</form>
<!-- 		<button type="button" ng-click="test()">Click to verify email</button> -->
	</div>
	<!-- end div container -->
</div>
<!-- end div main content information -->

<!-- footer -->
<jsp:include page="footer.jsp" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/scripts/user-angular.js"></script>
<script type="text/javascript">
	function checkUsername() {
		
		if (/[^a-zA-Z0-9]/.test($("#uname").val())) {
			$("#uname_msg").text("Username can only be alphanumeric");
		} else {
			$("#uname_msg").text("");
		}

	}
	function checkPassword() {
		var password = $("#pwd").val();
		if (password.length >= 6) {
			$("#pass").text("Password Correct Format...!");
		} else {
			$("#pass").text("Must best at least 6 characters!");
		}
	}
	function checkPasswordMatch() {
		var password = $("#pwd").val();
		var confirmPassword = $("#cpwd").val();

		if (password != confirmPassword) {
			$("#confirm").text("Passwords do not match!");
		} else
			$("#confirm").text("Passwords matched!");
	}

	function checkEmailMatch() {
		var email = $("#email").val();
		var cemail = $("#cemail").val();

		if (email != cemail) {
			$("#conemail").text("Email not match");
		} else {
			$("#conemail").text("Email matched!");
		}
	}

	$(document).ready(function() {
		$("#menustand").hide(function() {
			$("#right-content").removeClass('col-md-9');
		});
		$('#searchPanel').hide();
	});
</script>