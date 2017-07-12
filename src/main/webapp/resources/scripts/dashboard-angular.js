/**
 * 
 */


var app = angular.module('myApp', []);
app.controller('dashboard', function($rootScope, $scope, $http) {
	$scope.bid_date = moment(new Date()).format("YYYY-MM-DD");
//	$scope.bid_date = "2016-08-31";
	$scope.findBidHistoryByDate = function(bid_date){
		$http({
			url : '/rest/dashboard/' + bid_date,
			method : 'GET'
		}).then(function(response){
			$scope.recentBid = response.data.DATA;
			console.log($scope.recentBid);
		})
     }
	$scope.findBidHistoryByDate($scope.bid_date);
	
	
	// ==== Today's Auction Transactions ==== EAN SOKCHOMRERN === 06/10/2016
	$scope.findAllTodayBid = function(){
		$http({
			url : '/rest/dashboard/find-all-today-bid',
			method : 'GET'
		}).then(function(response){
			$('#allTodayBid').text(response.data.DATA);
			
		})
     }
	$scope.findAllTodayBid();
	
	//---
	$scope.findAllTodayBiddenProducts = function(){
		$http({
			url : '/rest/dashboard/find-all-today-bidden-products',
			method : 'GET'
		}).then(function(response){
			$('#allTodayBiddenProducts').text(response.data.DATA);
		})
     }
	$scope.findAllTodayBiddenProducts();
	
	//---
	$scope.findAllTodayBidders = function(){
		$http({
			url : '/rest/dashboard/find-all-today-bidders',
			method : 'GET'
		}).then(function(response){
			$('#allTodayBidders').text(response.data.DATA);
		})
     }
	$scope.findAllTodayBidders();
	
	//---
	$scope.findAllTodayNewProducts = function(){
		$http({
			url : '/rest/dashboard/find-all-today-new-products',
			method : 'GET'
		}).then(function(response){
			$('#allTodayNewProducts').text(response.data.DATA);
		})
     }
	$scope.findAllTodayNewProducts();
	
	//---
	$scope.findTodayTotalRevenue = function(){
		$http({
			url : '/rest/dashboard/find-today-total-revenue',
			method : 'GET'
		}).then(function(response){
			$('#todayTotalRevenue').text('$ '+response.data.DATA/4000.0);
		})
     }
	$scope.findTodayTotalRevenue();
	
	// FIND HIGH BIDDING. EAN SOKCHOMRERN. 06/10/2016
	$scope.findHighBidding = function(){
		$http({
			url : '/rest/dashboard/find-high-bidding',
			method : 'GET'
		}).then(function(response){
			$scope.highBidding = response.data.DATA;
			
			console.log($scope.highBidding);
		})
     }
	$scope.findHighBidding();
	
})
