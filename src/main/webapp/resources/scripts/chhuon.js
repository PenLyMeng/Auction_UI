/**
 * 
 */

var app = angular.module('myApp', ['angular.filter']);

app.controller('categoryCtrl', function($scope,$http,$rootScope){
	
	// Get All Category
	$scope.findAllCategories = function(){
		$http({
			url: 'http://localhost:8080/rest/category',
			method: 'GET',
			
		}).then(function(respone){
			$scope.category = respone.data.DATA;
		});
	}
	
	//Select Main Category
	$scope.findMainCategories = function(){
		$http({
			url: 'http://localhost:8080/rest/category/find-main-category',
			method: 'GET',
			
		}).then(function(respone){
			$scope.maincategory = respone.data.DATA;
			
		});
	}
	
	//Get Brand
	$scope.findAllBrands = function(){
		$http({
			url: 'http://localhost:8080/rest/brand',
			method: 'GET',
			
		}).then(function(respone){
			$scope.brand = respone.data.DATA;
		});
	}
	

	// load all record
	$scope.findAllCategories();
	$scope.findMainCategories();
	$scope.findAllBrands();
})


//TODO: SHOW AUCTON TO VIEW CLIENTS
app.controller('auctionCtrl', ['$scope', '$http', '$timeout', 'datetime', function ($scope, $http, $timeout, datetime, $rootScope){
	$scope.loop_auc_id = $("#loop_auc_id").val();
//	alert($scope.loop_auc_id);
	
	// Loading
	$("#myLoading").show();
	
	// End loading
	
	
	//TODO: Get auction product by category id
	$scope.getAuctionProductByCategoryID = function(id){
		
		$http({
			url: ' http://localhost:8080/rest/auction/auc-pro-category/' +$scope.loop_auc_id,
			method: 'GET'
		}).then(function(response){
			$scope.auctionProduct = response.data.DATA;
			$("#myLoading").hide();
		});
	}

	$scope.tick = function () {
        $scope.currentTime = moment();
        $scope.processAuctionItemsItems($scope.auctionProduct);
        $timeout($scope.tick, 1000);
        
    }
	
    $scope.processAuctionItemsItems = function (data) {
        angular.forEach(data, function (item) {
            item.remainingTime = datetime.getRemainigTime(item.end_date);
        });
    }
    
    
//	Load Record
	$scope.getAuctionProductByCategoryID();	
	
	// load by auction id
	$scope.currentTime = moment(); 
	$timeout($scope.tick, 1000);
}]);

app.factory('datetime', ['$timeout', function ($timeout) {
	
    var duration = function (timeSpan) {
        var days = Math.floor(timeSpan / 86400000);
        var diff = timeSpan - days * 86400000;
        var hours = Math.floor(diff / 3600000);
        diff = diff - hours * 3600000;

        var minutes = Math.floor(diff / 60000);
        diff = diff - minutes * 60000;

        var secs = Math.floor(diff / 1000);

        return { 'days': days, 'hours': hours, 'minutes': minutes, 'seconds': secs };
    };

    function getRemainigTime(referenceTime) {
        var now = moment().utc();
        return moment(referenceTime) - now;
    }
    return {
        duration: duration,
        getRemainigTime: getRemainigTime
    };
}]);

app.filter('durationview', ['datetime', function (datetime) {
    return function (input, css) {
        var duration = datetime.duration(input);
        
        return duration.days + "days, " + duration.hours + "h:" + duration.minutes + "m:" + duration.seconds + "s";
    };
}]);
