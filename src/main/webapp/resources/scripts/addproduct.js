/**
 * GET ALL AUCTIONS
 * GET SUPPLIER AND PRODUCT
 * GET A RECORD AUCTION
 * UPDATE AUCTION
 */



	var app = angular.module('myApp', []);
	app.controller('addImageCtrl', function($rootScope, $scope, $http) {
	
//		======================================get brand======================================
		$rootScope.getBrand=function(){
			var checkPagination = true;
			var currentPage = 1;
	    		//alert("a");
	           $http.get("http://localhost:8080/rest/brand?limit=" + 50 +"&page=" + currentPage)
	          		.then(function(response) {
	          		$rootScope.Brands = response.data.DATA;
					console.log(response.data.DATA);

	  			});
		}

	    $rootScope.getBrand();
	    	
	    	
	    	
//======================================get category======================================
				 $rootScope.getCategory=function(){
			    		
				           $http.get("http://localhost:8080/rest/category/find-main-category")
				          		 .then(function(response) {

				          		$rootScope.Categories = response.data.DATA;
			          		

								console.log(response.data.DATA);

				  			});
				        }
				    	$rootScope.getCategory();
				
				    	
//======================================get Supplier======================================

	 				$rootScope.getSupplier = function(){
						
	 						$http.get("http://localhost:8080/rest/supplier")
	 		          		 .then(function(response) {

	 		          		$scope.Supplier = response.data.DATA;
			          		
							
	 						console.log(response.data.DATA);

	 		  			});
	}
	 				    $rootScope.getSupplier();
		
		
// 	---------------------------------View Images after select images--------------------------------------//
		
			
			
// 		var inputLocalFont = document.getElementById("image-input");
// 		inputLocalFont.addEventListener("change",previewImages,false); //bind the function to the input

// 		function previewImages(){

// 		    var fileList = this.files;
			
// 		    var anyWindow = window.URL || window.webkitURL;

// 		        for(var i = 0; i < fileList.length; i++){
// 		          //get a blob to play with
// 		          var objectUrl = anyWindow.createObjectURL(fileList[i]);
// 		          // for the next line to work, you need something class="preview-area" in your html
// 		          $('.preview-area').append('<img class="thumb-lg" src="' + objectUrl + '" />');
// 		          // get rid of the blob
// 		          window.URL.revokeObjectURL(fileList[i]);
// 		          document.getElementById("preview_area").style.border = "2px solid white";
		          
// 		        }
// 					// 		        alert(this.files[0].size);


// 		}
		


		
//========================================add product funtion=================================
		
		
		
		$rootScope.addProduct=function (e) {
						 e.preventDefault();
			 
				//var Myfile=	$('input[name=image]')[0].files;
				
				if ($scope.pro_name == undefined) {
					
					alert("Pleas Insert Product Name !");
				}else if($scope.pro_description == undefined){
					alert("Pleas Insert Product Description !");
					 window.location.href = 'http://localhost:8080/admin/viewproduct';
				}else if($scope.pro_supplier == undefined){
					alert("Pleas Insert Product Supplier !");
					 window.location.href = 'http://localhost:8080/admin/viewproduct';
				}else if($scope.pro_category  == undefined){
					alert("Pleas Insert Product Category !");
					 window.location.href = 'http://localhost:8080/admin/viewproduct';
				}else if( $scope.pro_quantity == undefined){
					alert("Pleas Insert Product Qty !");
					 window.location.href = 'http://localhost:8080/admin/viewproduct';
				}else if(  $scope.pro_brand == undefined){
					alert("Pleas Insert Product Brand !");
					 window.location.href = 'http://localhost:8080/admin/viewproduct';
				}else if(   $scope.pro_status == undefined){
					alert("Pleas Insert Product Status !");
					 window.location.href = 'http://localhost:8080/admin/viewproduct';
				}

		
//--------************-------upload images-------************---------//
			var frmData = new FormData();
			/* 		var serializeArray = $('form[name=add-product-form]').serializeArray();
			
			 var temp = $('form[name=add-product-form]').serialize();			       		    
			 // Serialize not include Radio & CheckBox & Radio
			 // Add to Serialize Param for generating in Java & add to serializeArray
			 $('input[type=radio]').each(function() {     
			 if ($(this).checked) {
			 temp += '&'+this.name+'='+$(this).val();
			 serializeArray.push(this.name, $(this).val());
			 }
			 });			       			
			
			 $.each(serializeArray, function(i, field){
			 frmData.append(field.name, field.value);
			 }); */
			 
			 
			 
			$scope.tf = "";
			 
			frmData.append('product_name', $scope.pro_name);
			frmData.append('product_description', $scope.pro_description);
			frmData.append('supplier_id', $scope.pro_supplier);
			frmData.append('category_id',  $scope.pro_category);
			frmData.append('qty',  $scope.pro_quantity);
			frmData.append('brand_id',  $scope.pro_brand);
			//alert(frmData.get("supplier_id"));
			if ($scope.pro_status == 'active') {
				$scope.tf= 1;
			}else{
				$scope.tf= 0;
			}
// 			frmData.append('status', ($scope.pro_status == 'active' ?true:!false));
			frmData.append('status', $scope.tf );
// 			alert($scope.tf);
			

			// Gallery File
			//var gallery_files = $('input[name=image]')[0].files;
			//console.log(gallery_files.length);
			for (var i = 0; i < newFiles['gallery'].length; i++) {
				frmData.append("images", newFiles['gallery'][i]);
				//$("#result").src = gallery_files[i];
			}
			
			$http({
				url : 'http://localhost:8080/rest/product',
				method : 'POST',
				data : frmData,
				transformRequest : angular.identity,
				headers : {
					'Content-Type' : undefined
				}
			}).then(function(response) {
				console.log(response.data);
				swal({ 
					title: "Success!",
					text: "Product has been inserted.",
				    type: "success",
				    timer : 1000,
				    showConfirmButton : false
				  }, function(){
				    window.location.href = 'http://localhost:8080/admin/viewproduct';
				});
			}, function(error) {
				console.log(error.data);
				swal({ 
					title: "Unsucees!",
					text: "Product has not been inserted.",
					 type: "warning",
				    timer : 1000,
				    showConfirmButton : false
				  }, function(){
				    window.location.href = 'http://localhost:8080/admin/addproduct';
				});
			});
			}
			/******************/


	});
	
	app.directive('myFilter', [function() {
        return {
            restrict: 'A',       
            link: function(scope, element) {
                // wait for the last item in the ng-repeat then call init
				angular.element(document).ready(function() {
					initJqueryFiler(['#gallery'], [[]]);
                });
            }
        };
        /**** Usable array ****/
        // If your input file, id = '#gallery' use:
        // => newFiles['gallery']
        // => deletedImageIDs['gallery']

}]);
	
	
	