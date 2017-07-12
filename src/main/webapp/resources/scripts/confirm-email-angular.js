/**
 * angular get, add, delete, update user
 */

var app = angular.module('myApp', []);

//declare 3 controllers that conflicts with our controller(mailCtrl)
app.controller('auctionCtrl', function(){})
app.controller('categoryCtrl', function(){})
app.controller('myCtrl', function(){});
//=== end declare conflicted controllers=======================


app.controller('confirmEmailCtrl', function($scope,$http,$rootScope){
	$scope.confirmEmail = function(){
		// get verified_code when user click on the link from his/her email
		var id = window.location.href.substring(window.location.href.lastIndexOf('/') + 1);
				
		$http({
			url: '/rest/user/update-user-confirm-email/' + id,
			method: 'PUT'
		}).then(function(response){
			
		});
	}
	$scope.confirmEmail();
	
});
	
