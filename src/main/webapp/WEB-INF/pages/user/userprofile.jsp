<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix='sec'
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="cambodia_auction"></spring:message></title>
<!-- header -->
<jsp:include page="../header.jsp" />
<!-- menu -->
<jsp:include page="../menu.jsp"></jsp:include>
<style>
.left .nav a, .left .panel-title {
	color: gray;
}

.userprofile .panel.panel-default.panel-body, .userprofile .table {
	padding: 5px;
}

.myaccount .list, .myaccount .won-list {
	background-color: #fff;
	border: 1px solid #ebebeb;
	border-radius: 4px;
	margin-top: 10px;
	margin-left: 7px;
	margin-right: 7px;
	padding: 6px;
	position: relative;
}

.myaccount .list .contact {
	margin: 10px;
	position: absolute;
	bottom: 0;
	right: 0;
}

#bid .img-responsive, #won .img-responsive {
	border: 4px solid #fff;
	box-shadow: 0 0 1px 1px rgba(0, 0, 0, .15);
	-webkit-box-shadow: 0 0 1px 1px rgba(0, 0, 0, .15);
	-moz-box-shadow: 0 0 1px 1px rgba(0, 0, 0, .15);
	border-radius: 3px;
}

.userprofile .row {
	margin-right: -15px;
	margin-left: -15px;
}

.userprofile .col-sm-2 {
	padding-left: 0px;
	padding-right: 0px;
	margin-left: 15px;
}

.userprofile .nav-pills>li.active>a, .userprofile .nav-pills>li.active>a:focus,
	.userprofile .nav-pills>li.active>a:hover {
	background-color: #238fc7;
}

#credit, #invoice {
	position: relative;
	top: 0;
	width: 97%;
	display: none;
}

#invoice {
	position: relative;
	top: 0;
	width: 97%;
	display: none;
}

#invoice hr {
	padding: 20px 0px;
}

#won {
	position: relative;
	top: 0;
	width: 97%;
	display: none;
}
</style>
</head>
<!--  style="width: 77%;" -->
<div class="container userprofile" ng-controller="userBidHistory">
	<div class="row">
		<div class="col-md-12">
			<ul class="list-group" style="margin-top: 15px;">
				<li class="list-group-item sublinkcategory"><spring:message
						code="home"></spring:message> / <spring:message
						code="user"></spring:message> / <spring:message
						code="profile"></spring:message></li>
			</ul>
		</div>
		<div class="col-md-2 col-xs-12 left">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title"><spring:message code="bidding"></spring:message></h3>
				</div>
				<ul class="nav nav-pills nav-stacked" style="padding: 1px 3px;">
					<li class="active"><a href="" onclick="onBid()"><spring:message code="active"></spring:message></a></li>
					<li><a href="" onclick="onWon()"><spring:message code="won"></spring:message></a></li>
					<li><a href=""><spring:message code="not_won"></spring:message></a></li>
					<li><a href="#"><spring:message code="wishlist"></spring:message></a></li>
					<li><a href="" onclick="onInvoice()"><spring:message code="invoice"></spring:message></a></li>
				</ul>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title"><spring:message code="account"></spring:message></h3>
				</div>
				<ul class="nav nav-pills nav-stacked" style="padding: 1px 3px;">
					<li><a href="" onclick="onDetail()"><spring:message code="details"></spring:message></a></li>
					<li><a href="" onclick="onChangePassword()"><spring:message code="password"></spring:message></a></li>
					<li><a href="" onclick="onCredit()"><spring:message code="credit"></spring:message></a></li>
				</ul>
			</div>
		</div>
		<div class="col-md-10 col-xs-12 myaccount main">

			<!-- ============================ BID ACTIVE ===================== -->
			<div class="panel panel-default" id="bid">
				<div class="panel-heading">
					<div class="row">
						<div class="col-sm-2 hidden-xs"></div>
						<div class="col-sm-6">
							<spring:message code="title"></spring:message><br><spring:message code="current_price"></spring:message> &nbsp;|&nbsp; <spring:message code="my_bid"></spring:message>
						</div>
						<div class="col-sm-3"><spring:message code="remaining_time_bids"></spring:message></div>
					</div>
				</div>
				<div class="list clearfix" ng-repeat="ub in userBidHistory"
					ng-if="ub.auction.status=='1'">
					<div class="row">
						<div class="col-sm-2">
							<a
								href="${pageContext.request.contextPath}/detail?Aid={{ub.auction.auction_id}}">
								<img ng-cloak alt="" src="{{ub.image_path}}" class="img-responsive"
								style="width: 149px; height: 130px;">
							</a>
						</div>
						<div class="col-sm-6">
							<p>
								<strong><a href="#" ng-cloak>{{ub.auction.product.product_name}}</a></strong>
							</p>
							<p ng-cloak><spring:message code="current_price"></spring:message>$ {{ub.auction.current_price}}
								&nbsp;&nbsp;|&nbsp;&nbsp;<spring:message code="your_bid"></spring:message> $
								{{ub.user_latest_current_price}}</p>
						</div>
						<div class="col-sm-3 text-right" ng-cloak>{{ub.remainingTime |
							durationview}}</div>
					</div>
					<button class="btn btn-default contact"><spring:message code="contact_s"></spring:message></button>
				</div>

			</div>


			<!-- ============================ BID WON ===================== -->
			<div class="panel panel-default" id="won">
				<div class="panel-heading">
					<div class="row">
						<div class="col-sm-2 hidden-xs"></div>
						<div class="col-sm-8">
							<spring:message code="title"></spring:message><br><spring:message code="won_datetime"></spring:message>
							<div class="row">
								<div class="col-sm-4" id="qty"><spring:message code="quantity"></spring:message></div>
								<div class="col-sm-4"><spring:message code="price"></spring:message></div>
								<div class="col-sm-4"><spring:message code="total"></spring:message></div>
							</div>
						</div>
					</div>
				</div>
				<div class="list clearfix" ng-repeat="ub in userBidHistory"
					ng-if="ub.auction.status=='3' || ub.auction.status=='4'">
					<div class="row">
						<div class="col-sm-2">
							<a ng-cloak
								href="${pageContext.request.contextPath}/detail?Aid={{ub.auction.auction_id}}">
								<img alt="" ng-cloak src="{{ub.image_path}}" class="img-responsive"
								style="width: 149px; height: 130px;">
							</a>
						</div>
						<div class="col-sm-8">
							<p>
								<strong><a ng-cloak href="#">{{ub.auction.product.product_name}}</a></strong><br>
								{{ub.auction.end_date}}
							</p>
							<div class="row">
								<div class="col-sm-4">1</div>
								<div class="col-sm-4" ng-cloak>
									<strong>$ {{ub.auction.current_price}}</strong>
								</div>
								<div class="col-sm-4" ng-cloak>$ {{ub.auction.current_price * 1}}</div>
							</div>

						</div>
					</div>
					<div ng-if="ub.auction.status=='3'">
						<button class="btn btn-default contact" ng-disabled="disable" ng-click="checkOut(ub)"><spring:message code="checkout"></spring:message></button>
					</div>
					
				</div>
			</div>

					<!-- ======================= TOP UP ==================== -->
			<div class="panel panel-default" id="credit" style="display:none">

				<div class="panel-heading"><spring:message code="information"></spring:message></div>
				<div class="panel-body">
					<div class="tab-content">
						<div class="tab-panel">
							<form class="form-horizontal" role="form">
								<div class="form-group">
									<label class="control-label col-sm-3"><spring:message code="top_up_amount"></spring:message>: </label>
									<div class="col-sm-4">
										<select class="form-control selectCurr" id="curr" ng-model="curr" required>
											<option value="USD" ng-selected="true"><spring:message code="us_dollar"></spring:message></option>
											<option value="KHR"><spring:message code="cambodian_riel"></spring:message></option>
										</select>
									</div>
									<label class="control-label col-sm-4" ng-cloak><spring:message code="total_amount"></spring:message>: <font
										color="#238fc7">{{ending_amount}}</font> <spring:message code="credit"></spring:message>
									</label>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-4">
										<input ng-model="balance" type="number" class="form-control" placeholder="<spring:message code='type_your_balance'></spring:message>">
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-3 col-sm-3">
										<button type="submit" class="btn btn-default"
											ng-disabled="balance < 1 || !(!!balance)" ng-click="addTopUp()">
											<i class="fa fa-plus" aria-hidden="true"></i> <spring:message code="top_up"></spring:message>
										</button>
									</div>
								</div>
							</form>
						</div>
					</div>

				</div>

			</div>
			
			<!-- ============================ Invoice ===================== -->
			<div class="panel panel-default" id="invoice">
				<div class="panel-heading">
					<spring:message code="invoices"></spring:message>Invoices
					<div class="btn-group pull-right">
						<button class="btn btn-default btn-xs" onclick="onWon()">
							<i class="fa fa-chevron-left" aria-hidden="true"></i> <spring:message code="back"></spring:message>
						</button>
						
					</div>
				</div>
				<div class="panel-body" id="printInvoice">
					<div class="row">
						<div class="col-sm-5 pull-left">
							<img alt=""
								src="${pageContext.request.contextPath}/resources/static/images/denhtlai.png"
								class="img-responsive" style="width: 80%">
						</div>
						
					</div>
					<hr>
					<div class="row" style="padding-bottom: 150px;">
						<div class="col-sm-4 ">
							<strong><spring:message code="bidder_info"></spring:message></strong><br> <span><spring:message code="bidder"></spring:message>: <sec:authentication
									property="principal.user_name" />
							</span><br> 
							<spring:message code="address"></spring:message>: <span id="address"></span>
						</div>
						<div class="col-sm-5 text-center">
							<strong><spring:message code="created_date"></spring:message></strong><br> <span id="created-date"></span>

						</div>
						
					</div>
					<table class="table">
						<tbody>
							<tr class="active">
								<th>#</th>
								<th><spring:message code="items"></spring:message></th>
								<th class="hidden-xs"><spring:message code="quantity"></spring:message></th>
								<th class="hidden-xs"><spring:message code="unit_price"></spring:message></th>
								<th><spring:message code="total"></spring:message></th>
								<td class="hidden-xs"></td>

							</tr>
							<tr>
								<td>1</td>
								<td><a href=""><span id="item-name"></span> 
									<span id="auction_id" ng-show="false"></span></a></td>
								<td class="hidden-xs"><span id="qty">1</span></td>
								<td class="hidden-xs">$ <span id="unit-price"></span></td>
								<td class="hidden-xs">$ <span id="total-price"></span></td>
							</tr>
							<tr>

								<td colspan="3"></td>
								<td><label><spring:message code="sub_total"></spring:message></label></td>
								<td>$ <span id="sub-total"></span></td>
								<td class="hidden-xs"></td>
							</tr>
							<tr>
								<td colspan="3"></td>
								<td><label><spring:message code="sale_tax"></spring:message></label></td>
								<td>$0.00</td>
								<td class="hidden-xs"></td>
							</tr>
							<tr class="success">
								<td colspan="3"></td>
								<td><label><spring:message code="total"></spring:message></label></td>
								<td>$ <strong id="total"></strong></td>
								<td class="hidden-xs"></td>
							</tr>
							<tr>
								<td colspan="3"></td>
								<td>
									<div class="btn-group pull-right">
										<button class="btn btn-default" style="margin-top: 25px;"
											id="print" onclick="printDiv('printInvoice')">
											<i class="fa fa-print" aria-hidden="true"></i>
										</button>
									</div>
								</td>
								<td>
									<div class="btn-group">
										<button class="btn btn-default" style="margin-top: 25px;" ng-click='addInvoice()'>
											<spring:message code="submit"></spring:message></button>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>

			<!--  User Details by EAN SOKCHOMRERN -->
			<!-- ============================ USER DETAILS ===================== -->

			<div class="panel panel-default" id="detail" style="display:none">

				<!-- form register -->
				<form class="form-horizontal" role="form" id="myForm">
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
										<label class="control-label col-sm-3" for="contact"><spring:message
												code="contact"></spring:message> <sup><i
												class="glyphicon glyphicon-star"></i></sup></label>
										<div class="col-sm-7">
											<input type="text" class="form-control" id="contact" required
												placeholder="Ex: 012 345 678" ng-model="contact">
										</div>
									</div>
								</div>

								<div class="list-group-item">
									<small><spring:message code="additional_information"></spring:message></small>
								</div>
								<div class="list-group-item">
									<div class="form-group">
										<label class="control-label col-sm-3" for="fname"><spring:message
												code="first_name"></spring:message> <sup><i
												class="glyphicon glyphicon-star"></i></sup></label>
										<div class="col-sm-7">
											<input type="text" class="form-control" id="first_name"
												ng-model="first_name" required>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-sm-3" for="lname"><spring:message
												code="last_name"></spring:message> <sup><i
												class="glyphicon glyphicon-star"></i></sup></label>
										<div class="col-sm-7">
											<input type="text" class="form-control" id="last_name"
												ng-model="last_name" required>
										</div>
									</div>
									<div class="form-group">
										<label class="control-label col-sm-3" for="gender"><spring:message
												code="gender"></spring:message> <sup><i
												class="glyphicon glyphicon-star"></i></sup></label>
										<div class="col-sm-7">
											<select class="form-control select2" value={{gender}}
												name="gender">
												<option value="female"><spring:message
														code="female"></spring:message></option>
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
													placeholder="mm/dd/yyyy" id="dob" ng-model="dob"
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
												ng-model="address" id="address_u" required></textarea>
										</div>
									</div>

									<div class="form-group">
										<div class="col-sm-3"></div>
										<div class="col-sm-3">
											<button type="button" class="btn btn-primary btn-block"
												ng-click="updateUser()">
												<spring:message code="complete_updated"></spring:message>
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
			</div>
			<!-- end div container -->

			<!--  END User Details-->
			<!-- =============================================== -->
			
				
			<!-- ============================ Change password - EAN SOKCHOMRERN ===================== -->

			<div class="panel panel-default" id="changePassword"  style="display:none">

				<!-- form register -->
				<form class="form-horizontal" role="form" id="myChangePwdForm" name="myChangePwdForm">
						<div class="col-md-12">
							<div class="list-group">
								<div class="list-group-item">
									<p><spring:message code="change_password"></spring:message></p>
								</div>
								<div class="list-group-item">
									<div class="form-group">
										<!-- Current Password -->
										<label class="control-label col-sm-3" for="current_password"><spring:message
												code="current_password"></spring:message> <sup><i
												class="glyphicon glyphicon-star"></i></sup></label>
										<div class="col-sm-7">
											<input type="password" class="form-control" id="current_password"
												ng-model="current_password" required>
										</div>		
									</div>
										<!-- New Password -->
									<div class="form-group">	
										<label class="control-label col-sm-3" for="new_password"><spring:message
												code="new_password"></spring:message> <sup><i
												class="glyphicon glyphicon-star"></i></sup></label>
										<div class="col-sm-7">
											<input type="password" class="form-control" id="new_password"
												ng-model="new_password" required>
										</div>
									</div>
										<!-- Re-Type New Password -->
									<div class="form-group">	
										<label class="control-label col-sm-3" for="retype_new_password"><spring:message
												code="retype_new_password"></spring:message> <sup><i
												class="glyphicon glyphicon-star"></i></sup></label>
										<div class="col-sm-7">
											<input type="password" class="form-control" id="retype_new_password"
												ng-model="retype_new_password"  onkeyup="checkPasswordMatch();" required> 
												<span id="confirm"></span>		
												
										</div>
									</div>		
									<div class="form-group">
										<div class="col-sm-3"></div>
										<div class="col-sm-3">
											<button type="button" class="btn btn-primary btn-block"
												ng-click="updateUserPassword()" ng-disabled="myChangePwdForm.$invalid">
												<spring:message code="complete_updated"></spring:message>
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
			</div>
			<!-- end div container -->
			<!--  END Change Password-->
			
			
	

		</div>
	</div>
</div>




<!-- footer -->
<jsp:include page="../footer.jsp" />


<sec:authentication property="principal.user_id" var="USER_ID" />

<script type="text/javascript">
	var USER_ID = "${USER_ID}";
</script>

<script
	src="${pageContext.request.contextPath}/resources/scripts/bidhistory-angular.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$("#menustand").hide(function() {
			$("#right-content").removeClass('col-md-9');
		});
		$('#searchPanel').hide();
	});

	function printDiv(divName) {
		var printContents = document.getElementById(divName).innerHTML;
		var originalContents = document.body.innerHTML;

		document.body.innerHTML = printContents;

		window.print();

		document.body.innerHTML = originalContents;
	}

	function onCredit() {
		document.getElementById("credit").style.display = "block";
		document.getElementById("bid").style.display = "none";
		document.getElementById("invoice").style.display = "none";
		document.getElementById("won").style.display = "none";
		document.getElementById("detail").style.display = "none";
		document.getElementById("changePassword").style.display = "none";

	}

	function onBid() {
		document.getElementById("credit").style.display = "none";
		document.getElementById("bid").style.display = "block";
		document.getElementById("invoice").style.display = "none";
		document.getElementById("won").style.display = "none";
		document.getElementById("detail").style.display = "none";
		document.getElementById("changePassword").style.display = "none";

	}

	function onInvoice() {
		document.getElementById("credit").style.display = "none";
		document.getElementById("bid").style.display = "none";
		document.getElementById("invoice").style.display = "block";
		document.getElementById("won").style.display = "none";
		document.getElementById("detail").style.display = "none";
		document.getElementById("changePassword").style.display = "none";
	}

	function onWon() {
		document.getElementById("credit").style.display = "none";
		document.getElementById("bid").style.display = "none";
		document.getElementById("invoice").style.display = "none";
		document.getElementById("won").style.display = "block";
		document.getElementById("detail").style.display = "none";
		document.getElementById("changePassword").style.display = "none";
	}
	
	function onDetail() {
		document.getElementById("credit").style.display = "none";
		document.getElementById("bid").style.display = "none";
		document.getElementById("invoice").style.display = "none";
		document.getElementById("won").style.display = "none";
		document.getElementById("detail").style.display = "block";
		document.getElementById("changePassword").style.display = "none";

	}
	
	function onChangePassword(){
		
		document.getElementById("credit").style.display = "none";
		document.getElementById("bid").style.display = "none";
		document.getElementById("invoice").style.display = "none";
		document.getElementById("won").style.display = "none";
		document.getElementById("detail").style.display = "none";
		document.getElementById("changePassword").style.display = "block";

	}
	
	// Check new and re-type password are matched
	function checkPasswordMatch() {
		var password = $("#new_password").val();
		var confirmPassword = $("#retype_new_password").val();

		if (password != confirmPassword) {
			$("#confirm").text("Passwords do not match!");
		} else
			$("#confirm").text("Passwords matched!");
	}

</script>