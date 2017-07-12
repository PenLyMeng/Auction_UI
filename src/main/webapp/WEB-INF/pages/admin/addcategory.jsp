<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Add Category & Brand </title>
</head>
<!-- header -->
<jsp:include page="header.jsp"></jsp:include>
<!-- menu -->
<jsp:include page="menu.jsp"></jsp:include>
<!-- left content -->
<jsp:include page="left-content.jsp"></jsp:include>


<!-- ============================================================== -->
<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="content-page" data-ng-init="findMainCategories()" ng-controller="myCtrl">
	<!-- Start content -->
	<div class="content">
		<div class="container">
			<!-- Page-Title -->
			<div class="row">
				<div class="col-sm-12">
					<h4 class="page-title">Add Category</h4>
					<ol class="breadcrumb">
						<li><a href="#">DENH TLAI</a></li>
						<li><a href="#">Category Management</a></li>
						<li class="active">Add/Edit Category&Brand</li>
					</ol>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
				
						<div class="row">
							<form name="categoryForm">
							<div class="col-lg-6">
								<div class="card-box">
									<h5 class="text-muted text-uppercase m-t-0 m-b-20">
										<b>Add Category</b>
									</h5>

									<!-- Category Name -->
									<div class="form-group m-b-20">
										<label for="catename">Category Name <span
											class="text-danger">*</span></label> 
										<input type="text" class="form-control" name="catename" id="catename" ng-model="category_name" required>
									</div>
									<!-- Category Description -->
									<div class="form-group m-b-20">
										<label for="catedescript">Category Description</label>
										<textarea class="form-control" rows="3" name="catedescript" id="catedescript" placeholder="Please enter summary"
											ng-model="category_description" required></textarea>
									</div>

									<!-- Type of/ Parent-Id -->
									<div class="form-group m-b-20">
										<label for="parenid">Type of<span class="text-danger">*</span></label>

										<select class="form-control select2" name="category"
											id="selectcateogory" aria-label="ngSelected demo"
											ng-model="parent_id">
											<!-- TODO: Auto select after load page -->
											<!-- -------------------------------- -->
											<optgroup>
												<option ng-repeat="cat in maincategory"
													ng-cloak value="{{cat.category_id}}">{{cat.category_name}}</option>
											</optgroup>
										</select>
									</div>

									<!-- Status -->
									<div class="form-group m-b-20">
										<label class="m-b-15" for="catestatus">Status <span
											class="text-danger">*</span></label> <br />
										<div class="radio radio-inline">
											<input type="radio" id="catestatus1" value="1"
												name="categorystatus" ng-model="status" checked="" required> <label
												for="inlineRadio1"> active </label>
										</div>
										<div class="radio radio-inline">
											<input type="radio" id="catestatus2" value="0"
												name="categorystatus" ng-model="status"> <label
												for="catestatus2">inactive </label>
										</div>
									</div>
									<div class="row">
										<div class="text-center p-20">
											<button type="button" class="btn w-sm btn-white waves-effect">Cancel</button>
											<button type="button"
												class="btn w-sm btn-default waves-effect waves-light"
												ng-click="addCategory()" ng-disabled="categoryForm.$invalid">Save</button>
											<!-- <button type="button"
												class="btn w-sm btn-danger waves-effect waves-light">Delete</button> -->
										</div>
									</div>
								</div>
							</div>
							</form>

							<!-- Brand Section -->
							<form name="brandForm">
							<div class="col-lg-6">
								<div class="card-box">
									<h5 class="text-muted text-uppercase m-t-0 m-b-20">
										<b>Add Brand</b>
									</h5>
									
									<!-- Brand Name -->
									<div class="form-group m-b-20">
										<label for="brandname">Brand Name <span
											class="text-danger">*</span></label> <input type="text"
											class="form-control" name="brandname" id="brandname" ng-model="brand_name" required>
									</div>
									
									<!-- Brand Description -->							
									<div class="form-group m-b-20">
										<label for="branddescipt">Brand Description</label>
										<textarea class="form-control" rows="3" name="branddescipt"
											id="branddescipt" placeholder="Please enter summary" ng-model="brand_description" required></textarea>
									</div>
									
									<!-- Status -->
									<div class="form-group m-b-20">
										<label class="m-b-15" for="brandstatus">Status <span
											class="text-danger">*</span></label> <br />
										<div class="radio radio-inline">
											<input type="radio" id="brandstatus1" value="1"
												name="brandstatus" checked="" ng-model="brand_status"> <label
												for="brandstatus1" required> active </label>
										</div>
										<div class="radio radio-inline">
											<input type="radio" id="brandstatus2" value="0"
												name="brandstatus" ng-model="brand_status"> <label for="brandstatus2">
												inactive </label>
										</div>
									</div>
									<div class="row">
										<div class="text-center p-20">
											<button type="button" class="btn w-sm btn-white waves-effect">Cancel</button>
											<button type="button" class="btn w-sm btn-default waves-effect waves-light" ng-click="addBrand()" ng-disabled="brandForm.$invalid">Save</button>
										<!-- 	<button type="button" class="btn w-sm btn-danger waves-effect waves-light">Delete</button> -->
										</div>
									</div>
								</div>
							
							</div>
							</form>
						</div>
					
				</div>
			</div>
		</div>
		<!-- container -->
	</div>
	<!-- content -->

	<!-- footer -->

	<jsp:include page="footer.jsp"></jsp:include>
	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/category-angular.js"></script>
	
