<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Invoice Management</title>

<!-- header -->
<jsp:include page="header.jsp"></jsp:include>

<!-- menu -->
<jsp:include page="menu.jsp"></jsp:include>
<!-- left content -->
<jsp:include page="left-content.jsp"></jsp:include>

<style>
#invoiceID{
	position: absolute;
    right: 0;
    top: 0;
    margin-right: 0px;
    padding-right: 80px;
    padding-top: 20px;
}


</style>
</head>

<!-- ============================================================== -->
<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="content-page" ng-controller="invoiceCtrl">
	<!-- Start content -->
	<div class="content">
		<div class="container">
			<!-- Page-Title -->
			<div class="row">
				<div class="col-sm-12">
					<h4 class="page-title">Invoice Management</h4>
					<ol class="breadcrumb">
						<li><a href="#">DENH TLAI</a></li>
						<li><a href="#">Invoice Management</a></li>
						<li><a href="${pageContext.request.contextPath}/admin/saleinvoice" style="color: #238fc7;">Sale Invoice</a></li>
					</ol>
				</div>
			</div>

			<div class="row" ng-show="invoiceDetail">
				<div class="col-sm-12">
					<div class="card-box table-responsive">
						<h4 class="m-t-0 header-title">
							<b>Invoice Details</b>
						</h4>
						<table id="datatable-buttons"
							class="table table-striped m-0">
							<thead>
								<tr>
									<th>Date<br>
									<br>Contact
									</th>
									<th>Seller<br>
									<br>Buyer
									</th>
									<th>Invoice ID<br>
									<br>
									<br></th>
									<th>Product<br>
									<br>Address
									</th>
									<th>Price<br>
									<br>
									<br></th>
									<th>Quantity<br>
									<br>First Name
									</th>
									<th>Total<br>
									<br>Last Name
									</th>
									<th>Paid<br> <select class="form-control required">
											
											<option value="unpaid">Unpaid</option>
											<option value="paid">Paid</option>
									</select>
									</th>
								</tr>
							</thead>
							<tbody style="color: #ffffff;">
								<tr
									ng-repeat=" inv in invoiceDetail | orderBy:'-invoice.invoice_id'">
									<td ng-cloak>{{inv.invoice.invoice_date}}<br>
									<br>{{inv.invoice.user.contact}}
									</td>
									<td ng-cloak>Admin<br>
									<br>{{inv.invoice.user.user_name}}
									</td>
									<td><a href="" style="color: #ffffff;" ng-click="findInvoiceDetailByInvoiceId(inv.invoice.invoice_id)" ng-cloak>{{inv.invoice.invoice_id}}</a><br>
									<br>
									<br></td>
									<td ng-cloak>{{inv.auction.product.product_name}}<br>
									<br>{{inv.invoice.user.address}}
									</td>
									<td ng-cloak>{{inv.buy_price}}<br>
									<br>
									<br></td>
									<td ng-cloak>{{inv.qty}}<br>
									<br>{{inv.invoice.user.first_name}}
									</td>
									<td ng-cloak>{{inv.buy_price * inv.qty}}<br>
									<br>{{inv.invoice.user.last_name}}
									</td>
									<td ng-if="inv.invoice.status=='1'"><img alt=""
										src="${pageContext.request.contextPath}/resources/static/images/paidStamp.png"
										class="img-responsive"></td>
									<td ng-if="inv.invoice.status=='0'"><img alt=""
										src="${pageContext.request.contextPath}/resources/static/images/unpaid-stamp.png"
										class="img-responsive"></td>
									</td>
								</tr>
								
							</tbody>
						</table>

						
					</div>
				</div>
			</div>
			
			<!-- ================= Invoice ==================== -->
			<div class="row" ng-show="invoice">
				<div class="col-md-12">
					<div class="card-box">
						<div class="clearfix">
							<div class="pull-left">
								<!-- <h4 class="text-right m-t-20"
									style="font-size: 28px; font-weight: 600;">
									UB<span class="text-custom">O</span>LD
								</h4> -->
								<img src="${pageContext.request.contextPath}/resources/static/images/denhtlai.png" 
								class="img-responsive" style="width:20%; height:20%;">
							</div>
							<div class="pull-right">
								<h4 id="invoiceID" >
									Invoice # <br> <strong ng-cloak>{{invoice_id}}</strong>
								</h4>
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col-md-12">
								<div class="pull-left m-t-30">
									<address>
										<strong>DENH TLAI, Inc.</strong><br> 323 Street, Toul Kork
										<br>Toul Kork, Phnom Penh<br> <abbr
											title="Phone">P:</abbr> (855) 12-345-678
									</address>
								</div>
								<div class="pull-right m-t-30">
									<p>
										<strong>Invoice Date: </strong> 
										<span ng-cloak>{{invoice_date}}</span>
									</p>
									<p class="m-t-10">
										<strong>Invoice Status: </strong> 
										<span class="label label-pink" ng-if="status=='1'">PAID</span>
										<span class="label label-pink" ng-if="status=='0'">UNPAID</span>
									</p>
									<p class="m-t-10">
										<strong>Auction ID: </strong><span ng-cloak>{{auction_id}}</span>
									</p>
								</div>
							</div>
						</div>
						<div class="m-h-50"></div>
						<div class="row">
							<div class="col-md-12">
								<div class="table-responsive">
									<table class="table m-t-30">
										<thead>
											<tr>
												<th>#</th>
												<th>Item</th>
												<th>Quantity</th>
												<th>Unit Cost</th>
												<th>Total</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td>1</td>
												<td ng-cloak>{{product_name}}</td>
												<td ng-cloak>{{qty}}</td>
												<td ng-cloak>{{buy_price}}</td>
												<td ng-cloak>{{buy_price * qty}}</td>
											</tr>																																												
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-3 col-md-offset-9">
								<p class="text-right">
									<b>Sub-total:</b> {{buy_price}}
								</p>
								<p class="text-right">Discout: 0.0%</p>
								<p class="text-right">VAT: 0.0%</p>
								<hr>
								<h3 class="text-right" ng-cloak>USD {{buy_price * qty}}</h3>
							</div>
						</div>
						<hr>
						<div class="hidden-print">
							<div class="pull-right">
								<a href="javascript:window.print()"
									class="btn btn-inverse waves-effect waves-light"><i
									class="fa fa-print"></i></a> <a href="#"
									class="btn btn-primary waves-effect waves-light">Submit</a>
							</div>
							<div class="clearfix"></div>
						</div>
					</div>

				</div>

			</div>

			
		</div>
		
		
	<!-- 	<div class="container" id="invoice" ">
			Page-Title
			<div class="row">
				<div class="col-sm-12">
					<h4 class="page-title">Invoice</h4>
					<ol class="breadcrumb">
						<li><a href="#">DENH TLAI</a></li>
						<li><a href="#">Invoice Management</a></li>
						<li class="active">Sale Invoice</li>
					</ol>
				</div>
			</div>

					</div> -->
		<!-- container -->

	</div>
	<!-- content -->


	<!-- footer -->
	<jsp:include page="footer.jsp"></jsp:include>

	<script
		src="${pageContext.request.contextPath}/resources/scripts/invoice-angular.js"></script>

	<!-- ------------ DataTabeland Button Print----------------- -->
	<script
		src="${pageContext.request.contextPath}/resources/static/assets/plugins/datatables/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/static/assets/plugins/datatables/dataTables.bootstrap.js"></script>

	<script
		src="${pageContext.request.contextPath}/resources/static/assets/plugins/datatables/dataTables.buttons.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/static/assets/plugins/datatables/buttons.bootstrap.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/static/assets/plugins/datatables/pdfmake.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/static/assets/plugins/datatables/buttons.html5.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/static/assets/plugins/datatables/buttons.print.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/static/assets/plugins/datatables/vfs_fonts.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/static/assets/plugins/datatables/jszip.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/static/assets/pages/datatables.init.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			$('#datatable').dataTable();
			var table = $('#datatable-fixed-col').DataTable({
				scrollY : "310px",
				scrollX : true,
				scrollCollapse : true,
				paging : false,
				fixedColumns : {
					leftColumns : 1,
					rightColumns : 1
				}
			});
		});
		TableManageButtons.init();
	</script>