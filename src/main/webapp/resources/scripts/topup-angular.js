/**
 * 
 */


var app = angular.module('myApp',[]);

app.controller('ctrlTopup', function($scope, $http){
	$scope.fullName = "";
	var checkPagination = true;
	var currentPage = 1;
	//TODO:  GET ALL USER CREDIT WITH ENDING AMOUNT 
	$scope.findAllUserCreditWithEndingAmount = function(){		
		$http({
			url : '/rest/user-credit/user-ending-amount?limit=' + 10 +"&page=" + currentPage + "&userName="+$scope.fullName,
			method : 'GET'
		}).then(function(response) {
			$scope.userEndingAmount = response.data.DATA;
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
		$scope.findAllUserCreditWithEndingAmount();
	});
	
	
	//TODO: INSERT TOPUP PRICE TO BID HISTORY 
	$scope.addTopUp = function(){
		$http({
          method: 'POST',
          url: '/rest/top-up/add-top-up',
          data: {
        	  
        	  "amount": $scope.balance,
        	  "currency": $scope.curr,
        	  "user_id" : $scope.user_id,
          }
      }).then(function (response) {
    	  swal({ 
				title: "Success!",
				text: "TopUp Successfully..! :)",
			    type: "success",
			    timer : 1000,
			    showConfirmButton : false
    	  });
    	  $scope.findAllUserCreditWithEndingAmount();
      });
	}
	
	
	//TODO: GET ALL USER TO DISPLAY IN SELECT OPTION 
	$scope.getAllUsers = function(){

		$http({
			url: '/rest/user',
			method: 'GET',
			
		}).then(function(response){
			$scope.user = response.data.DATA;
		});
	}
	
	$scope.getAllUsers();
	$scope.findAllUserCreditWithEndingAmount();
})