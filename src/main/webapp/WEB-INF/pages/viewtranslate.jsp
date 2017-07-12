<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><spring:message code="cambodia_auction"></spring:message></title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/accordion-menu.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/css/bootstrap.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/js/accordion-menu.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/js/bootstrap.min.js"></script>
<!-- header -->
<jsp:include page="header.jsp" />
<!-- menu -->
<jsp:include page="menu.jsp" />
<!-- left content -->
<jsp:include page="left-content.jsp" />
<!-- right content -->
	<div class="col-md-9" ng-controller="auctionCtrl" id="right-content">
		<input type="hidden" id="loop_auc_id" value="${param.id}">
		<!-- ================ Item List ================ -->
		<div class="container-fluid">

			<!-- TOP BAR -->
			<div class="well well-sm section-title" style=" background-color: white; margin-top: 10px; ">
				<form action="#" class="form-inline text-right" method="get">
					<input id="ViewStyle" name="ViewStyle" type="hidden" value="grid">
					<input id="StatusFilter" name="StatusFilter" type="hidden" value="active_only">            
					<div class="form-group">
						<div class="btn-group">
							<button id="ShowListView" type="button" class="btn btn-sm btn-primary"><span id="ToggleIcon" class="glyphicon glyphicon-list"></span></button>
							<button id="ShowGridView" type="button" class="btn btn-sm btn-default"><span id="ToggleIcon" class="glyphicon glyphicon-th-large"></span></button>
						</div>
					</div>
					<div class="form-group">
						<div class="btn-group">
							<button id="Status_IncludeActive" type="button" class="btn btn-sm btn-primary"><spring:message code="active"></spring:message></button>
							<button id="Status_IncludeCompleted" type="button" class="btn btn-sm btn-default"><spring:message code="completed"></spring:message></button>
						</div>
					</div>


<%-- 					<div class="panel-collapse collapse" id="item-{{$index+1}}">
				       <ul class="list-group">
				         <li class="list-group-item" ng-repeat="subCategory in c.subCategories">&nbsp;&nbsp;
				         <a href="${pageContext.request.contextPath}/itemlist?cat={{subCategory.category_name}}&&id={{subCategory.category_id}}" class="submenu"><i class="fa fa-chevron-right" aria-hidden="true"></i>
				         &nbsp;&nbsp;{{subCategory.category_name}}</a></li>			         
				       </ul>
				    </div> --%>


					<div class="form-group">
						<div class="input-group">
							<label class="input-group-addon" for="SortFilterOptions"><spring:message code="filter"></spring:message></label>
							<select class="form-control input-sm" id="SortFilterOptions" name="SortFilterOptions" ng-model="brand" 
								ng-options="b.product.brand.brand_id as b.product.brand.brand_name for b in auctionProduct | unique: 'product.brand.brand_id'">
								<option value=""><spring:message code="all"></spring:message></option>								
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<div class="input-group">
							<label class="input-group-addon" for="SortFilterOptions"><spring:message code="sort"></spring:message></label>
							<select class="form-control input-sm" id="SortFilterOptions" name="SortFilterOptions" ng-model="orderList" >
								<option value="">Default</option>
							    <option value="-num_bid">Most Bid</option>
							    <option value="num_bid">Less Bid</option>					 
							    <option value="end_date">Ending soon</option>
							    <option value="product.product_name">Product: A-Z</option>
							    <option value="-product.product_name">Product: Z-A</option>
							    <option value="current_price">Price: Low to Hight</option>
							    <option value="-current_price">Price: High to Low</option>
							</select>
						</div>
					</div>
<!-- 					<input type="submit" id="submitDropDown" class="awe-hidden"> -->
				</form>    
			</div>

			<!-- DATA-LISTING -->
			
			<section data-listingid="327081" style=" width: 100% " ng-repeat="a in auctionProduct | filterBy: ['product.brand.brand_id']: brand | orderBy: orderList ">
				<!-- Can write like this (brand==''?'':brand) -->
				<!-- wrapper div -->
				<div class="panel panel-default clearfix listing" >		

					<!-- image and property -->
					<div class="col-sm-7 img-wraper">
						<!-- img & title -->
						<h1 class="title">
							<a href="#">
								<span class="img" ng-repeat="proimg in a.product.gallery" ng-show="$first">
									<img ng-cloak src="{{proimg.image_path}}" class="img-thumbnail" style="width: 160px; height: 170px" alt="Cinque Terre">
								</span>
								<strong ng-cloak>{{a.product.product_name}}</strong>
							</a>
						</h1>
						<!-- subtitle -->
						<p class="subtitle">
							<a href="#">
								<strong></strong>
							</a>
						</p>
						<!-- seller -->
						<span class="condition">
							<spring:message code="brand"></spring:message>: <a href="#" ng-cloak>{{a.product.brand.brand_name}}</a>
						</span><br>
						<!-- seller -->
						<span class="condition">
							<spring:message code="condition"></spring:message>: <a href="#" ng-cloak>{{a.product_condition}}</a>
						</span><br>

						<span class="seller">
							<spring:message code="seller"></spring:message>: <a href="#" ng-cloak>{{a.product.supplier.contact_name}}</a>
						</span><br>
						
					</div>	<!--End image and property -->

					<!-- Auction Part -->
					<div class="col-sm-5" >
						<span class="label label-primary status-type" style="float: right; background-color: #238FC7 ; margin-top: 5px; "><spring:message code="auction"></spring:message></span><br><br><br><br><br>
						<span style=" text-align: right; ">
							<p class="time remaining" > 
								<span data-epoch="ending" 
								data-end-hide-selector="[data-listingid='327081'] .awe-rt-Done" 
								data-action-time="08/25/2016 00:22:49" 
								data-end-value="Ended" 
								data-action-milliseconds="1472059369000"><spring:message code="remaining"></spring:message></span> <span ng-cloak>{{a.remainingTime | durationview}}</span>
								<span class="awe-rt-Done ">
							</p>
							<p class="bids">
								&nbsp;
								<span class="awe-rt-CurrentPrice price NumberPart" style=" color:#238FC7 "><span ng-cloak>{{a.current_price | currency}}</span></span>
								<span class="glyphicon glyphicon-option-vertical"></span>
								<span class="awe-rt-AcceptedListingActionCount" data-previous-value="0" ng-cloak>{{a.num_bid}}</span>
								<spring:message code="bids"></spring:message>
								&nbsp;
								<a ng-cloak href="/detail/{{a.auction_id}}" class="btn btn-default awe-rt-Active awe-rt-Done"><spring:message code="bid_now"></spring:message> 
									<span class="glyphicon glyphicon-chevron-right"></span>
								</a>
							</p>
						</span>
					</div>	<!-- End auction part -->
					

				</div> <!-- End wrapper div -->
			</section>


		</div>


	</div>

	<!-- footer -->
	<jsp:include page="footer.jsp" />
	<!-- unique script -->
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/js/angular-filter.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/chhuon.js"></script>