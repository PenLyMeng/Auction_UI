<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Category List</title>


<!-- header -->
<jsp:include page="header.jsp"></jsp:include>
<!-- menu -->
<jsp:include page="menu.jsp"></jsp:include>
<!-- left content -->
<jsp:include page="left-content.jsp"></jsp:include>

<!-- ============================================================== -->
<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="content-page" ng-controller="myCtrl">
	<!-- Start content -->
	<div class="content">
		<div class="container">
			<!-- Page-Title -->
			<div class="row">
				<div class="col-sm-12">
					<h4 class="page-title">Category</h4>
					<ol class="breadcrumb">
						<li><a href="#">DENH TLAI</a></li>
						<li><a href="">Category Management</a></li>
						<li class="active">Category List</li>
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
								<a href="${pageContext.request.contextPath}/admin/addcategory"
									class="btn btn-default btn-md waves-effect waves-light m-b-30"><i
									class="md md-add"></i> Add Category</a>
							</div>
						</div>

						<div class="table-responsive">
							<table
								class="table table-hover mails m-0 table table-actions-bar">
								<thead>
									<tr>
										<th style="min-width: 95px;">
											<div class="checkbox checkbox-primary checkbox-single m-r-15">
												<input id="action-checkbox" type="checkbox"> <label
													for="action-checkbox"></label>
											</div>
										</th>
										<th>Category_ID</th>
										<th>CategorytName</th>
										<th>Description</th>
										<th>Parent_ID</th>
										<th>Status</th>
										<th style="min-width: 90px;">Action</th>
									</tr>
								</thead>
								<tbody class="body">
									<tr 
										ng-repeat="cat in category | filter:str_search | orderBy:'-category_id' ">
										<td>
											<div class="checkbox checkbox-primary m-r-15">
												<input id="checkbox5" type="checkbox"> <label
													for="checkbox5"></label>
											</div>
										</td>
										<td ng-cloak>{{cat.category_id}}</td>
										<td ng-cloak>{{cat.category_name}}</td>
										<td ng-cloak>{{cat.category_description}}</td>
										<td ng-cloak>{{cat.parent_id}}</td>
										<td ng-if="cat.status=='1'"><i class="fa fa-check fa-lg text-primary"
												aria-hidden="true"></i></td>
										<td ng-if="cat.status=='0'"><i class="fa fa-times fa-lg text-danger"
												aria-hidden="true"></i></td>
										<td>
										<!--  Update Category -->
											<a href="#" class="table-action-btn"
											data-toggle="modal" data-target=".enterData"
											ng-click="getCategoryByID(cat)">
											<i class="md md-edit text-warning"></i></a> 
										<!--  end updating category -->		
										
										<!--  Delete Category -->		
											<a href="#" class="table-action-btn"
											ng-click="deleteCategory(cat.category_id)">
											<i class="md md-delete text-danger"></i></a>
										</td>
										<!--  End Deleting Category -->
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

	<script type="text/javascript">
		var app = angular.module('myApp', []);
		app.controller('myCtrl', function($rootScope, $scope, $http) {

			$rootScope.getmethod = function() {

				$http.get("http://localhost:8080/rest/category").then(
						function(response) {
							$rootScope.category = response.data.DATA;
							console.log(response.data.DATA);

						});
			}
			$rootScope.getmethod();

		});
	</script>


	<!-- Modal -->
	<div class="modal fade enterData" id="myModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Update Category</h4>
				</div>
				<div class="modal-body">
					<form name="myForm">
						<!--  Category name -->
						<div class="form-group row">
							<label for="category-name" class="col-sm-2 form-control-label"><strong>Category
									Name<span class="text-danger">*</span>
							</strong></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="category-name"
									ng-model="category_name" ng-cloak value="{{category_name}}"
									placeholder="Ex: Automotive" required>
							</div>
						</div>
						<!--  Category Description -->
						<div class="form-group row">
							<label for="category-description"
								class="col-sm-2 form-control-label"><strong>Category
									Description<span class="text-danger">*</span>
							</strong></label>
							<div class="col-sm-10">
								<textarea class="form-control" id="category-description"
									ng-model="category_description"
									ng-cloak value="{{category_description}}"
									placeholder="Please Enter Summary" required></textarea>
							</div>
						</div>

						<!--  Type of / Parent ID -->
						<div class="form-group row">
							<label for="selectcateogory" class="col-sm-2 form-control-label"><strong>Type
									of 
							</strong></label>
							<div class="col-sm-10">
								<select class="form-control select2" name="category"
									id="selectcateogory" aria-label="ngSelected demo" ng-model="mainCat" 
									ng-options="cat.category_id as cat.category_name for cat in mainCategories">
									<!-- TODO: Auto select after load page -->
									<!-- -------------------------------- -->
								</select>
							</div>
						</div>

						<!--  Status -->
						<div class="form-group row">
							<label for="catestatus1" class="col-sm-2 form-control-label"><strong>Status<span
									class="text-danger">*</span>
							</strong></label>
							<div class="col-sm-10">
								<div class="radio-inline">
									<input type="radio" id="catestatus1" value="1"
										name="categorystatus" ng-model="status" checked="" >
									<label for="inlineRadio1"> active </label>
								</div>
								<div class="radio-inline">
									<input type="radio" id="catestatus2" value="0"
										name="categorystatus" ng-model="status"> <label
										for="catestatus2">inactive </label>
								</div>
							</div>
						</div>

						<div class="form-group row">
							<label for="" class="col-sm-2 form-control-label"></label>
							<div class="col-sm-10">

								<button type="button" class="btn btn-success btn-md"
									ng-model="parent_id" ng-click="updateCategory(category_id)"
									ng-disabled="myForm.$invalid" id="u_submit"
									data-dismiss="modal">Update</button>
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
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/scripts/category-angular.js"></script>