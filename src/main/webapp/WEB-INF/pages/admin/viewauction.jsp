<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Auction List</title>
<link
	href="${pageContext.request.contextPath}/resources/static/assets/plugins/custombox/dist/custombox.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/static/assets/plugins/magnific-popup/dist/magnific-popup.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/static/assets/plugins/jquery-datatables-editable/datatables.css" />
<link href="${pageContext.request.contextPath}/resources/static/assets/plugins/bootstrap-datetimepicker/css/bootstrap-combined.min.css" 
rel="stylesheet" type="text/css" />
<!-- header -->
<jsp:include page="header.jsp"></jsp:include>

	<!-- menu -->
	<jsp:include page="menu.jsp"></jsp:include>
	<!-- left content -->
	<jsp:include page="left-content.jsp"></jsp:include>

	<!-- ============================================================== -->
	<!-- Start right Content here -->
	<!-- ============================================================== -->
	<div class="content-page" ng-controller="auctionCtrl">
		<!-- Start content -->
		<div class="content">
			<div class="container">
				<!-- Page-Title -->
				<div class="row">
					<div class="col-sm-12">
						<h4 class="page-title">Auction Management</h4>
						<ol class="breadcrumb">
							<li><a href="#">DENH TLAI</a></li>
							<li><a href="#">Auction Management</a></li>
							<li class="active">Auction List</li>
						</ol>
					</div>
				</div>				
				
				<div class="row">
					<div class="col-lg-12">
						<div class="card-box">
							<div class="row m-t-10 m-b-10">
								<div class="col-sm-4 col-lg-6">
									<form role="form">
										<div class="form-group contact-search m-b-30">
											<input type="text" id="search" name="search" ng-model="proName" ng-change="searchProName(proName)"
												class="form-control" placeholder="Search...">
											<button type="submit" class="btn btn-white">
												<i class="fa fa-search"></i>
											</button>
										</div>
									</form>
								</div>
								<div class="col-sm-2 col-lg-6">
									<a href="${pageContext.request.contextPath}/admin/addauction"
										class="btn btn-default btn-md waves-effect waves-light m-b-30"><i
										class="md md-add"></i> Add Auction
									</a>
								</div>
							</div>
							
							<div class="table-responsive">
							
							<!-- Table Data-->
								<table class="table table-hover mails m-0 table table-actions-bar">
									<thead>
										<tr>
											<th>
												<div
													class="checkbox checkbox-primary checkbox-single m-r-15">
													<input id="action-checkbox" type="checkbox"> <label
														for="action-checkbox"></label>
												</div>
											</th>
											<th>
												<div class="btn-group dropdown">
													<button type="button"
														class="btn btn-white btn-xs dropdown-toggle waves-effect waves-light"
														data-toggle="dropdown" aria-expanded="false">
														<i class="caret"></i>
													</button>
												</div>
											</th>
											<th>Product_ID</th>
											<th>Product_Name</th>
											<th>Product_Condition</th>
											<th>Supplier</th>
											<th>Start Price</th>
											<th>Start Date</th>
											<th>End Date</th>
											<th>Status</th>
											<th>Total Bids</th>
											<th style="min-width: 90px;">Action</th>
										</tr>
									</thead>

									<tbody>
										<tr ng-repeat="a in auction | orderBy:['-auction_id', '-product.product_id']">
											<td>
												<div class="checkbox checkbox-primary m-r-15">
													<input id="checkbox2" type="checkbox"> <label
														for="checkbox2"></label>
												</div>
											</td>
											<td ng-repeat="proimg in a.product.gallery" ng-show="$first">
												<img
												ng-cloak src="{{proimg.image_path}}"
												class="thumb-sm" alt="product-img"></td>
											<td ng-cloak>{{a.product.product_id}}</td>
											<td ng-cloak>{{a.product.product_name}}</td>
											<td ng-cloak>{{a.product_condition}}</td>
											<td ng-cloak>{{a.product.supplier.contact_name}}</td>
											<td ng-cloak>{{a.start_price}}</td>
											<td ng-cloak>{{a.start_date}}</td>
											<td ng-cloak>{{a.end_date}}</td>
											<td ng-if="a.status=='1'"><i class="table-action-btn fa fa-check" style="color:#3498db;"
												aria-hidden="true"></i></td>
											<td ng-if="a.status=='0'"><i class="table-action-btn fa fa-times" style="color:#e74c3c; "
												aria-hidden="true"></i></td>
											<td ng-if="a.status=='3'"><i class="table-action-btn fa fa-gavel" style="color: #2ecc71;"
												aria-hidden="true"></i></td>
											<td style="text-align: center"><strong ng-cloak>{{a.num_bid}} Bid</strong></td>
											<td class="action">
												<a href="#"><i class="fa fa-eye fa-lg text-primary"
													title="View bids"></i></a>&nbsp;&nbsp;
												<a href="#" data-toggle="modal" data-target="#myModal"
													ng-click="getAuctionById(a.auction_id)">
													<i class="fa fa-pencil fa-lg text-warning" title="Edit" style="margin: 1px 0px;"></i></a>&nbsp;
												<a href="#" data-toggle="modal"
													ng-click="deleteAuction(a.auction_id)">
												<i class="fa fa-trash-o fa-lg text-danger" title="delete"></i></a>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!-- Table Data-->

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
						<!-- card-box-->
					</div>
					<!-- end col -->
				</div>
				<!-- end row -->
			</div>
			<!-- container -->
		</div>
		
			<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog" style="z-index:10000;">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">Update Auction Information</h4>
				</div>
				<div class="modal-body">
					<form id="wizard-validation-form">
						<section>
							<div class="form-group clearfix">
								<label class="col-lg-2 control-label" for="supplier">Supplier
									Name *</label>
								<div class="col-lg-10">
									<select class="form-control required" name="supplier" 
										ng-model="sup" id="supplier"
										ng-options="s.supplier_id as s.contact_name for s in supplier" ng-cloak value="{{contact_name}}">
										<!-- <option value="" style="display:none">-- Choose Supplier --</option> -->
									</select>
								</div>
							</div>
							<div class="form-group clearfix">
								<label class="col-lg-2 control-label" for="product">Product
									*</label>
								<div class="col-lg-10">
									<select class="form-control required" name="product" id="select"
										ng-model="product_name" ng-options="p.product_id as p.product_name for p in product" ng-cloak>
										<option value="" style="display:none">{{product_name}}</option>
									</select>
								</div>
							</div>
							<div class="form-group clearfix">
								<label class="col-lg-2 control-label" for="product">Product
									Condition*</label>
								<div class="col-lg-10">
									<select class="form-control required" name="product"
										ng-model="product_condition" ng-cloak value="{{product_condition}}" required>
										<!-- <option value="" ng-selected="true">-- Choose Condition	--</option> -->
										<option value="Very_Good">Very Good</option>
										<option value="Good">Good</option>
										<option value="Like_New">Like New</option>
										<option value="New">New</option>
										<option value="Second_Hand">Second Hand</option>
									</select>
								</div>
							</div>
							<div class="form-group clearfix">
								<label class="col-lg-2 control-label" for="startprice">
									Start Price *</label>
								<div class="col-lg-10">
									<input id="startprice" name="startprice" type="number"
										class="required form-control" placeholder="$"
										ng-model="start_price" ng-value="start_price" required>
								</div>
							</div>
							<div class="form-group clearfix">
								<label class="col-lg-2 control-label " for="increseprice">
									Increment Price *</label>
								<div class="col-lg-10">
									<input id="increseprice" name="increseprice" type="number"
										class="required form-control" placeholder="$"
										ng-model="increment_price" ng-value="increment_price" required>
								</div>
							</div>

							<div class="form-group clearfix">
								<label class="col-lg-2 control-label " for="buyprice">Buy
									Now Price *</label>
								<div class="col-lg-10">
									<input id="buyprice" name="buyprice" type="number"
										class="required form-control" placeholder="$"
										ng-model="buy_price" ng-value="buy_price" required>
								</div>
							</div>

							<div class="form-group clearfix">
								<label class="col-lg-2 control-label " for="startdate">Start
									Date *</label>
								<div class="col-lg-10">
									<div class="input-group">
										<input type="text" id="startDate" class="required form-control"
											ng-cloak value="{{start_date}}" ng-disabled="true"
											ng-model="start_date" > <span
											class="input-group-addon bg-custom b-0 text-white"><i
											class="icon-calender"></i></span>
									</div>
									<!-- input-group -->
								</div>
							</div>
							<div class="form-group clearfix">
								<label class="control-label col-lg-2">End Date *</label>
								<div class="col-lg-10">
									

									<div class="input-group" id="end">
										<input type="text" class="required form-control add-on"
											placeholder="dd-mm-yyyy hh:mm:ss" id="endDate" name="endDate"
											ng-model="end_date" ng-cloak value="{{end_date}}" ng-blur="checkErr()"> <span
											class="add-on input-group-addon bg-custom b-0 text-white">
											<i data-time-icon="icon-time" data-date-icon="icon-calendar"></i>
										</span>
									</div>
									<!-- input-group -->
								</div>
							</div>

							<div class="form-group clearfix">
								<label class="col-lg-2 control-label">Status</label>
								<div class="col-lg-10">
									<div class="radio radio-info radio-inline">
										<input type="radio" id="status1" name="status"
											ng-model="status" value="1"> <label for="status1">
											Enable </label>
									</div>
									<div class="radio radio-inline">
										<input type="radio" id="status2" name="status"
											ng-model="status" value="0" > <label for="status2">
											Disable </label>
									</div>
								</div>
							</div>

							<div class="form-group clearfix">
								<label class="col-lg-2 control-label">Comment</label>
								<div class="col-lg-10">
									<textarea class="form-control" rows="5" ng-model="comment" ng-cloak value="{{comment}}"></textarea>
								</div>
							</div>

							<div class="form-group clearfix">
								<label class="col-lg-12 control-label ">(*) Mandatory</label>
							</div>
						</section>
							<div class="row">
								<div class="col-sm-12">
									<div class="text-center p-20">
										<button type="button"
											class="btn w-sm btn-success waves-effect waves-light"
											ng-click="updateAuction()">
											<i class="fa fa-floppy-o" aria-hidden="true"></i> Update
										</button>
										<button type="button" data-dismiss="modal"
											class="btn w-sm btn-danger waves-effect waves-light">
											<i class="fa fa-times" aria-hidden="true"></i> Cancel
										</button>
									</div>
								</div>
							</div>
						</form>
				</div>
<!-- 				<div class="modal-footer"> -->
<!-- 					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button> -->
<!-- 				</div> -->
			</div>
		</div>
	</div>
		
		
		<!-- content -->
	</div>
	

	<!-- footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	<script src="${pageContext.request.contextPath}/resources/scripts/auction-angular.js"></script>
