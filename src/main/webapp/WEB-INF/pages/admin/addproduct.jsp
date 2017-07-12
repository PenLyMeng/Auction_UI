<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<!-- new css -->
	<link href="${pageContext.request.contextPath}/resources/static/uploadEdit/css/jquery.filer.css" type="text/css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/static/uploadEdit/css/themes/jquery.filer-dragdropbox-theme.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/uploadEdit/fancybox/source/jquery.fancybox.css?v=2.1.5">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/uploadEdit/fancybox/source/helpers/jquery.fancybox-buttons.css?v=1.0.5">

<link href="${pageContext.request.contextPath}/resources/static/uploadEdit/css/jquery.filer.css" type="text/css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/static/uploadEdit/css/themes/jquery.filer-dragdropbox-theme.css" type="text/css" rel="stylesheet" />



<style type="text/css">
.thumb-md {
	border: 1px solid #000;
}
 #browse_gallery{
	margin-left:-105px;
	margin-bottom:35px;
}

/* 	.preview-area{ */
/* 		border: 2px solid white ; */
/* 	} */
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<!-- header -->
<jsp:include page="header.jsp"></jsp:include>
<!-- menu -->
<jsp:include page="menu.jsp"></jsp:include>
<!-- left content -->
<jsp:include page="left-content.jsp"></jsp:include>



<!-- Start right Content here -->
<!-- ============================================================== -->
<div class="content-page" ng-controller="addImageCtrl">
	<!-- Start content -->
	<div class="content">
		<div class="container">
			<!-- Page-Title -->
			<div class="row">
				<div class="col-sm-12">
					<h4 class="page-title">Product Management</h4>
					<ol class="breadcrumb">
						<li><a href="#">iWant Auction</a></li>
						<li><a href="#">eCommerce</a></li>
						<li class="active">Add/Edit</li>
					</ol>
				</div>
			</div>
			<!-- End Row -->

			<div class="row">
				<div class="col-sm-12">
					<form name="add-product-form" id="myform">
						<div class="row">
							<div class="col-lg-6">
								<div class="card-box">
									<h5 class="text-muted text-uppercase m-t-0 m-b-20">
										<b>Add Product</b>
									</h5>
									<div class="form-group m-b-20">
										<label for="productname">Product name <span
											class="text-danger">*</span></label> <input type="text"
											class="form-control" ng-model="pro_name" name="productname"
											id="productname" placeholder="e.g : Nokia8800">
									</div>

									<div class="form-group m-b-20">
										<label for="productdescription">Product Description <span
											class="text-danger">*</span></label>
										<textarea class="form-control" ng-model="pro_description"
											rows="5" name="prodescript" id="productdescription"
											placeholder="Please enter description"  maxlength="250"></textarea>
									</div>

									<div class="form-group m-b-20">
										<label>Supplier <span class="text-danger">*</span></label> <select
											class="form-control select2" name="suppiler" id="suppiler"
											ng-model="pro_supplier" aria-label="ngSelected demo">



											TO<!-- DO: Auto selet after load page -->

											<optgroup name="" id="">
												<option value="">---Please select---</option>
											</optgroup>



											<optgroup ng-repeat="supplier in Supplier">
												<option ng-cloak value="{{supplier.supplier_id}}">{{supplier.contact_name}}</option>
											</optgroup>

										</select>
									</div>

									<!-- 									<h1 ng-repeat="supp in Supplier"> -->
									<!-- 										{{supp.contact_name}} -->
									<!-- 									</h1> -->

									<div class="form-group m-b-20">
										<label>Categories <span class="text-danger">*</span></label> <select
											class="form-control select2" name="category"
											id="selectcategory" ng-model="pro_category"
											aria-label="ngSelected demo">



											<!-- TODO: Auto selet after load page -->

											<optgroup name="" id="">
												<option value="">---Please select---</option>
											</optgroup> -->




											<optgroup ng-repeat="main in Categories"
												ng-cloak label="{{main.category_name}}">

												<option ng-repeat="s in main.subCategories"
													ng-cloak value="{{s.category_id}}">{{s.category_name}}</option>


											</optgroup>


										</select>
									</div>


									<div class="form-group m-b-20">
										<label for="brand">Brand <span class="text-danger">*</span></label>
										<select class="form-control select2" name="brand"
											id="selectbrand" ng-model="pro_brand"
											aria-label="ngSelected demo">

											<!-- TODO: Auto select after load page -->

											<optgroup name="singleSelect" id="singleSelect"
												ng-model="data.singleSelect">
												<option value="">---Please select---</option>
											</optgroup>
											<!-- -------------------------------- -->
											
											<optgroup>
												<!-- <option ng-repeat="brands in Brands" value="brand.brand_id">{{brand.brand_name}}</option> -->
												<option ng-repeat="brands in Brands"
													ng-cloak value="{{brands.brand_id}}">{{brands.brand_name}}</option>
											</optgroup>

										</select>
									</div>



									<div class="form-group m-b-20">
										<label for="qty">Quantity<span class="text-danger">*</span></label>
										<input type="number" class="form-control" name="qty" id="qty"
											ng-model="pro_quantity">
									</div>

									<div class="form-group m-b-20">
										<label class="m-b-15" for="prostatus">Status <span
											class="text-danger">*</span></label> <br />
										<div class="radio radio-inline">
											<input type="radio" id="status_active" value="active"
												name="prostatus" ng-model="pro_status" checked=""> <label
												for="status_active"> active </label>
										</div>
										<div class="radio radio-inline">
											<input type="radio" id="status_inactive" value="inactive"
												name="prostatus" ng-model="pro_status"> <label
												for="status_inactive"> inactive </label>
										</div>
									</div>
								</div>
								<!-- End card-box -->
							</div>
							<!-- End col-lg-6 -->
							<div class="col-lg-6">
								<div class="card-box">
									<h5 class="text-muted text-uppercase m-t-0 m-b-20">
										<b>Add Product Images</b>
									</h5>
									<section>
									<div class="form-group clearfix">
										<!-- upload image -->
										<div class="col-lg-12">

											<div class="table-box m-b-30">
												<div class="table-detail">
													<!-- Preview Image -->

													<div
														style="margin-left: 119px; text-align: center; padding: 0;"
														alt="Image here" class="preview-area" id="preview_area"></div>

													<!--  <div class="table-detail">
                                  <div class="radio radio-inline">
                                    <input type="radio" id="thumbnail" value="thumbnail" name="img">
                                    <label for="thumbnail"> Thumbnail </label>
                                  </div>
                                  <div class="radio radio-inline">
                                    <input type="radio" id="gallary" value="gallary" name="img" checked="">
                                    <label for="gallary"> Gallary </label>
                                  </div>
                                </div> -->

													<!--  <div class="table-detail table-actions-bar" style="min-width: 60px;"> -->
													<!-- <a href="#" class="table-action-btn"><i class="md md-edit"></i></a>
                                  <a href="#" class="table-action-btn"><i class="md md-close"></i></a> -->
												</div>
											</div>


											<div class="text-center m-t-30" style="margin-left: 75px;" my-filter>
       												<input type="file" name="files[]" id="gallery" multiple="multiple">
<!-- 												<input -->
<!-- 													class=" btn btn-purple btn-md waves-effect waves-light" -->
<!-- 													type="file" name="image" id="image-input" multiple /><br/><br/> -->
<!-- 												<button class="btn  btn-default waves-effect waves-light" id="Reset" onclick="resetImage()"> -->
<!-- 													Cancel  -->
<!-- 												</button> -->
											
												

											</div>

										</div>
									</div>
									</section>
								</div>
							</div>
						</div>
						<!-- End row -->
					</form>
					<!-- End form -->
				</div>
				<!-- End col-sm-12 -->
			</div>
			<!-- End row -->

			<div class="row">
				<div class="col-sm-12">
					<div class="text-center p-20">
						<button type="reset" class="btn w-sm btn-white waves-effect" onclick="resetForm()">Reset</button>
						<button type="button"
							class="btn w-sm btn-default waves-effect waves-light"
							ng-click="addProduct($event)" id="save_button">Save</button>
							

					</div>
				</div>
			</div>

		</div>
		<!-- End container -->
	</div>
	<!-- End content -->
</div>
<!-- End content-page -->




<script
	src="${pageContext.request.contextPath}/resources/static/js/jQuery-2.1.4.min.js"></script>



<!-- footer -->
<jsp:include page="footer.jsp"></jsp:include>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/addproduct.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/uploadEdit/fancybox/source/jquery.fancybox.js?v=2.1.5"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/uploadEdit/fancybox/source/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/uploadEdit/js/jquery.filer.js?v=1.0.5"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/uploadEdit/js/custom.js?v=1.0.5"></script> 
        
        
<!-- //===========library      -->
   	<script type="text/javascript">
		
	 $(".filer-fancybox").fancybox({
        padding: 0,

        openEffect : 'elastic',
        openSpeed  : 150,

        closeEffect : 'elastic',
        closeSpeed  : 150,

        closeClick : true,

        helpers : {
            overlay : null
        }
    });
	 
	 function resetForm(){
	
		$("#myform")[0].reset();
		 
	 }
    </script>

<!-- <script type="text/javascript"> -->

<!-- </script> -->