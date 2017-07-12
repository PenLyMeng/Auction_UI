/**
 * angular get, add, delete, update user
 */

var app = angular.module('myApp', []);
app.controller('myCtrl', function($scope,$http,$rootScope){
	$scope.supplierName = "";
	var checkPagination = true;
	var currentPage = 1;
	// select all record to display
	$scope.findAllSuppliers = function(){
		$http({
			url: '/rest/supplier?limit=' + 10 +"&page=" + currentPage + "&supplierName="+$scope.supplierName,
			method: 'GET'
			
		}).then(function(response){
			$scope.supplier = response.data.DATA;
			
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
		$scope.findAllSuppliers();
	});
	
	
	// select suplier by id
	$scope.findSupplierById = function(id){
		
		$http({
			url: '/rest/supplier/'+id,
			method: 'GET'
			
		}).then(function(response){
			$scope.contact_name = response.data.DATA.contact_name;
			$scope.phone=response.data.DATA.phone;
			$scope.email = response.data.DATA.email;
			$scope.address = response.data.DATA.address;			
			$scope.supplier_id = response.data.DATA.supplier_id;
			$scope.status = response.data.DATA.status;
		});
	}
	
		
	// add record function
	$scope.addSupplier = function(){
		
		$http({
			url: '/rest/supplier',
			method: 'POST',
			data:{
			  			  
	  			  "address": $scope.address,
	  			  "contact_name": $scope.contact_name,
	  			  "email": $scope.email,
	  			  "phone": $scope.phone,
	  			  "status": $scope.status
	  			  
			}
		}).then(function(response){
			swal({ 
				title: "Success!",
				text: "Supplier has been inserted.",
			    type: "success", 
			    timer : 1000,
			    showConfirmButton : false
			  },
			  function(){
			    window.location.href = '/admin/viewsupplier';
			});
			// clear input fields
			/*$scope.address = "";
			$scope.contact_name = "";
			$scope.email = "";
			$scope.phone = "";*/
			// =======================
		});
	}
	
	// update supplier
	$scope.updateSupplier = function(id){
		
		$http({
			url: '/rest/supplier',
			data: {
				"address": $scope.address,
				"contact_name": $scope.contact_name,
				"email": $scope.email,
				"phone": $scope.phone,
				"status": $scope.status,
				"supplier_id": id
			},
			method: 'PUT'
		}).then(function(response){
			swal({
				title : "Success", 
				text : "Supplier has been updated!", 
				type : "success",
				timer : 1000,
				showConfirmButton : false
			});
			$scope.findAllSuppliers();
		},function(error){});
	}
	
	// delete supplier
	$rootScope.deleteSupplier = function(id){	
		
		swal({
		title: "Are you sure?",
		text: "Your will not be able to recover this supplier!",
		type: "warning",
		showCancelButton: true,
		confirmButtonColor: "#DD6B55",confirmButtonText: "Yes, delete it!",
		cancelButtonText: "No, cancel plx!",
		closeOnConfirm: false,
		closeOnCancel: false }, 
		function(isConfirm){ 
			if (isConfirm) {
				$http({
					url: '/rest/supplier/'+id,
					
					method: 'DELETE'
				}).
				success(function(response){
					$scope.findAllSuppliers();
					});
				swal({
					title : "Deleted!", 
					text : "The supplier has been deleted.", 
					type : "success",
					timer : 1000,
					showConfirmButton : false
				});

				//$scope.findAllSuppliers();
			} else {
				swal({
					title : "Cancelled!", 
					text : "Your supplier is not deleted :)", 
					type : "error",
					timer : 1000,
					showConfirmButton : false
				});
			}
		});				
		
	
	}
	
	
	$scope.loadme = function(){
		alert("me");
	};
	
	
	// load all record
	$scope.findAllSuppliers();
})