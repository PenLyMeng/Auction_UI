/**
 * 
 */

var app = angular.module('myApp', []);

//TODO: SHOW AUCTON TO VIEW CLIENTS
app.controller('auctionCtrl', ['$scope', '$http', '$timeout', 'datetime', function ($scope, $http, $timeout, datetime, $rootScope) {
	$scope.productName = "";
	var checkPagination = true;
	var currentPage = 1;

	//TODO: select all record to display 
	$scope.findAllBestBiddingAuctions = function() {
		$("#myLoading").show();
		$http({
			url : '/rest/auction/find-all-best-bidding-auctions?limit=' + 8 +"&page=" + currentPage + "&productName="+$scope.productName,
			method : 'GET'
		}).then(function(response) {
			$scope.processAuctionItemsItems(response.data.DATA);
			$scope.auctionBestBid = response.data.DATA;
			if(checkPagination){
				$scope.setPagination(response.data.PAGINATION);
				checkPagination = false;
			}
			$("#myLoading").hide();
		});	
	}
	
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
		$scope.findAllBestBiddingAuctions();
	});
	
	$scope.tick = function () {
        $scope.currentTime = moment();
        $scope.processAuctionItemsItems($scope.auction);
        $timeout($scope.tick, 1000);
    }
	
    $scope.processAuctionItemsItems = function (data) {
        angular.forEach(data, function (item) {
            item.remainingTime = datetime.getRemainigTime(item.end_date);
        });
    }
        
	// load all record
	$scope.findAllBestBiddingAuctions();
	$scope.currentTime = moment(); 
	$timeout($scope.tick, 1000);

	//========================PAGINATION AND SEARCH DATA================================
	//TODO: SEARCH BY PRODUCT NAME
//	$scope.searchProName = function(proName){
//		$http({
//			url : '/rest/auction?limit=' + 12 +"&page=" + currentPage + "&productName="+proName,
//			method : 'GET'
//		}).then(function(response) {
//			$scope.auction = response.data.DATA;
//			if(checkPagination){
//				$scope.setPagination(response.data.PAGINATION);
//			}
//		});
//	}
////	$scope.test = function(){
//		alert($scope.proName);
//	}
	
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


// connect Web Socket
connect();
