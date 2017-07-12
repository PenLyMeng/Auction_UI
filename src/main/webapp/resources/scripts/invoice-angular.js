/**
 * 
 */


var app = angular.module('myApp',[]);

app.controller('invoiceCtrl', function($scope, $http){
	
	//TODO:  GET ALL INVOICE DETAILS 
	$scope.findAllInvoiceDetails = function(){		
		$http({
			url : '/rest/invoice',
			method : 'GET'
		}).then(function(response) {
			$scope.invoiceDetail = response.data.DATA;
			
		});
	}
	
	//TODO: FIND INVOICE BY INVOICE ID
	$scope.findInvoiceDetailByInvoiceId = function(id){	
		$scope.invoiceDetail = false;
		$scope.invoice = true;
		$http({
			url : '/rest/invoice/'+ id,
			method : 'GET'
		}).then(function(response) {
			$scope.product_name = response.data.DATA.auction.product.product_name;
			$scope.invoice_id = response.data.DATA.invoice.invoice_id;
			$scope.invoice_date = response.data.DATA.invoice.invoice_date;
			$scope.status = response.data.DATA.invoice.status;
			$scope.auction_id = response.data.DATA.auction.auction_id;
			$scope.buy_price = response.data.DATA.buy_price;
			$scope.qty = response.data.DATA.qty;
		});
	}
	
	
	$scope.findAllInvoiceDetails();
})