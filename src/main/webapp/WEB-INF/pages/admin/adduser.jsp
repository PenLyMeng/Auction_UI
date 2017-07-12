<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Management</title>

<!-- header -->
<jsp:include page="header.jsp"></jsp:include>
<!-- menu -->
<jsp:include page="menu.jsp"></jsp:include>
<!-- left content -->
<jsp:include page="left-content.jsp"></jsp:include>

<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="content-page">
	<!-- Start content -->
	<div class="content">
		<div class="container" ng-controller="UserCtrl">

			<!-- Page-Title -->
			<div class="row">
				<div class="col-sm-12">
					<h4 class="page-title">Form Add User</h4>
					<ol class="breadcrumb">
						<li><a href="#">DENH TLAI</a></li>
						<li class="active">Add User</li>
					</ol>
				</div>
			</div>

			<!-- Wizard with Validation -->

			<div class="row">
				<div class="col-sm-12">
					<div class="card-box">
						<form action="#" id="wizard-validation-form">
							<div>
								<h3>Create Login</h3>
								<section>
								<div class="form-group clearfix">
									<label class="col-lg-2 control-label " for="userName2">User
										name *</label>
									<div class="col-lg-10">
										<input class=" form-control required" id="userName2"
											name="userName" type="text" ng-model="user_name">
									</div>
								</div>
								<div class="form-group clearfix">
									<label class="col-lg-2 control-label " for="password2">
										Password *</label>
									<div class="col-lg-10">
										<input id="password2" name="password" type="password"
											class="required form-control" ng-model="password">
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="col-lg-2 control-label " for="confirm2">Confirm
										Password *</label>
									<div class="col-lg-10">
										<input id="confirm2" name="confirm" type="password"
											class="required form-control" ng-model="confrim"
											onChange="checkPasswordMatch();"> <br />
										<div class="registrationFormAlert" id="divCheckPasswordMatch"></div>
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="col-lg-12 control-label ">(*) Mandatory</label>
								</div>
								</section>
								<h3>Contact Information</h3>
								<section>
								<div class="form-group clearfix">
									<label class="col-lg-2 control-label " for="email2">Email
										*</label>
									<div class="col-lg-10">
										<input id="email2" name="email" type="text"
											class="required email form-control" ng-model="email">
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="col-lg-2 control-label " for="phone">Contact
										Number *</label>
									<div class="col-lg-10">
										<input id="phone" name="phone" type="text" placeholder="Ex: 012803020 (Allow only number, no space)"
											class="required form-control" ng-model="contact">
									</div>
								</div>


								<div class="form-group clearfix">
									<label class="col-lg-12 control-label ">(*) Mandatory</label>
								</div>
								</section>
								<h3>Additional Information</h3>
								<section>
								<div class="form-group clearfix">
									<label class="col-lg-2 control-label " for="fname">First
										Name *</label>
									<div class="col-lg-10">
										<input id="fname" name="fname" type="text"
											class="required form-control" ng-model="first_name">
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="col-lg-2 control-label " for="lname">Last
										Name *</label>
									<div class="col-lg-10">
										<input id="lname" name="lname" type="text"
											class="required form-control" ng-model="last_name">
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="col-lg-2 control-label " for="lname">Gender
										*</label>
									<div class="col-lg-10">
										<select class="form-control select2" ng-model="gender">
											<option value="female" ng-selected="true">Female</option>
											<option value="male">Male</option>
										</select>
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="control-label col-lg-2">Date of Birth</label>
									<div class="col-lg-10">
										<div class="input-group">
											<input type="text" class="required form-control"
												placeholder="mm/dd/yyyy" id="datepicker" ng-model="dob"> 
											<span class="input-group-addon bg-custom b-0 text-white"><i
												class="icon-calender"></i></span>
										</div>
										<!-- input-group -->
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="col-lg-2 control-label">Address</label>
									<div class="col-lg-10">
										<textarea class="required form-control" rows="5"
											ng-model="address"></textarea>
									</div>
								</div>

								<div class="form-group portlets">
									<label class="col-lg-2 control-label">Photo</label>
									<div class="col-lg-10 dropzone dz-clickable" id="dropzone">
										<div class="dz-default dz-message" ng-model="photo"></div>
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="col-lg-2 control-label">Role</label>
									<div class="col-lg-10">
										<div class="radio radio-info radio-inline">
											<input type="radio" id="role1" name="role"
												ng-model="type" value="admin"> 
												<label for="role1"> Admin </label>
										</div>
										<div class="radio radio-inline">
											<input type="radio" id="role2" name="role"
												ng-model="type" value="bidder" ng-checked="true"> 
												<label for="role2"> Bidder </label>
										</div>
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="col-lg-2 control-label">Status</label>
									<div class="col-lg-10">
										<div class="radio radio-info radio-inline">
											<input type="radio" id="status1" name="status"
												ng-model="status" value="1"  ng-checked="true"> <label for="status1">
												Enable </label>
										</div>
										<div class="radio radio-inline">
											<input type="radio" id="status2" name="status" 
												ng-model="status" value="0"> <label
												for="status2"> Disable </label>
										</div>
									</div>
								</div>

								<div class="form-group clearfix">
									<label class="col-lg-2 control-label">Comment</label>
									<div class="col-lg-10">
										<textarea class="form-control" rows="5" ng-model="comment"></textarea>
									</div>
								</div>
								<!-- <div class="form-group clearfix">
									<label class="col-lg-2 control-label"></label>
									<div class="col-lg-10">
										<button type="submit" class="btn btn-default">Submit</button>
									</div>
								</div> -->

								</section>
								<h3>Step Final</h3>
								<section>
								<div class="form-group clearfix">
									<div class="col-lg-12">
										<input id="acceptTerms-2" name="acceptTerms2" type="checkbox"
											class="required"> <label for="acceptTerms-2">I
											agree with the Terms and Conditions.</label>
									</div>
								</div>
								</section>
							</div>

						</form>
						<button id="save" ng-click="addUser()" style="display: none;"></button>
					</div>
				</div>
			</div>
			<!-- End row -->

		</div>
		<!-- container -->
	</div>
	<!-- content -->
</div>
<!-- ============================================================== -->
<!-- End Right content here -->
<!-- ============================================================== -->


<script type="text/javascript">
	function checkPasswordMatch() {
		var password = $("#password2").val();
		var confirmPassword = $("#confirm2").val();

		if (password != confirmPassword) {
			$("#divCheckPasswordMatch").html("Passwords do not match!");
			$("#confirm2").val("");
		} else
			$("#divCheckPasswordMatch").html("Passwords match. CLICK NEXT");
	}
</script>

<!-- footer -->
<jsp:include page="footer.jsp"></jsp:include>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/scripts/user-angular.js"></script>
	<!--wizard initialization-->
<script src="${pageContext.request.contextPath}/resources/static/assets/pages/jquery.wizard-init.js" type="text/javascript"></script>
<!--Form Wizard-->
    <script src="${pageContext.request.contextPath}/resources/static/assets/plugins/jquery.steps/build/jquery.steps.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/assets/plugins/jquery-validation/dist/jquery.validate.min.js"></script>

    <!--wizard initialization-->
    <script src="${pageContext.request.contextPath}/resources/static/assets/pages/jquery.wizard-init.js" type="text/javascript"></script>