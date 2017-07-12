/**
 * angular get, add, delete, update user
 */

var app = angular.module("myApp", []);

app.controller("auctionCtrl", function(){
	
});

app.controller('bidHistory', function($scope,$http){
	
	// select all record to display
	$scope.findAllBidHistory = function(){
		$http({
			url: 'http://localhost:8080/rest/bidhistory',
			method: 'GET',
			
		}).then(function(respone){
			$scope.bidHistory = respone.data.DATA;
		});
	}
	
	$scope.findAllBidHistory();
})


app.controller('userBidHistory',['$scope', '$http', '$timeout', 'datetime', function ($scope, $http, $timeout, datetime, $rootScope){
	
	// Show or Hide Panel
	$scope.controlPanel = function(){
        $scope.credit = 'true';
       
     }
	
	$scope.test = function(){
		alert("test");
	}
	
	
	//=================================================================
	//TODO: INSERT BID PRICE TO BID HISTORY 
	$scope.addTopUp = function(){
		$http({
          method: 'POST',
          url: '/rest/top-up',
          data: {
        	  "amount": $scope.balance,
        	  "currency": $scope.curr,
          }
      }).then(function (response) {
    	  	$scope.ending_amount = response.data.DATA.ending_amount;
    	  	if(response.data.CODE=="9999"){
    	  		alert("YOUR TOP UP BALANCE " + response.data.DATA.amount);
    	  	}
//    	  	alert(response.data.DATA.ending_amount);
      });
	}
	
	$scope.userCredit = function(userID){
		$http({
	          method: 'GET',
	          url: '/rest/user-credit/'+ userID
	      }).then(function (response) {
	    	  	$scope.ending_amount = response.data.DATA.ending_amount;
	      });
	}
	$scope.userCredit(USER_ID);
	//===============================================
	
	// select Bid History By UserName to display
	$scope.findBidByUserId = function(user_id){
		
		$http({
			url: 'http://localhost:8080/rest/bidhistory/' + user_id,
		}).then(function(response){
			$scope.userBidHistory = response.data.DATA;
			$scope.processAuctionItems($scope.userBidHistory);
		});
	}

    $scope.tick = function () {
        $scope.currentTime = moment();
        $scope.processAuctionItems($scope.userBidHistory);
        $timeout($scope.tick, 1000);
    }
    
    $scope.processAuctionItems = function (data) {
        data.remainingTime = datetime.getRemainigTime(data.auction.end_date);
    }
    
    $timeout($scope.tick, 1000);
    $timeout($scope.userBidHistory, 10000);
	$scope.currentTime = moment(); 
	
	$scope.findBidByUserId(USER_ID);
	
	
	
	
	
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




