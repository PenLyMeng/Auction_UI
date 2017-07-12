/**
 * 
 */

var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope,$http,$rootScope){
	$scope.categoryName = "";
	var checkPagination = true;
	var currentPage = 1;
	// Get All Category
	$scope.findAllCategories = function(){
		$http({
			url: '/rest/category?limit=' + 10 +"&page=" + currentPage + "&categoryName="+$scope.categoryName,
			method: 'GET',
			
		}).then(function(response){
			$scope.category = response.data.DATA;
			
			$scope.pages = response.data.PAGINATION.PAGE;
			$scope.totalpages = response.data.PAGINATION.TOTAL_PAGES;
			$scope.totalcount = response.data.PAGINATION.TOTAL_COUNT;
			if (checkPagination) {
				$scope.setPagination(response.data.PAGINATION);
				checkPagination = false;
			}
		});
	}

	// TODO: CTEATE PAGINATION BUTTON
	$scope.setPagination = function(pagination) {
		console.log("PAGINATION==>", pagination);
		$("#PAGINATION").bootpag({
			total : pagination.TOTAL_PAGES,
			page : pagination.PAGE,
			maxVisible : 10,
			leaps : true,
			firstLastUse : true,
			first : 'First',
			last : 'Last',
			wrapClass : 'pagination',
			activeClass : 'active',
			disabledClass : 'disabled',
			nextClass : 'next',
			prevClass : 'prev',
			lastClass : 'last',
			firstClass : 'first'
		});
		$("#PAGINATION ul").addClass("pagination");
	}

	$('#PAGINATION').bootpag().on("page", function(event, page) {
		checkPagination = false;
		currentPage = page;
		$scope.findAllCategories();
	});
	
	//Select Main Category
	$scope.findMainCategories = function(){
		$http({
			url: '/rest/category/find-main-category',
			method: 'GET',
			
		}).then(function(response){
			$scope.maincategory = response.data.DATA;
		});
	}
	
	//AddCategory
	$scope.addCategory = function(){
		
		$http({
			url: '/rest/category',
			method: 'POST',
			data:{
			  			  
				"category_description": $scope.category_description,
				"category_name":$scope.category_name,
				"parent_id": $scope.parent_id,
				"status": $scope.status
	  			  
			}
		}).then(function(response){
			swal({ 
				title: "Success!",
				text: "Category has been inserted.",
			    type: "success",
			    timer : 1000,
			    showConfirmButton : false
			  },
			  function(){
			    window.location.href = '/admin/viewcategory';
			});
		});
	}
	
	//Delete Category
	$scope.deleteCategory = function(category_id){
		swal({
			title: "Are you sure?",
			text: "Your will not be able to recover this category!",
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",confirmButtonText: "Yes, delete it!",
			cancelButtonText: "No, cancel plx!",
			closeOnConfirm: false,
			closeOnCancel: false }, 
			function(isConfirm){ 
				if (isConfirm) {
					$http({
						url: '/rest/category/'+ category_id,
						
						method: 'DELETE'
					}).
					success(function(response){
							$scope.findAllCategories();
						});
					swal({  
						title: "Deleted!",
						text : "The category has been deleted.",
						type: "success",
						timer : 1000,
						showConfirmButton : false
					});
				
				} else {
					swal({
						title: "Cancelled!",
						text : "Your category is not deleted :)",
						type: "error",
						timer : 1000,
						showConfirmButton : false					
					});					
				}
			});	
	}

	
	//Get Category By ID	

	$scope.getCategoryByID = function(categoryObject){
		$scope.mainCategories = angular.copy($scope.maincategory);
		$scope.category_description = categoryObject.category_description;
		$scope.category_id = categoryObject.category_id;
		$scope.category_name = categoryObject.category_name;
		if(categoryObject.status==true){
			$( "#catestatus1" ).prop( "checked", true);
		}
		else{
			$( "#catestatus2" ).prop( "checked", true);
		}
		
		// match parent_id with "type of"
		$scope.mainCat = categoryObject.parent_id;		
		
		// pass parent_id to store in update button
		$scope.parent_id = categoryObject.parent_id;
		
		
	}
	
	//Update category
	$scope.updateCategory = function(id){
		
		$http({
			url: '/rest/category',
			method: 'PUT',
			data:{
				 "category_description": $scope.category_description,
				  "category_id": id,
				  "category_name": $scope.category_name,
				  "parent_id": $scope.mainCat,
				  "status": $scope.status
	  			  
			}
		}).then(function(response){
			swal({
				title : "Success", 
				text : "Category has been updated!", 
				type : "success",
				timer : 1000,
				showConfirmButton : false
			});
			$scope.findAllCategories();
		},function(error){});
	}
	
	//===================================================	
	//Add Brand
	$scope.addBrand = function(){
		//alert($scope.brand_status);
		$http({
			url: '/rest/brand',
			method: 'POST',
			data:{
				  "brand_description": $scope.brand_description,
				  "brand_name": $scope.brand_name,
				  "status": $scope.brand_status
	  			  
			}
		}).then(function(response){
			swal({ 
				title: "Success!",
				text: "Brand has been inserted.",
			    type: "success",
			    timer : 1000,
				showConfirmButton : false
			  },
			  function(){
			    window.location.href = '/admin/viewbrand';
			});
		});
	}

	// load all record
	$scope.findAllCategories();
	$scope.findMainCategories();
})


//TODO: SHOW AUCTON TO VIEW CLIENTS
app.controller('auctionCtrl', function($scope, $http, $rootScope) {
	$scope.productName = "";
	$scope.currentPage = 1;
	//TODO: select all record to display
	$scope.findAllAuctions = function() {
		$http({
			url : '/rest/auction?limit=' + 8 +"&page=" + $scope.currentPage + "&productName="+$scope.productName,
			method : 'GET'
		}).then(function(response) {
			$scope.auction = response.data.DATA;
		});
	}
	
	// TODO: get one record function
	$scope.getAuctionById = function(id){
		$rootScope.rootID = id;
//		alert($scope.product_name);
		$http({
			url: '/rest/auction/'+id,
			method: 'GET'
		}).then(function(response){
			$scope.category_name = response.data.DATA.product.category.category_name;
			
//			$scope.findProductsHasSupplier($scope.sup);
			$scope.pro = response.data.DATA.product.product_id;
			$scope.product_name = response.data.DATA.product.product_name;
			$scope.product_condition = response.data.DATA.product_condition;
			$scope.start_price = response.data.DATA.start_price;
			$scope.increment_price = response.data.DATA.increment_price;
			$scope.buy_price = response.data.DATA.buy_price;
			$scope.start_date = moment(response.data.DATA.start_date).format("MM/DD/YYYY");
			$scope.end_date = moment(response.data.DATA.end_date).format("MM/DD/YYYY");
			$scope.status = response.data.DATA.status;
			$scope.comment = response.data.DATA.comment;			
		});
	}

	// load all record
	$scope.findAllAuctions();
//	$scope.dayDiff();
})

//TODO: VIEW ALL BRAND NAME OF PRODUCTS
app.controller('viewBrandCtrl', function($scope,$http,$rootScope){
	$scope.brandName = "";
	var checkPagination = true;
	var currentPage = 1;
	//Get Brand
	$scope.findAllBrands = function(){
		$http({
			url: '/rest/brand?limit=' + 10 +"&page=" + currentPage + "&brandName="+$scope.brandName,
			method: 'GET',
			
		}).then(function(response){
			$scope.brand = response.data.DATA;
			
			$scope.pages = response.data.PAGINATION.PAGE;
			$scope.totalpages = response.data.PAGINATION.TOTAL_PAGES;
			$scope.totalcount = response.data.PAGINATION.TOTAL_COUNT;
			if (checkPagination) {
				$scope.setPagination(response.data.PAGINATION);
				checkPagination = false;
			}
		});
	}
	
	// TODO: CTEATE PAGINATION BUTTON
	$scope.setPagination = function(pagination) {
		console.log("PAGINATION==>", pagination);
		$("#PAGINATION").bootpag({
			total : pagination.TOTAL_PAGES,
			page : pagination.PAGE,
			maxVisible : 10,
			leaps : true,
			firstLastUse : true,
			first : 'First',
			last : 'Last',
			wrapClass : 'pagination',
			activeClass : 'active',
			disabledClass : 'disabled',
			nextClass : 'next',
			prevClass : 'prev',
			lastClass : 'last',
			firstClass : 'first'
		});
		$("#PAGINATION ul").addClass("pagination");
	}

	$('#PAGINATION').bootpag().on("page", function(event, page) {
		checkPagination = false;
		currentPage = page;
		$scope.findAllBrands();
	});
	
	//Delete Category
	$scope.deleteBrand = function(brand_id){
		
		swal({
			title: "Are you sure?",
			text: "Your will not be able to recover this brand!",
			type: "warning",
			showCancelButton: true,
			confirmButtonColor: "#DD6B55",confirmButtonText: "Yes, delete it!",
			cancelButtonText: "No, cancel plx!",
			closeOnConfirm: false,
			closeOnCancel: false }, 
			function(isConfirm){ 
				if (isConfirm) {
					$http({
						url: '/rest/brand/'+ brand_id,
						
						method: 'DELETE'
					}).
					success(function(response){
							$scope.findAllBrands();
						});
					swal({
						title: "Deleted!",
						text: "The brand has been deleted.",
					    type: "success" ,
					    timer : 1000,
						showConfirmButton : false					
					});
				} else {
					swal({
						title: "Cancelled!",
						text: "Your brand is not deleted :)",
					    type: "error" ,
					    timer : 1000,
						showConfirmButton : false					
					});
				}
			});	
	}
	
	// Get brand by id
	$scope.getBrandById = function(brandObject){
		$scope.brand_name = brandObject.brand_name;
		$scope.brand_description = brandObject.brand_description;
		
		$scope.brand_id = brandObject.brand_id;
		
		if( brandObject.status==true){
			$("#brand_status1" ).prop( "checked", true);
		}
		else{
			$("#brand_status2" ).prop( "checked", true);
		}		
	}
	
	//Update Brand
	$scope.updateBrand = function(id){
		
		$http({
			url: '/rest/brand',
			method: 'PUT',
			data:{
				 "brand_description": $scope.brand_description,
				 "brand_id": $scope.brand_id,
				 "brand_name": $scope.brand_name,
				 "status": $scope.status
	  			  
			}
		}).then(function(response){
			swal({
				title : "Success", 
				text : "Brand has been updated!", 
				type : "success",
				timer : 1000,
				showConfirmButton : false
			});
			$scope.findAllBrands();
		},function(error){});
	}
	$scope.findAllBrands();
})