/**
 * angular get, add, delete, update user
 */

var app = angular.module('myApp', []);

// declare 3 controllers that conflicts with our controller(mailCtrl)
app.controller('auctionCtrl', function(){})
app.controller('categoryCtrl', function(){})
app.controller('myCtrl', function(){});
//=== end declare conflicted controllers=======================


app.controller('mailCtrl', function($scope,$http,$rootScope){
	
	
	// send user message to our mailbox by using our email because we don't want to configure email of user anymore
	$scope.sendMail = function(){
		
		$http({
			url: 'http://localhost:8080/rest/mail',
			method: 'POST',
			data:{
			  		  
					"body": $scope.message + "\r\n"+$scope.last_name+" "+$scope.first_name+"\r\n"+$scope.email, // mail body 
					"subject": "DENH TLAI - User Enquiry - Sender name: "+$scope.last_name+" "+$scope.first_name, // mail title
					"to": "denhtlai@gmail.com"  // user send mail to us
	  			  
			}
		}).then(function(response){
			swal({ 
				title: "Success!",
				text: "Mail has been sent.",
			    type: "success", 
			    timer : 1000,
			    showConfirmButton : true
			  },
			  function(){				
				$('#last_name').val("");
				$('#first_name').val("");
				$('#email').val("");
				$('#message').val("");
			});
			
		});
	}

	
});