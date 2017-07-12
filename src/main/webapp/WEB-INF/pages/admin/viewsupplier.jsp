<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
					<h4 class="page-title">Suppliers</h4>
					<ol class="breadcrumb">
						<li><a href="#">DENH TLAI</a></li>
						<li><a href="">Suppliers Management</a></li>
						<li class="active">Suppliers List</li>
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
								<a href="${pageContext.request.contextPath}/admin/addsupplier"
									class="btn btn-default btn-md waves-effect waves-light m-b-30"><i
									class="md md-add"></i> Add Supliser</a>
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
										<th>Supplier_ID</th>
										<th>ContactName</th>
										<th>Address</th>
										<th>Email</th>
										<th>Phone</th>
										<th>Status</th>
										<th style="min-width: 90px;">Action</th>
									</tr>
								</thead>
								<tbody class="body">
									<tr
										ng-repeat="s in supplier | filter:str_search |orderBy:'-supplier_id'">
										<td>
											<div class="checkbox checkbox-primary m-r-15">
												<input id="checkbox14" type="checkbox"> <label
													for="checkbox14"></label>
											</div>
										</td>
										<td ng-cloak>{{s.supplier_id}}</td>
										<td ng-cloak>{{s.contact_name}}</td>
										<td ng-cloak>{{s.address}}</td>
										<td ng-cloak>{{s.email}}</td>
										<td ng-cloak>{{s.phone}}</td>
										<td ng-if="s.status=='1'"><i
											class="table-action-btn fa fa-check" style="color: #3498db;"
											aria-hidden="true"></i></td>
										<td ng-if="s.status=='0'"><i
											class="table-action-btn fa fa-times" style="color: #e74c3c;"
											aria-hidden="true"></i></td>

										<!--  Update supplier and pass supplier_id to modal -->
										<td><a href="#" data-toggle="modal"
											data-target=".enterData"
											ng-click="findSupplierById(s.supplier_id)"><i
												class="fa fa-pencil fa-lg text-warning" aria-hidden="true"></i></a>&nbsp;&nbsp;
											<!-- end update supplier --> <!--  delete supplier --> <a
											href="#" ng-click="deleteSupplier(s.supplier_id)"> <i
												class="fa fa-trash fa-lg text-danger" aria-hidden="true"></i>
										</a> <!--  end delete supplier --></td>
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
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">Update Supplier</h4>
				</div>
				<div class="modal-body">
					<form name="myForm">
						<!--  Contact name -->
						<div class="form-group row">
							<label for="contact-name" class="col-sm-2 form-control-label"><strong>Contact
									Name<span class="text-danger">*</span>
							</strong></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="contact-name"
									ng-model="contact_name" ng-cloak value="{{contact_name}}"
									placeholder="Ex: Jonh Query" required>
							</div>
						</div>
						<!--  Phone -->
						<div class="form-group row">
							<label for="phone" class="col-sm-2 form-control-label"><strong>Phone<span
									class="text-danger">*</span></strong></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="phone"
									ng-model="phone"
									placeholder="Ex: 012735487 (not allow letter and space)"
									ng-pattern="/^\d+$/" name="phone" ng-cloak value="{{phone}}" required>
							</div>
						</div>
						<!--  Email -->
						<div class="form-group row">
							<label for="email" class="col-sm-2 form-control-label"><strong>Email<span
									class="text-danger">*</span></strong></label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="email"
									ng-model="email" ng-cloak value="{{email}}"
									placeholder="Ex: example@gmail.com" required>
							</div>
						</div>

						<!--  Address -->
						<div class="form-group row">
							<label for="address" class="col-sm-2 form-control-label"><strong>Address<span
									class="text-danger">*</span></strong></label>
							<div class="col-sm-10">
								<textarea class="form-control" id="address" ng-model="address"
									ng-cloak value="{{address}}"
									placeholder="Ex: House No., Street No, Sangkat, Khan, City"
									required></textarea>
							</div>
						</div>

						<!-- Status -->
						<div class="form-group row">
							<label for="status1" class="col-sm-2 form-control-label"><strong>Status<span
									class="text-danger">*</span></strong></label>
							<div class="col-sm-10">
								<div class="radio radio-info radio-inline">
									<input type="radio" id="status1" name="status"
										ng-model="status" value="1" ng-value="1"
										ng-checked="status==1"> <label for="status1">
										Enable </label>
								</div>
								<div class="radio radio-inline">
									<input type="radio" id="status2" name="status"
										ng-model="status" value="0" ng-value="0"
										ng-checked="status==0"> <label for="status2">
										Disable </label>
								</div>
							</div>
						</div>


						<div class="form-group row">
							<label for="" class="col-sm-2 form-control-label"></label>
							<div class="col-sm-10">

								<button type="button" class="btn btn-success btn-md"
									ng-model="supplier_id" ng-click="updateSupplier(supplier_id)"
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
		src="${pageContext.request.contextPath}/resources/scripts/supplier-angular.js"></script>