/**
 * GET ALL AUCTIONS
 * GET SUPPLIER AND PRODUCT
 * GET A RECORD AUCTION
 * UPDATE AUCTION
 */



var app = angular.module('myApp', []);
		app.controller('viewProductCtrl', function($rootScope,$scope, $http) {
			
			
			
//****************get brand
			$rootScope.getBrand=function(){
	    		//alert("a");
	           $http.get("http://localhost:8080/rest/brand")
	          		.then(function(response) {
	          		$rootScope.Brand = response.data.DATA;
					console.log(response.data.DATA);

	  			});
		}

	    	$rootScope.getBrand();
			
			
//****************get category
			$rootScope.getCategory=function(){
	    		
		           $http.get("http://localhost:8080/rest/category/find-main-category")
		          		 .then(function(response) {

		          		$rootScope.Categories = response.data.DATA;
	          		

						console.log(response.data.DATA);

		  			});
		        }
		    	$rootScope.getCategory();
		    	
		    	
		    	
//***********Supplier 
		$rootScope.getSupplier = function(){
					
						$http.get("http://localhost:8080/rest/supplier")
		          		 .then(function(response) {

		          		$scope.Supplier = response.data.DATA;
	          		
					
						console.log(response.data.DATA);

		  			});
}
				    $rootScope.getSupplier();
	    var checkPagination = true;
		var currentPage = 1;

//**********get product
    	$rootScope.getProductsMethod=function(){

           $http.get("http://localhost:8080/rest/product?limit=15&page="+currentPage)
          		.then(function(response) {
          		$rootScope.products = response.data.DATA;
          		$rootScope.pagination= response.data.PAGINATION;
          		/* alert(response.data.DATA.gallery.image_path); */
				console.log(response.data.DATA);
				if(checkPagination){
					$scope.setPagination(response.data.PAGINATION);
					checkPagination=false;
				}
				
  			});
        }
    	$rootScope.getProductsMethod();
		
    	
    	//TODO: CTEATE PAGINATION BUTTON
    	$scope.setPagination = function(pagination){
    		console.log("PAGINATION==>", pagination);
    		$("#PAGINATION").bootpag({
    	        total: pagination.TOTAL_PAGES,
    	        page: pagination.PAGE,
    	        maxVisible: 10,
    	        leaps: true,
    	        firstLastUse: true,
    	        first: 'First',
    	        last: 'Last',
    	        wrapClass: 'pagination',
    	        activeClass: 'active',
    	        disabledClass: 'disabled',
    	        nextClass: 'next',
    	        prevClass: 'prev',
    	        lastClass: 'last',
    	        firstClass: 'first'
    	    }); 
    		$("#PAGINATION ul").addClass("pagination");
    	}
    	$('#PAGINATION').bootpag().on("page", function(event, page){
    		checkPagination = false;
    		currentPage = page;
    		$scope.getProductsMethod();
    	});
    	
    	
    	
    	$scope.getProductByID = function(proObject,progallery){
    		
    		
    		$scope.sample = [];
    		var image = {};
    		$.each(progallery, function(index, item){
    			var image = {
    				id   : item.image_id,
	    			name : item.image_path,
	    			type : 'image/jpg',
	    			size :  '',
	    			file : item.image_path,
    			};
    			$scope.sample.push(image);
    		}); 
    		
    		console.log($scope.sample);
    		
    	
    		
    		
    		///*****declare a product object*****
    		$scope.productObj = proObject;
    		
    	
    		$scope.thisPro_category_id = $scope.productObj.category.category_id
    		$scope.proid = proObject.product_id;
    		$scope.proname = proObject.product_name;
    		$scope.prodescription = proObject.product_description;
    		$scope.prosupplier= proObject.supplier.contact_name;
    		$scope.thisPro_category_name = proObject.category.category_name;
    		$scope.proqty = proObject.qty;
    		$scope.probrand = proObject.brand.brand_name;
    		$scope.prostatus = proObject.status;

    		
    	}
    	
    	
 //**************Update Product
    	$rootScope.updateProduct = function(e){
  			e.preventDefault();
    		
    		if ($scope.pro_category_to_update == undefined) {
				//alert("category no update");
				$scope.pro_category_to_update = $scope.productObj.category.category_id;
				//alert($scope.pro_category_to_update);
						
			}
    		
    		if($scope.pro_brand_to_update == undefined){
			
				$scope.pro_brand_to_update = $scope.productObj.brand.brand_id;
			
			}
    		
    		if($scope.pro_supplier_to_update == undefined){
				$scope.pro_supplier_to_update = $scope.productObj.supplier.supplier_id;
				
			}
    		
    		if($scope.pro_status_to_update == undefined){
				$scope.pro_status_to_update = $scope.productObj.status;
				
			}
    	


// ==== ==== === == => append Array to frmdata
		
			var frmData = new FormData();
			
 			for (var i = 0; i < newFiles['gallery'].length; i++) {
				frmData.append("imageAdd", newFiles['gallery'][i]);
			}

			var data = {
					"product_id":$scope.proid,
					"product_name": $scope.proname,
			  		"product_description": $scope.prodescription,
				  	"supplier_id": $scope.pro_supplier_to_update,
				  	"category_id": $scope.pro_category_to_update,	  
				  	"qty": $scope.proqty,
				  	"brand_id":$scope.pro_brand_to_update,
// 				  	"status": ($scope.prostatus) ? 1:0	
					"status":$scope.prostatus
			};

			frmData.append("json_string", JSON.stringify(data));
 			frmData.append("imageDelete", deletedImageIDs['gallery']);

    		$http({   			
				url : 'http://localhost:8080/rest/product/updateproduct',
				method : 'POST',
				data : frmData,			
				transformRequest : angular.identity,
				headers : {
					'Content-Type' : undefined
				}
			}).then(function(response) {
				console.log(response.data)
				
				swal({ 
					title: "Success!",
					text: "Product has been updated.",
				    type: "success",
				    timer : 1000,
				    showConfirmButton : false
				  }, function(){
				    window.location.href = 'http://localhost:8080/admin/viewproduct';
				});
			
			}, function(error) {
				console.log(error.data);
				alert('failed to update !!');
				//window.location.href = 'http://localhost:8080/admin/viewproduct';
				
			});
    }
	
    	
    	
  //*******************delete method
  
    	$scope.deleteByID = function(proObj){
    			
    			swal({
    			title: "Are you sure?",
    			text: "Your will not be able to recover this product!",
    			type: "warning",
    			showCancelButton: true,
    			confirmButtonColor: "#DD6B55",confirmButtonText: "Yes, delete it!",
    			cancelButtonText: "No, cancel plx!",
    			closeOnConfirm: false,
    			closeOnCancel: false }, 
    			function(isConfirm){ 
    				if (isConfirm) {
    					$http({
    						url: 'http://localhost:8080/rest/product/delete-product/'+proObj.product_id,
    						method: 'DELETE'
    					}).
    					success(function(response){
    						console.log(response.data)
    						window.location.href = 'http://localhost:8080/admin/viewproduct';
    						});
    					swal({
    						title : "Deleted!", 
    						text : "The user has been deleted.", 
    						type : "success",
    						timer : 1000,
    						showConfirmButton : false
    					});

    				
    				} else {
    					swal({
    						title : "Cancelled!", 
    						text : "Your user is not deleted :)", 
    						type : "error",
    						timer : 1000,
    						showConfirmButton : false
    					});
    				}
    			});					
    		}
	});
		
	
	
// costomize the library of images	
	app.directive('myFilter', [function() {
	          return {
	              restrict: 'A',       
	              link: function(scope, element) {
	                  // wait for the last item in the ng-repeat then call init
	                  if(scope.$last) {
	                  	// Remove
	                  //	document.getelementById('browse_gallery').css();
	                 
	                  	$('div.jFiler.jFiler-theme-dragdropbox').remove();
	              		$('#content > span:last-child').after('<input type="file" name="files[]" id="gallery" multiple="multiple">');
	                    initJqueryFiler(['#gallery'], [scope.sample]);
	                  }
	              }
	          };
	  	/**** Usable array ****/
         // => validatedFiles = Array of File
         // => deletedImageName = Array of Old Image Name
	
     }]);

//===========library 
	