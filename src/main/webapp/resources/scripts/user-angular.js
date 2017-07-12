/**
 * angular get, add, delete, update user
 */

var app = angular.module('myApp', []);

app.controller('auctionCtrl', function() {

})

// TODO: VIEW USER BACK END
app.controller('viewUserCtrl', function($scope, $http, $rootScope) {

	// select all record to display
	$scope.userName = "";
	var checkPagination = true;
	var currentPage = 1;

	$scope.getAllUsers = function() {
		// alert($scope.pages);
		$http(
				{
					url : '/rest/user?limit=' + 10 + "&page=" + currentPage
							+ "&userName=" + $scope.userName,
					method : 'GET',

				}).then(function(response) {
			$scope.user = response.data.DATA;
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
		$scope.getAllUsers();
	});

	// //////////////////////////
	$scope.getUserByID = function(id) {

		$http({
			url : '/rest/user/' + id,
			method : 'GET'
		}).then(
				function(response) {
					$scope.user_name = response.data.DATA.user_name;
					$scope.password = response.data.DATA.password;
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
					$scope.photo = response.data.DATA.photo;
					if (response.data.DATA.type == 'admin') {
						$("#role1").prop("checked", true);
					} else {
						$("#role2").prop("checked", true);
					}
					if (response.data.DATA.status == '1') {
						$("#status1").prop("checked", true);
					} else {
						$("#status2").prop("checked", true);
					}
					$scope.comment = response.data.DATA.comment;
				})
	}
	// Update User
	$scope.updateUser = function(id) {
		date1 = ($('#dob1').val()).split(':');
		date2 = date1[0].split(' ');
		date3 = date2[0].split('-');

		startDate = new Date(parseInt(date3[2]), parseInt(date3[1]) - 1,
				parseInt(date3[0]));

		$scope.created_date = new Date();
		$scope.created_by = 'admin';
		$http(
				{
					url : '/rest/user',
					method : 'PUT',
					data : {
						"user_id" : id,
						"address" : $scope.address,
						"comment" : $scope.comment,
						"contact" : $scope.contact,
						"created_by" : $scope.created_by,
						"created_date" : $scope.created_date,
						"dob" : startDate,
						"email" : $scope.email,
						"first_name" : $scope.first_name,
						"gender" : $('.select2').val(),
						"last_name" : $scope.last_name,
						"password" : $scope.password,
						"photo" : $scope.photo,
						"status" : $("input:radio[name=status]:checked").val(),
						"type" : $("input:radio[name=role]:checked").val(),
						"user_name" : $scope.user_name,
						"role_id" : ($("input:radio[name=status]:checked")
								.val() == 'admin') ? 1 : 2
					}
				}).then(function(response) {
			swal({
				title : "Success",
				text : "User has been updated!",
				type : "success",
				timer : 1000,
				showConfirmButton : false
			});
			$scope.getAllUsers();
		}, function(error) {
		});
	}

	// delete supplier
	$scope.deleteUser = function(id, e) {

		console.log(id);

		swal({
			title : "Are you sure?",
			text : "Your will not be able to recover this user!",
			type : "warning",
			showCancelButton : true,
			confirmButtonColor : "#DD6B55",
			confirmButtonText : "Yes, delete it!",
			cancelButtonText : "No, cancel plx!",
			closeOnConfirm : false,
			closeOnCancel : false
		}, function(isConfirm) {
			if (isConfirm) {
				$http({
					url : '/rest/user/' + id,

					method : 'DELETE'
				}).success(function(response) {
					$scope.getAllUsers();
				});
				swal({
					title : "Deleted!",
					text : "The user has been deleted.",
					type : "success",
					timer : 1000,
					showConfirmButton : false
				});

				// $scope.findAllSuppliers();
			} else {
				swal({
					title : "Cancelled!",
					text : "Your user is not deleted :)",
					type : "error",
					timer : 1000,
					showConfirmButton : false
				});
			}
		});
	}

	// ////////////////////////

	// load all record

	$scope.getAllUsers();
})

// TODO: ADD DELETE UPDATE BACK END
app.controller('UserCtrl', function($scope, $http, $rootScope) {
	// add record function
	$scope.addUser = function() {
		$scope.created_date = new Date();
		$scope.created_by = 'admin';
		$http(
				{
					url : '/rest/user',
					method : 'POST',
					data : {
						"address" : $scope.address,
						"comment" : ($scope.comment == undefined) ? 'New'
								: $scope.comment,
						"contact" : $scope.contact,
						"created_by" : $scope.created_by,
						"created_date" : $scope.created_date,
						"dob" : moment($('#datepicker').val()).format(
								"YYYY-MM-DD"),
						"email" : $scope.email,
						"first_name" : $scope.first_name,
						"gender" : $('.select2').val(),
						"last_name" : $scope.last_name,
						"password" : $scope.password,
						"photo" : ($scope.photo == undefined) ? 'String'
								: $scope.photo,
						"status" : ($scope.status == undefined) ? '1' : $(
								"input:radio[name=status]:checked").val(),
						"type" : ($scope.type == undefined) ? 'bidder' : $(
								"input:radio[name=role]:checked").val(),
						"user_name" : $scope.user_name
					}
				}).then(function(respone) {
			swal({
				title : "Success!",
				text : "User has been inserted.",
				type : "success",
				timer : 1000,
				showConfirmButton : false
			}, function() {
				window.location.href = '/admin/viewuser';
			});

		});
	}

	// Get User By ID
	// $scope.getUserByID = function(userObject){
	// alert(userObject.user_name);
	// $scope.user_name = userObject.user_name;
	// $scope.password = userObject.password;
	// $scope.email = userObject.email;
	// $scope.contact = userObject.contact;
	// $scope.first_name = userObject.first_name;
	// $scope.last_name = userObject.last_name;
	//		
	// if((userObject.gender=='female') || (userObject.gender=='F')){
	//
	// $('select[name="gender"]').find('option[value="female"]').attr("selected",true);
	// }else{
	//
	// $('select[name="gender"]').find('option[value="male"]').attr("selected",true);
	// }
	// $scope.dob = userObject.dob;
	// $scope.address = userObject.address;
	// $scope.photo = userObject.photo;
	// if(userObject.type=='admin'){
	// $( "#role1" ).prop( "checked", true);
	// }
	// else{
	// $( "#role2" ).prop( "checked", true);
	// }
	// if(userObject.status=='1'){
	// $( "#status1" ).prop( "checked", true);
	// }
	// else{
	// $( "#status2" ).prop( "checked", true);
	// }
	// $scope.comment = userObject.comment;
	//		
	// $scope.user_id = userObject.user_id;
	//			
	// }

	// Get user_name and password to login
	$scope.userLogin = function(user_name, password) {
		$http({
			url : '/rest/user',
			method : 'POST',
			data : {
				"user_name" : $scope.user_name,
				"password" : $scope.password
			}
		})
	}

	// $scope.addUser();
})

// ========================================================================================
// TODO: ADD USER FRONT END
app
		.controller(
				'addUserCtrl',
				function($scope, $http, $rootScope) {
					// add record function
					$scope.addUser = function() {
						$scope.verified_code = $scope.generateUUID();
						
						$scope.created_date = new Date();
						$scope.created_by = 'admin';
						$http(
								{
									url : '/rest/user',
									method : 'POST',
									data : {
										"address" : $scope.address,
										"comment" : ($scope.comment == undefined) ? 'New'
												: $scope.comment,
										"contact" : $scope.contact,
										"created_by" : $scope.created_by,
										"created_date" : $scope.created_date,
										"dob" : moment($('#datepicker').val())
												.format("YYYY-MM-DD"),
										"email" : $scope.email,
										"first_name" : $scope.first_name,
										"gender" : $('.select2').val(),
										"last_name" : $scope.last_name,
										"password" : $scope.password,
										"photo" : ($scope.photo == undefined) ? 'String'
												: $scope.photo,
//										"status" : ($scope.status == undefined) ? '1'
//												: $(
//														"input:radio[name=status]:checked")
//														.val(),
										"status" : '0', // ===== before confirming email, user status is inactive(0)		
										"type" : ($scope.type == undefined) ? 'bidder'
												: $(
														"input:radio[name=role]:checked")
														.val(),
										"user_name" : $scope.user_name,
										"verified_code" : $scope.verified_code
									}
								}).then(function(respone) {
							swal({
								  title: "Email Confirmation",
								  text: "An email has been sent to "+$scope.email+" It contains a confirmation link you must click to confirm your email address.",
								  type: "warning",
								  confirmButtonClass: "btn-danger",
								  confirmButtonText: "Yes, I got it!",								  
								  closeOnConfirm: false								  
								},
								function(isConfirm) {
								  if (isConfirm) {
									  $scope.sendMail();
									  window.location.href = '/';
								  } 								
								});
									
						});
					}

					// ======= Generate Universal Unique ID
					$scope.generateUUID = function() {
						var d = new Date().getTime();
						var uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'
								.replace(/[xy]/g, function(c) {
									var r = (d + Math.random() * 16) % 16 | 0;
									d = Math.floor(d / 16);
									return (c == 'x' ? r : (r & 0x3 | 0x8))
											.toString(16);
								});
						return uuid;
					};
					// ======= End Generate UID

					// ======= Send email to verify
					// send user message to our mailbox by using our email
					// because we don't want to configure email of user anymore
					$scope.sendMail = function() {

						var kh_msg = "សូមស្វាគមន៍, \r\n"
								+ "គណនីរបស់អ្នកត្រូវបានបង្កើត⁣។ ដើម្បីដំនើរការ⁣ សូមចុចលើតំណរភ្អាប់ខាងក្រោម៖\r\n"
								+ "http://localhost:8080/register/confirm/"
								+ $scope.verified_code
								+ "\r\n"
								+ "ដេញ⁣ ថ្លៃ⁣ គឺជាគេហទំព័រដំបូងគេនៅកម្ពុជាផ្លល់នូវសេវាកម្ម⁣ប្រកបដោយភាពងាយស្រួួូួលក្នុងការដេញថ្លៃ។\r\n"
								+ "បើសិនមានចំងល់⁣⁣ សូមទំនាក់ទំនង⁣ http://localhost:8080/contactus"
								+ "\r\n"
								+ "រីករាយក្នុងការប្រើប្រាស់សេវាកម្មរបស់យើងខ្ញំុ\r\n\r\n";

						var en_msg = "Welcome,\r\n"
								+ "Your account "
								+ $scope.email
								+ " has been created. To activate it, please confirm your email address: "
								+ "http://localhost:8080/register/confirm/"
								+ $scope.verified_code
								+ "\r\n"
								+ "DENH TLAI is the first Cambodia auction website.\r\n"
								+ "Need help or have questions? Contact us: http://localhost:8080/contactus"
								+ "\r\n" + "Have a great day.";
						var msg = kh_msg + en_msg;
						$http({
							url : 'http://localhost:8080/rest/mail',
							method : 'POST',
							data : {

								"body" : msg,
								"subject" : "DENH TLAI - Email Confirmation",
								"to" : $scope.email // user send mail to
															// us

							}
						}).then(function(response) {
							
						});
					}
					// ======= End Send email to verify
					
					

				})