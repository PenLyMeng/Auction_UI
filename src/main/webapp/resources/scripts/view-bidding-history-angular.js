var app = angular.module('myApp', []);

// declare 3 controllers that conflicts with our controller(mailCtrl)
app.controller('auctionCtrl', function(){})
//app.controller('categoryCtrl', function(){})
//app.controller('myCtrl', function(){});

//=== end declare conflicted controllers=======================


app.controller('biddingHistoryCtrl', ['$scope', '$http', '$timeout', 'datetime', function ($scope, $http, $timeout, datetime, $rootScope){
	
	$scope.viewBiddingHistory = function(){
		// get auction id when user click on bid history button
		var id = window.location.href.substring(window.location.href.lastIndexOf('/') + 1);
		
		// loading
		$("#myLoading").show();
		
		
		$http({
			url: '/rest/bidhistory/find-num-bid-and-bidder-in-auction-product-by-auc-id/' + id,
			method: 'GET'
		}).then(function(response){
			// get respnse data
			$scope.auctionBidHistory = response.data.DATA;
			
			
			// run remaining date
			$scope.processAuctionItems(response.data.DATA[0].auction);
			$scope.remaing_date = response.data.DATA[0].auction;
			
			// show distinct information on the top
			$scope.product_name=response.data.DATA[0].auction.product.product_name;
			$scope.current_price=response.data.DATA[0].auction.current_price;
			$scope.start_price=response.data.DATA[0].auction.start_price;
			$scope.num_bid=response.data.DATA[0].auction.num_bid;			
			$scope.start_date = moment(response.data.DATA[0].auction.start_date).format("LLLL");
			$scope.end_date = moment(response.data.DATA[0].auction.end_date).format("LLLL");
			
			$("#myLoading").hide();
			
		});
	}
	
	$scope.tick = function () {
        $scope.currentTime = moment();
        $scope.processAuctionItems($scope.remaing_date);
        $timeout($scope.tick, 1000);
    }
    $scope.processAuctionItems = function (data) {
        data.remainingTime = datetime.getRemainigTime(data.end_date);    	
    }
    
    // load by auction id
    $timeout($scope.tick, 1000);
    $timeout($scope.auctionBidHistory, 10000);
	$scope.currentTime = moment(); 
	
	// show bidhistory
	$scope.viewBiddingHistory();
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
