/**
 * angular get, add, delete, update user
 */

var app = angular.module("myApp", []);

app.controller("auctionCtrl", function(){
	
});


// TODO: =========BID HISTORY FOR BACK-END============
app.controller('bidHistory', function($scope,$http){
	$scope.userName = "";
	var checkPagination = true;
	var currentPage = 1;
	// select all record to display
	$scope.findAllBidHistory = function(){
		$http({
			url: '/rest/bidhistory?limit=' + 20 +"&page=" + currentPage + "&userName="+$scope.userName,
			method: 'GET',
			
		}).then(function(response){
			$scope.bidHistory = response.data.DATA;
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
		$scope.findAllBidHistory();
	});
	
	$scope.findAllBidHistory();
	
})

// TODO: =====+++++++++++++++++++++++++++++++++++++++++====BID HISTORY BY USER_ID FOR FRONT-END============
app.controller('userBidHistory', ['$scope', '$http', '$timeout', 'datetime', function ($scope, $http, $timeout, datetime, $rootScope){
	$scope.formdata = {};
	
	// Show or Hide Panel
	$scope.controlPanel = function(){
        $scope.credit = 'true';
       
     }
	
	// select Bid History By UserName to display
	$scope.findBidByUserId = function(user_id){
		
		$http({
			url: '/rest/bidhistory/' + user_id,
		}).then(function(response){
			$scope.userBidHistory = response.data.DATA;
			
			//$scope.processAuctionItems($scope.userBidHistory);
			
			
		});
	}
	
	/*checkout*/
	
	$scope.checkOut = function(item){
		onInvoice();
	
		$('#created-date').html(moment(new Date()).format("DD-MM-YYYY"));
		$('#auction_id').html(item.auction.auction_id);
		$('#item-name').html(item.auction.product.product_name);
		$('#unit-price').html(item.auction.current_price);
		$('#total-price').html(item.auction.current_price);
		$('#sub-total').html(item.auction.current_price);
		$('#total').html(item.auction.current_price);
		$('#address').html(item.user.address);
		
	}
	
	
	//TODO: ADD INVOICE TO INVOICE DETAIL
	
	
	$scope.addInvoice = function(){
				
		$http({
			url : 'rest/bidhistory/add-invoice',
			method : 'POST',
			data : {
				"auction_id" : $("#auction_id").text(),
				"buy_price" : $("#unit-price").text(),
				"qty" : 1,
				"user_id" : USER_ID,
			}
		}).then(function(response){
			swal({
				title : "Success!",
				text : "Invoice has been Created But Not Paid Yet.",
				type : "success",
				timer : 1000,
				showConfirmButton : false
			});
			$scope.findBidByUserId(USER_ID);
		})
	}
	
	
	//=================================================================
	//TODO: INSERT BID PRICE TO BID HISTORY 
	$scope.addTopUp = function(){
		$http({
          method: 'POST',
          url: '/rest/top-up',
          data: {
        	  "amount": $scope.balance,
        	  "currency": $('.selectCurr').val(),
          }
      }).then(function (response) {
    	  	$scope.ending_amount = response.data.DATA.ending_amount;
    	  	if(response.data.CODE=="9999"){
    	  		//alert("YOUR TOP UP BALANCE " + response.data.DATA.amount);
    	  		swal({
    				title : "Top Up",
    				text : "Your Top Up Balance is "+response.data.DATA.amount + " Riel",
    				type : "success",
    				showConfirmButton : true
    			});
    	  		
    	  		
    	  		
    	  	}
//    	  	alert(response.data.DATA.ending_amount);
      });
	}
	
	
	
	//================================================================
	//TODO: GET USER DETAIL
	// get user by id
	$scope.getUserByID = function(id) {
		
		$http({
			url : '/rest/user/' + id,
			method : 'GET'
		}).then(
				function(response) {
					$scope.password=response.data.DATA.password;	
					$scope.email = response.data.DATA.email;
					$scope.contact = response.data.DATA.contact;
					$scope.first_name = response.data.DATA.first_name;
					$scope.last_name = response.data.DATA.last_name;
					if ((response.data.DATA.gender == 'female')
							|| (response.data.DATA.gender == 'F')) {

						$('select[name="gender"]').find(
								'option[value="female"]')
								.attr("selected", true);
					} else {

						$('select[name="gender"]').find('option[value="male"]')
								.attr("selected", true);
					}
					$scope.dob = moment(response.data.DATA.dob).format(
							"DD-MM-YYYY");

					$scope.address = response.data.DATA.address;
					
					

				});
	}
	$scope.getUserByID(USER_ID);
	
	// =====================================================
	// TODO: Update User information
	$scope.updateUser = function() {
		
		date1 = ($('#dob').val()).split(':');
		date2 = date1[0].split(' ');
		date3 = date2[0].split('-');
		
		
		birthDate = new Date(parseInt(date3[2]), parseInt(date3[1]) - 1,
				parseInt(date3[0]));
		
				
		$http(
				{
					url : '/rest/user/update-user-profile',
					method : 'PUT',
					data : {
						"user_id" : USER_ID,
						"address" : $scope.address,
						"contact" : $scope.contact,
						"dob" : birthDate,
						"email" : $scope.email,
						"first_name" : $scope.first_name,
						"gender" : $('.select2').val(),
						"last_name" : $scope.last_name					
					}
				}).then(function(response) {
			swal({
				title : "Success",
				text : "User has been updated!",
				type : "success",
				timer : 1000,
				showConfirmButton : false
			});
			
		}, function(error) {
			
		});
		
	}
	
	//================================================================
	// =====================================================
	// TODO: Update User password
	$scope.updateUserPassword = function() {
		$scope.getUserByID(USER_ID);
		
		
		var old_pwd = $scope.password;
		var current_pwd = $scope.current_password;
		
		
		if(old_pwd != current_pwd){
			$("#current_password").select();
			swal({
				  title: "Current Password Is Not Correct!",
				  text: "Please try again!",
				  type: "error",
				  confirmButtonClass: "btn-danger",
				  confirmButtonText: "Yes, I got it!",								  
				  closeOnConfirm: false								  
				});
				
			
		}else {
		
		
			$http(
					{
						url : '/rest/user/update-user-password',
						method : 'PUT',
						data : {
							"user_id" : USER_ID,
							"password" : $scope.new_password
						}
					}).then(function(response) {
				swal({
					title : "Success",
					text : "User password has been updated!",
					type : "success",
					timer : 1000,
					showConfirmButton : false
				});
				
			}, function(error) {
				
			});
		
		}
	}
	
	//============================================
	
	
	
	
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
	$scope.tick = function () {
        $scope.currentTime = moment();
        $scope.processAuctionItemsItems($scope.userBidHistory);
        
        $timeout($scope.tick, 1000);
        
    }
	
    $scope.processAuctionItemsItems = function (data) {
        angular.forEach(data, function (item) {
            item.remainingTime = datetime.getRemainigTime(item.auction.end_date);
        });
    }
    
    
	$scope.findBidByUserId(USER_ID);
	// load remaining date/time
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






