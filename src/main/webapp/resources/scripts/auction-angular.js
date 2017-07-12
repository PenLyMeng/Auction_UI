/**
 * GET ALL AUCTIONS GET SUPPLIER AND PRODUCT GET A RECORD AUCTION UPDATE AUCTION
 */

var app = angular.module('myApp', []);
app
		.controller(
				'auctionCtrl',
				function($scope, $http, $rootScope) {
					$scope.currentDate = new Date();
					$scope.created_date = new Date();
					$scope.created_by = 'admin';
					$scope.productName = "";

					var checkPagination = true;
					var currentPage = 1;

					// TODO: select all record to display
					$scope.findAllAuctions = function() {
						
						$http(
								{
									url : '/rest/auction?limit=' + 10 + "&page="
											+ currentPage + "&productName="
											+ $scope.productName,
									method : 'GET'
								})
								.then(
										function(response) {
											$scope.auction = response.data.DATA;
											$scope.pages = response.data.PAGINATION.PAGE;
											$scope.totalpages = response.data.PAGINATION.TOTAL_PAGES;
											$scope.totalcount = response.data.PAGINATION.TOTAL_COUNT;
											if (checkPagination) {
												$scope
														.setPagination(response.data.PAGINATION);
												checkPagination = false;
											}
											
										});
					}

					// TODO: TO LIST ALL SUPPLIER FOR CHOOSE TO ADD
					$scope.findSupplersInProducts = function() {
						$http({
							url : '/rest/supplier/supplier-in-product',
							method : 'GET'
						}).then(function(response) {
							$scope.supplier = response.data.DATA;

						});
					}

					// TODO: TO LIST ALL PRODUCTS FOR CHOOSE TO ADD
					$scope.findProductsHasSupplier = function(id) {
						$http({
							url : '/rest/product/product-of-supplier/' + id,
							method : 'GET'
						}).then(function(response) {
							$scope.product = response.data.DATA;
						});
					}

					// TODO: SEARCH BY PRODUCT NAME
					$scope.searchProName = function(proName) {
						$http(
								{
									url : '/rest/auction?limit=' + 5 + "&page="
											+ currentPage + "&productName="
											+ proName,
									method : 'GET'
								}).then(function(response) {
							$scope.auction = response.data.DATA;
							if (checkPagination) {
								$scope.setPagination(response.data.PAGINATION);
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

					$('#PAGINATION').bootpag().on("page",
							function(event, page) {
								checkPagination = false;
								currentPage = page;
								$scope.findAllAuctions();
							});
					

					// TODO: get one record function
					$scope.getAuctionById = function(id) {
					
						//$rootScope.rootID = id;
						
						$http({
							url : '/rest/auction/' + id,
							method : 'GET'
						}).then(function(response) {
							console.log(response.data.DATA);
							$scope.sup = response.data.DATA.product.supplier.supplier_id;
								
							$scope.findProductsHasSupplier($scope.sup);
							$scope.pro = response.data.DATA.product.product_id;
							
							$scope.product_name = response.data.DATA.product.product_name;
							
							$scope.product_condition = response.data.DATA.product_condition;
							$scope.start_price = response.data.DATA.start_price;
							$scope.increment_price = response.data.DATA.increment_price;
							$scope.buy_price = response.data.DATA.buy_price;
							$scope.start_date = moment(response.data.DATA.start_date).format("DD-MM-YYYY HH:mm:ss");
							$scope.end_date = moment(response.data.DATA.end_date).format("DD-MM-YYYY HH:mm:ss");
							$scope.status = response.data.DATA.status;
							$scope.comment = response.data.DATA.comment;
							
							
							
						});
					}
					
					
					
					// TODO: UPDATE FUNCTION
					$scope.updateAuction = function() {
						
						$http(
							{
								url : '/rest/auction',
								method : 'PUT',
								data : {
									"auction_id" : $rootScope.rootID,
									"buy_price" : $scope.buy_price,
									"comment" : $scope.comment,
									"created_by" : $scope.created_by,
									"created_date" : $scope.created_date,
									"current_price" : $scope.start_price,
									"end_date" : $("#endDate").val(),
									"increment_price" : $scope.increment_price,
									"product_condition" : $scope.product_condition,
									"product_id" : $scope.pro,
									"start_date" : $("#startDate").val(),
									"start_price" : $scope.start_price,
									"status" : $(
											"input:radio[name=status]:checked")
											.val()
								}
							}).then(function(response) {
							swal({
								title : "Success!",
								text : "Auction has been updated.",
								type : "success",
								timer : 1000,
								showConfirmButton : false
							}, function() {
								window.location.href = '/admin/viewauction';
							});
						});
					}

					// DELETE AUCTION FUNCTION
					$scope.deleteAuction = function(auction_id) {

						swal(
								{
									title : "Are you sure?",
									text : "Your will not be able to recover this auction!",
									type : "warning",
									showCancelButton : true,
									confirmButtonColor : "#DD6B55",
									confirmButtonText : "Yes, delete it!",
									cancelButtonText : "No, cancel plx!",
									closeOnConfirm : false,
									closeOnCancel : false
								},
								function(isConfirm) {
									if (isConfirm) {
										$http(
												{
													url : '/rest/auction/'
															+ auction_id,

													method : 'DELETE'
												}).success(function(response) {
											$scope.findAllAuctions();
										});
										swal({
											title : "Deleted!",
											text : "The auction has been deleted.",
											type : "success",
											timer : 1000,
											showConfirmButton : false

										});

										// $scope.findAllAuctions();
									} else {
										swal({
											title : "Cancelled",
											text : "Your auction is not deleted!",
											type : "error",
											timer : 1000,
											showConfirmButton : false

										});
									}
								});

					}

					// $scope.alertme = function(){
					// alert("Me");
					// }

					// $scope.$watch('status', function(x){
					// alert(x);
					// });

					// load all record
					$scope.findAllAuctions();
					$scope.findSupplersInProducts();
					
					
					// Check start_date and end_date
					// end_date must be greater than start_date
					$scope.checkErr = function() {

						var curDate = new Date();

						date1 = ($('#startDate').val()).split(':');
						date2 = date1[0].split(' ');
						date3 = date2[0].split('-');
						startDate = new Date(parseInt(date3[2]), parseInt(date3[1]) - 1,
								parseInt(date3[0]), parseInt(date2[1]), parseInt(date1[1]),
								parseInt(date1[2]));

						date1 = ($('#endDate').val()).split(':');
						date2 = date1[0].split(' ');
						date3 = date2[0].split('-');
						endDate = new Date(parseInt(date3[2]), parseInt(date3[1]) - 1,
								parseInt(date3[0]), parseInt(date2[1]), parseInt(date1[1]),
								parseInt(date1[2]));

						if (startDate > endDate) {
							alert("End date must be greater than start date!");
							
						}
						
					};

					
					
					
				})

// TODO: FOR ADD AUCTION
app.controller('addAucCtrl', function($scope, $http, $rootScope) {
	$scope.currentDate = new Date();
	$scope.created_date = new Date();
	$scope.created_by = 'admin';

	// TODO: TO LIST ALL SUPPLIER FOR CHOOSE TO ADD
	$scope.findSupplersInProducts = function() {

		$http({
			url : '/rest/supplier/supplier-in-product',
			method : 'GET'
		}).then(function(response) {
			$scope.supplier = response.data.DATA;

		});
	}

	// TODO: TO LIST ALL PRODUCTS FOR CHOOSE TO ADD
	$scope.findProductsHasSupplier = function(id) {
		$http({
			url : '/rest/product/product-of-supplier/' + id,
			method : 'GET'
		}).then(function(response) {
			$scope.product = response.data.DATA;
		});
	}
	
	
	// TODO: TO LIST ALL PRODUCTS FOR CHOOSE TO ADD -- EAN SOKCHOMRERN (01/09/2016)
	$scope.findProductsHasSupplierForUpdate = function(id) {
		$http({
			url : '/rest/product/product-of-supplier-for-update/' + id,
			method : 'GET'
		}).then(function(response) {
			$scope.product = response.data.DATA;
		});
	}
	

	// TODO: add record function
	$scope.addAuction = function() {
		/*
		 * alert($("#startDate").val()); alert($("#endDate").val());
		 */
		$http({
			url : '/rest/auction',
			method : 'POST',
			data : {
				"buy_price" : $scope.buy_price,
				"comment" : $scope.comment,
				"created_by" : $scope.created_by,
				"created_date" : $scope.created_date,
				"current_price" : $scope.start_price,
				"end_date" : $("#endDate").val(),
				"increment_price" : $scope.increment_price,
				"product_condition" : $scope.product_condition,
				"product_id" : $scope.product_id,
				"start_date" : $("#startDate").val(),
				"start_price" : $scope.start_price,
				"status" : $("input:radio[name=status]:checked").val()
			}
		}).then(function(response) {

			swal({
				title : "Success!",
				text : "Auction has been inserted.",
				type : "success",
				timer : 1000,
				showConfirmButton : false
			}, function() {
				window.location.href = '/admin/viewauction';
			});
		});
	}

	// function test(){
	// var today = new Date();
	// var start = moment("2016-08-20");
	// var end = moment(today);
	// alert(start.diff(end, "days"));
	// }

	// load all record
	$scope.findSupplersInProducts();

	// test();

	// Check start_date and end_date
	// end_date must be greater than start_date
	$scope.checkErr = function() {

		var curDate = new Date();

		date1 = ($('#startDate').val()).split(':');
		date2 = date1[0].split(' ');
		date3 = date2[0].split('-');
		startDate = new Date(parseInt(date3[2]), parseInt(date3[1]) - 1,
				parseInt(date3[0]), parseInt(date2[1]), parseInt(date1[1]),
				parseInt(date1[2]));

		date1 = ($('#endDate').val()).split(':');
		date2 = date1[0].split(' ');
		date3 = date2[0].split('-');
		endDate = new Date(parseInt(date3[2]), parseInt(date3[1]) - 1,
				parseInt(date3[0]), parseInt(date2[1]), parseInt(date1[1]),
				parseInt(date1[2]));

		if (startDate > endDate) {
			alert("End date must be greater than start date!");
			
		}
		
	};
});

