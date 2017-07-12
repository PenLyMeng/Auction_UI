/**
 * angular get, add, delete, update user
 */

var app = angular.module("myApp", []);

app.controller("auctionCtrl", function(){
	
});


// TODO: =========ALL BID WINNERS FOR BACK-END============
app.controller('allBidWinners', function($scope,$http){
	$scope.userName = "";
	var checkPagination = true;
	var currentPage = 1;	
	// select all record to display
	$scope.findAllBidWinners = function(){
		
		$http({
			url: '/rest/bidhistory/find-all-bid-winners?limit=' + 20 +"&page=" + currentPage + "&userName="+$scope.userName,
			method: 'GET'
			
		}).then(function(response){
			
			$scope.allBidWiners = response.data.DATA;
			//pagination
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
		$scope.findAllBidWinners();
	});
	
	$scope.findAllBidWinners();
	
})

