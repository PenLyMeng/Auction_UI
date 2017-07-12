<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Management</title>
<link href="${pageContext.request.contextPath}/resources/static/assets/plugins/bootstrap-datetimepicker/css/bootstrap-combined.min.css" 
rel="stylesheet" type="text/css" />
<!-- header -->
<jsp:include page="header.jsp"></jsp:include>

<!-- menu -->
<jsp:include page="menu.jsp"></jsp:include>
<!-- left content -->
<jsp:include page="left-content.jsp"></jsp:include>

<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="content-page" ng-controller="viewUserCtrl">
	<!-- Start content -->
	<div class="content">
		<div class="container">

			<!-- Page-Title -->
			<div class="row">
				<div class="col-sm-12">
					<h4 class="page-title">Users</h4>
					<ol class="breadcrumb">
						<li><a href="#">DENH TLAI</a></li>
						<li class="active">Users</li>
					</ol>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<div class="card-box">	
						<div class="row">
							<div class="col-sm-8">
								<form role="form">
									<div class="form-group contact-search m-b-30">
										<input type="text" id="search" class="form-control"
											placeholder="Search..." ng-model="str_search">
										<button type="submit" class="btn btn-white">
											<i class="fa fa-search"></i>
										</button>
									</div>
									<!-- form-group -->
								</form>
							</div>
							<div class="col-sm-4">
								<a href="${pageContext.request.contextPath}/admin/adduser"
									class="btn btn-default btn-md waves-effect waves-light m-b-30"><i
									class="md md-add"></i> Add Users</a>
							</div>
						</div>

						<div class="table-responsive">
							<table
								class="table table-hover mails m-0 table table-actions-bar">
								<thead>
									<tr>
										<th style="min-width: 95px;" class="text-center"></th>
										<th>UserName</th>
										<th>FirstName</th>
										<th>LastName</th>
										<th>Email</th>
										<th>Status</th>
										<th>Type</th>
										<th style="min-width: 90px;">Action</th>
									</tr>
								</thead>
								<tbody class="body">
									<tr ng-repeat="u in user | filter:str_search | orderBy:'-user_id'">
										<td class="text-center">
											
											<img
											src="${pageContext.request.contextPath}/resources/static/assets/images/users/avatar-5.jpg"
											alt="contact-img" title="contact-img"
											class="img-circle thumb-sm" />
										</td>
										<td ng-cloak>{{u.user_name}}</td>
										<td ng-cloak>{{u.first_name}}</td>
										<td ng-cloak>{{u.last_name}}</td>
										<td ng-cloak>{{u.email}}</td>
										<td ng-if="u.status=='1'"><i class="fa fa-check fa-lg text-primary"
												aria-hidden="true"></i></td>
										<td ng-if="u.status=='0'"><i class="fa fa-times fa-lg text-danger"
												aria-hidden="true"></i></td>
										<td ng-cloak>{{u.type}}</td>
										<td><a href="" data-toggle="modal" data-target=".enterData" 
												class="table-action-btn" ng-click="getUserByID(u.user_id)">
												<i class="md md-edit text-warning"></i></a>
											<a href="#" class="table-action-btn" ng-click="deleteUser(u.user_id)">
												<i class="md md-delete text-danger"></i></a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- Pagination-->
						<div class="row">
							<div class="col-sm-6">
								<div class="dataTables_info" id="datatable-editable_info"
									role="status" aria-live="polite" ng-cloak>Showing {{pages}} to {{totalpages}} of {{totalcount}}
									entries</div>
							</div>
							<div class="col-sm-6">
								<div id="PAGINATION" class="pull-right"></div>
							</div>
						</div>
						<!-- End Pagination-->
					</div>
				</div>
				<!-- end col -->
			</div>
		</div>
		<!-- container -->
	</div>
	<!-- content -->


<!-- Modal -->
<div class="modal fade enterData" id="myModal" tabindex="-1"
	role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">Update User</h4>
			</div>
			<div class="modal-body">
				<form name="myForm">
					<!--  User name -->
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="userName2">Username *</label>
						<div class="col-lg-10">
							<input class=" form-control required" id="user_name"
								name="user_name" type="text" ng-cloak value={{user_name}}>
						</div>
					</div>
					<!-- User Password -->
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="password2">Password *</label>
						<div class="col-lg-10">
							<input id="password2" name="password" type="password"
								class="required form-control" ng-cloak value={{password}}>
						</div>
					</div>

					<!--  Type of / Parent ID -->
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="email2">Email *</label>
						<div class="col-lg-10">
							<input id="email2" name="email" type="text"
								class="required email form-control" ng-cloak value={{email}}>
						</div>
					</div>

					<!--  Status -->
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="phone">Contact Number *</label>
						<div class="col-lg-10">
							<input id="phone" name="phone" type="text" placeholder="Ex: 012345678 (Allow only number, no space)"
								class="required form-control" ng-cloak value={{contact}} ng-pattern="/^\d+$/">
						</div>
					</div>
			
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="fname">First Name *</label>
						<div class="col-lg-10">
							<input id="fname" name="fname" type="text"
								class="form-control" ng-cloak value={{first_name}}>
						</div>		
					</div>
					
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="lname">Last Name *</label>
						<div class="col-lg-10">
							<input id="lname" name="lname" type="text"
								class="form-control" ng-cloak value={{last_name}}>
						</div>	
					</div>
					
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="lname">Gender *</label>
						<div class="col-lg-10">
							<select class="form-control select2" name="gender" ng-cloak value={{gender}}>
								<option value="female">Female</option>
								<option value="male">Male</option>
							</select>
						</div>
					</div>
					
					<div class="form-group row" >
						<label class="control-label col-lg-2">Date of Birth</label>
						<div class="col-lg-10">
							<div class="input-group" id="dateofbirth">
								<input type="text" class="required form-control add-on" ng-model="dob"
									placeholder="dd-MM-yyyy" id="dob1" ng-cloak value="{{dob}}"> 
								<span class="add-on input-group-addon bg-custom b-0 text-white" > <i data-time-icon="icon-time"
											data-date-icon="icon-calendar"></i></span>
							</div>
							<!-- input-group -->
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-lg-2 control-label">Address</label>
						<div class="col-lg-10">
							<textarea class="required form-control" rows="5"
								 ng-cloak value={{address}}></textarea>
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-lg-2 control-label">Photo</label>
						<div class="col-lg-10 dropzone dz-clickable" id="dropzone">
							<div class="dz-default dz-message" ng-cloak value={{photo}}></div>
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-lg-2 control-label">Role</label>
						<div class="col-lg-10">
							<div class="radio radio-info radio-inline">
								<input type="radio" id="role1" name="role"
									value="admin"> 
									<label for="role1"> Admin </label>
							</div>
							<div class="radio radio-inline">
								<input type="radio" id="role2" name="role"
									value="bidder" > 
									<label for="role2"> Bidder </label>
							</div>
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-lg-2 control-label">Status</label>
						<div class="col-lg-10">
							<div class="radio radio-info radio-inline">
								<input type="radio" id="status1" name="status"
									value="1" > <label for="status1">
									Enable </label>
							</div>
							<div class="radio radio-inline">
								<input type="radio" id="status2" name="status" 
									value="0" > <label
									for="status2"> Disable </label>
							</div>
						</div>
					</div>
					
					<div class="form-group row">
						<label class="col-lg-2 control-label">Comment</label>
						<div class="col-lg-10">
							<textarea class="form-control" rows="5" ng-cloak value={{comment}}></textarea>
						</div>
					</div>
					
					<div class="form-group row">
						<label for="" class="col-sm-2 form-control-label"></label>
						<div class="col-sm-10">	
							<button type="button" class="btn btn-success btn-md"
								ng-model="user_id" ng-click="updateUser(user_id)"
								id="u_submit" data-dismiss="modal">Update</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!--  end modal  -->

<!-- footer -->
<jsp:include page="footer.jsp"></jsp:include>
>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/scripts/user-angular.js"></script>
