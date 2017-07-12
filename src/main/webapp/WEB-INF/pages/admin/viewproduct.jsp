<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<style>
/* 	#browse_gallery { */
/* 			display:none; */
/* 	} */
	
	
/* 	.icon-jfi-trash{ */
/* 		display:none; */
/* 	} */
	
/* 	#u_submit{ */
/* 		margin-left:220px; */
/* 	} */
	
	
</style>

	
<!-- new css -->
	<link href="${pageContext.request.contextPath}/resources/static/uploadEdit/css/jquery.filer.css" type="text/css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/static/uploadEdit/css/themes/jquery.filer-dragdropbox-theme.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/uploadEdit/fancybox/source/jquery.fancybox.css?v=2.1.5">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/static/uploadEdit/fancybox/source/helpers/jquery.fancybox-buttons.css?v=1.0.5">


<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
    <div class="content-page" ng-controller="viewProductCtrl" ng-cloak>
        <!-- Start content -->
        <div class="content">
          <div class="container">
            <!-- Page-Title -->
						<div class="row">
							<div class="col-sm-12">
								<h4 class="page-title">Products</h4>
								<ol class="breadcrumb">
									<li><a href="">iWant Acution</a></li>
                  <li><a href="">Product Management</a></li>
									<li class="active">Products List</li>
								</ol>
							</div>
						</div>

            <!-- SECTION FILTER ================================================== -->
            
            <div class="row">
              <div class="col-lg-12 col-md-12 col-sm-12 ">
                <div class="portfolioFilter">
                  <a href="#" data-filter="*" class="current">All</a>
                  <a href="#" data-filter=".mobiles">Mobiles</a>
                  <a href="#" data-filter=".tablets">Tablets</a>
                  <a href="#" data-filter=".desktops">Desktops</a>
                  <a href="#" data-filter=".other">Other</a>
                </div>
              </div>
            </div>
			
			
			<div class="row">
            	<div class="col-lg-12">
            		<div class="card-box">
            			<div class="row">
                  	<div class="col-sm-8">
                  		<form role="form">
                        <div class="form-group contact-search m-b-30">
                        	<input type="text" id="search" class="form-control" ng-model="str_search" placeholder="Search...">
                            <button type="submit" class="btn btn-white"><i class="fa fa-search"></i></button>
                        </div> <!-- form-group -->
                      </form>
                  	</div>
                  	<div class="col-sm-4">
                  		 <a href="${pageContext.request.contextPath}/admin/addproduct" class="btn btn-default btn-md waves-effect waves-light m-b-30"><i class="md md-add"></i> Add Product</a>
                  	</div>
                  </div>
			                        
            	  <div class="table-responsive">
                    <table class="table table-hover mails m-0 table table-actions-bar">
                      <thead>
							<tr>
								<th style="min-width: 95px;">
									<div class="checkbox checkbox-primary checkbox-single m-r-15">
                              			<input id="action-checkbox" type="checkbox">
                              			<label for="action-checkbox"></label>
                            		</div>
  								</th>
  								<th>Images</th>
  								<th>Product ID</th>
                          		<th>Product Name</th>
                          		<th>Description</th>
  								<th>Supplier</th>
                          		<th>Category</th>  
                          		<th>Quantity</th>   
                          		<th>Brand</th> 
                          		<th>Status</th>                
								<th style="min-width: 90px;">Action</th>
							</tr>
					</thead>
					
                    <tbody>
              			
                        <tr  ng-repeat="pro in products | filter: str_search | orderBy:'-product_id'">
                       
	                          <td>
	                            <div class="checkbox checkbox-primary m-r-15">
	                              <input id="checkbox14" type="checkbox">
	                              <label for="checkbox14"></label>
	                            </div>
	                          </td>
	                          
	                          <td ng-repeat="proimg in pro.gallery" ng-show="$first">
	                         
	                         	 <img ng-cloak src={{proimg.image_path}}   class="thumb-lg" alt="product-img" />
								
							  </td>
											
	                          <td ng-cloak>{{pro.product_id}}</td>
	                          <td ng-cloak>{{pro.product_name}}</td>
	                          <td ng-cloak>{{pro.product_description}}</td>
	                          <td ng-cloak>{{pro.supplier.contact_name}}</td>                                                       
	                          <td ng-cloak>{{pro.category.category_name}}</td>
	                          <td ng-cloak>{{pro.qty}}</td>
	                          <td ng-cloak>{{pro.brand.brand_name}}</td>
	                          <td>
	                          	<span ng-show="pro.status==1">Active</span>
	                          	<span ng-show="pro.status==0">Inactive</span>
	                          	<span ng-show="pro.status==3">Auction</span>
	                          </td>
	                          	
	                          
	                          <td>
		                          	<a href="#" data-toggle="modal" data-target=".enterData" class="table-action-btn" 
		                          		ng-click="getProductByID(pro,pro.gallery)"><i class="md md-edit text-warning"></i></a>
		                          	<a href="#" class="table-action-btn" ng-click="deleteByID(pro)"><i class="md md-delete text-danger"></i></a>
	                          </td>
                        </tr>
                        
                      </tbody>
                    </table>
                    <div class="dataTables_info ng-binding" ng-cloak><b>Total Page&#8227;{{pagination.TOTAL_PAGES}}</b> 
                    											&nbsp;&nbsp;
                    										<b>All Products&#8227;{{pagination.TOTAL_COUNT}}</b></div>
                    <div id="PAGINATION">
                    	
                    </div>
                  </div>
            </div>
           </div> <!-- end col -->   
          </div>
			

          </div> <!-- container -->                    
        </div> <!-- content -->
        
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
				<h4 class="modal-title" id="myModalLabel">Update Product</h4>
			</div>
			<div class="modal-body">
				<form name="myForm">
					<!--  User name -->
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="userName2">Product Name *</label>
						<div class="col-lg-10">
							<input class=" form-control required" id=""
								name="user_name" type="text" ng-model="proname" ng-cloak value={{proname}}>
						</div>
					</div>

					<!--  Status -->
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="phone">Description *</label>
						<div class="col-lg-10">
							<textarea id="phone" name="phone" maxlength="250"
								class="required form-control" ng-model="prodescription" ng-cloak value={{prodescriptiont}}>
							</textarea>
						</div>
					</div>
			
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="fname">Supplier *</label>
						<div class="col-lg-10">
							<select id="lname" name="lname" type="text" class="form-control" ng-model="pro_supplier_to_update">
								<option value="" ng-cloak>{{prosupplier}}</option>
								<option ng-repeat="supplier in Supplier" ng-cloak value="{{supplier.supplier_id}}">{{supplier.contact_name}}</option>
							
					
							</select>
						</div>		
					</div>
					
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="lname">Category *</label>
						<div class="col-lg-10">
							<select id="lname" name="lname" type="text" class="form-control" ng-model="pro_category_to_update">
								<optgroup ng-repeat="categories in Categories" ng-cloak label="{{categories.category_name}}">
									<option value="" ng-cloak>{{thisPro_category_name}}</option>
									<option ng-repeat="sub in categories.subCategories" ng-cloak value="{{sub.category_id}}">{{sub.category_name}}</option>
								</optgroup>
							</select>
								
						</div>	
					</div>
					
					<div class="form-group row">
						<label class="col-lg-2 control-label " for="lname">Quantity *</label>
						<div class="col-lg-10">
						<input id="lname" name="lname" type="text"
								class="form-control" ng-model="proqty" ng-cloak value={{proqty}}>
							
						</div>
					</div>
					
					<div class="form-group row">
						<label class="control-label col-lg-2">Brand *</label>
						<div class="col-lg-10">
							<select id="lname" name="lname" type="text" class="form-control" ng-model="pro_brand_to_update">
								
								
								<option value="" ng-cloak>{{probrand}}</option>
								<option ng-repeat="brand in Brand" ng-cloak value="{{brand.brand_id}}">{{brand.brand_name}}</option>
							
					
							</select>
							<!-- input-group -->
						</div>
					</div>
					
					<div class="form-group row">
						<label class="control-label col-lg-2">Status *</label>
						<div class="col-lg-10">
						
						<!-- <input id="lname" name="lname" type="text"
								class="form-control" ng-model="prostatus" value={{prostatus}}> -->
						<select ng-model="prostatus" class="form-control">
							<option value="1" ng-cloak ng-selected="{{prostatus==1}}">Active</option>
							<option value="0" ng-cloak ng-selected="{{prostatus==0}}">Inactive</option>
							<option value="3" ng-cloak ng-selected="{{prostatus==3}}">Auction</option>
						</select>
						</div>
					</div>
					
		
		
		
		
		
		
		
		
		
		
		
		
					
					  
    <div id="content">
        <span ng-repeat="s in sample" my-filter style="display:none">&nbsp;</span>
        <input type="file" name="files[]" id="gallery" multiple="multiple">
    </div>	
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					<div class="form-group row">
						<label for="" class="col-sm-2 form-control-label"></label>
						<div class="col-sm-10">	
							<button type="button" class="btn btn-success btn-md"
								ng-model="user_id" ng-click="updateProduct($event)"
								id="u_submit" data-dismiss="modal" style="margin-left:220px;">Update</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<!--  end modal  -->
          
 </div>
 




<!-- footer -->
<jsp:include page="footer.jsp"></jsp:include>

<!--jQuery-->
		
	<!-- script to working on this page -->	
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/scripts/viewproduct.js"></script>
	
	<!-- script of library -->	
 	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/uploadEdit/fancybox/source/jquery.fancybox.js?v=2.1.5"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/uploadEdit/fancybox/source/helpers/jquery.fancybox-buttons.js?v=1.0.5"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/uploadEdit/js/jquery.filer.js?v=1.0.5"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/uploadEdit/js/custom.js?v=1.0.5"></script> 
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

	</script>
 
 
        