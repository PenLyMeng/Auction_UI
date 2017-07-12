<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<body ng-app="myApp">
<div class="wrapper" ng-controller="auctionCtrl" id="mainMenuPage">
<header>
	<div class="container-fluid head">
		<div class="container">
			<div class="row">
				<div class="col-md-6">
				<i class="fa fa-volume-control-phone" ></i> <spring:message code="contact_info"></spring:message>
				</div>
				<div id="right-head-info" class="col-md-6">
					<sec:authorize access="!isAuthenticated()">
					
<%-- 						<a class="nav-link" href="${pageContext.request.contextPath}/login" id="loginFrm"> --%>
<%-- 							<spring:message code="login"></spring:message>  --%>
<!-- 						</a> -->
						
						<a class="nav-link" href="http://localhost:2016/login?continue-site=http://localhost:8080" id="loginFrm">
							<spring:message code="login"></spring:message> 
						</a>
		
						
						<span>&nbsp;|&nbsp; </span>
					
<%-- 						<a class="nav-link" href="${pageContext.request.contextPath}/register"><spring:message code="register"></spring:message></a> --%>
						<a class="nav-link" href="http://localhost:2016/register?continue-site=http://localhost:8080/register"><spring:message code="register"></spring:message></a>
						
						
						<span>&nbsp;|&nbsp; </span>
						
					</sec:authorize>
					
					<span clas="lang" key="my_wishlist"><spring:message code="my_wishlist"></spring:message></span>
					<sec:authorize access="isAuthenticated()">
						<span class="nav-item dropdown logined">
							<a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" 
							role="button" aria-haspopup="true" aria-expanded="false">
								<spring:message code="welcome"></spring:message>  <sec:authentication property="principal.username" />
								
							</a>
							<h5 class="dropdown-menu" aria-labelledby="Preview">
								<a href="${pageContext.request.contextPath}/userprofile" style="padding-bottom: 1px;">						
								<i class="fa fa-user"></i> <spring:message code="my_account"></spring:message></a><br/><br/>
								
								<a href="${pageContext.request.contextPath}/logout" >
								<i class="fa fa-sign-out"></i> <spring:message code="logout"></spring:message></a>
							</h5>
						</span>
					</sec:authorize>
				</div>
			</div>
		</div>
	</div>
	<div class="container-fluid menu">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<a href="${pageContext.request.contextPath}/index">
					<img src="${pageContext.request.contextPath}/resources/static/images/denhtlaiHD.png" class="img-responsive">
					</a>
				</div>
				<div class="col-md-6">
					<ul class="menu-list-ul">
						<li class="menu-list-li"><a href="${pageContext.request.contextPath}/bestbid"><spring:message code="best_bidding"></spring:message></a></li>
<%-- 						<li class="menu-list-li"><a href="#"><spring:message code="best_brand"></spring:message></a></li> --%>
						<li class="menu-list-li"><a href="${pageContext.request.contextPath}/contactus"><spring:message code="contact"></spring:message></a></li>
						<li class="menu-list-li"><a href="${pageContext.request.contextPath}/aboutus"><spring:message code="about"></spring:message></a></li>
					</ul>
				</div>
				<div class="col-md-2" style="margin-top: 35px; text-align:right;">
					<spring:message code="language"></spring:message>
					<a href="/language?language=en" class="translate" id="en"><img alt="en-img" style="width:30px; height:30px; padding:0px;"
					src="${pageContext.request.contextPath}/resources/images/en.png" ></a>
					<a href="/language?language=kh" class="translate" id="kh"><img alt="kh-img" style="width:30px; height:30px; padding:0px;"
					src="${pageContext.request.contextPath}/resources/images/kh.png"></a>
				</div>
			</div>
		</div>
	</div>
	<div class="container" style="padding-right:0" id="searchPanel">
			<div class="row" style="padding:0">
				<div class="col-md-3" style="line-height:-8px;background-color: #e6e6e6;padding:2px;">
					<div align="center" style="color:gray; margin:5px 0 0 15px;"><b><spring:message code="categories"></spring:message></b>
					<i class="fa fa-caret-square-o-down" aria-hidden="true" style="margin-left:80px; font-size:18px;" id="dropdownmenu"></i>
					</div>
				</div>
				<div class="col-md-9" style="background-color: #e6e6e6;padding:0;">
					<form style="padding:4px;" ng-submit="searchProName(proName)">
						<div class="input-group">
							<input type="text" placeholder="Enter keyword" style="border:none;padding-left: 20px;width:100%" 
							ng-model="proName" ng-change="searchProName(proName)">
							<div class="input-group-addon" style="border:none;"><i class="fa fa-search" aria-hidden="true"></i></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	
<!-- Script use for search data	 -->
<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/scripts/main-angular.js"></script>
</header>

<!-- Web Socket - create a button to call the function sendName when user bids product on the other page. This button is a trigger and it runs when user bids, and then it gets data after 1 second-->
<button type="button" onclick="sendName()" id="wsButton" style="display:none">Web Socket</button>
<!-- End test web socket -->
		
<script type="text/javascript">
$("#dropdownmenu").click(function(){
	$("#menustand").toggle(function(){
		$("#right-content").toggleClass('col-md-9 col-md-12');
	});
});

$(function() {
	
	$("#formLogin").submit('hidden.bs.modal',function(e){		
		  
   		  e.preventDefault();
   		  console.log($("#formLogin").serialize());
   		  $.ajax({
	            url: "${pageContext.request.contextPath}/",
	            type: "POST",
	            data: $("#formLogin").serialize(),
	            success: function(data) {
	            	if(data == "User account is locked"){
	            		alert(data);
	            	}else if(data == "User is disabled"){
	            		swal("LOGIN FAILED!", data, "error");
	            	}else if(data == "Bad credentials"){
	            		swal("LOGIN FAILED!", data, "error");
	            	}else{
	            		swal({ 
	        				title: "LOGIN SUCCESSFULLY!",
	        				text: "THANK YOU",
	        			    type: "success",
	        			    timer : 1000,
	        			    showConfirmButton : false
	        			  },
	        			  function(){
	        				  if(data=='admin'){
	          						window.location.href="http://localhost:8080/"+data;	
	          					}else{
	          						window.location.href = window.location.href	
	          					}
	        			});
	            		
// 	            		swal({   
// 	          			title: "LOGIN SUCCESSFULLY!",   
// 	          			text: "THANK YOU",   
// 	          			type: "success",   
// 	          			confirmButtonColor: "#007d3d",   
// 						closeOnConfirm: false,   
// 	          			closeOnCancel: false }, 
// 	          			function(isConfirm){   
// 	          				if(isConfirm) {     		
// 	          					if(data=='admin'){
// 	          						window.location.href="http://localhost:8080/"+data;	
// 	          					}else{
// 	          						window.location.href = window.location.href	
// 	          					}
// 	          				}else {     
// 	          					swal("Cancelled", "Your imaginary file is safe :)", "error");   
// 	          				} 
// 	          			}); 
   		  
	            	}
	            },
	         	error: function(data){
	         		console.log(data);
	         	}
   		  });
		  
	});
	
});

</script>
<!--  Web Socket -->
<script
	src="${pageContext.request.contextPath}/resources/static/js/sockjs-0.3.4.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/static/js/stomp.js"></script>
<script type="text/javascript">
        var stompClient = null;
        
        function disconnect() {
            if (stompClient != null) {
                stompClient.disconnect();
            }
            console.log("Disconnected");
        }
        
        function connect() {
        	if (stompClient != null) {
                stompClient.disconnect();
            }
        	var socket = new SockJS('/hello');
            stompClient = Stomp.over(socket);            
            stompClient.connect({}, function(frame) {
                console.log('Connected: ' + frame);
                stompClient.subscribe('/topic/greetings', function(greeting){
                    //showGreeting(JSON.parse(greeting.body).content);
                    // Call getAuctionById() after user bidding
                	//angular.element(document.getElementById('right-content')).scope().getAuctionById();
                    
                    //Call find all auctions to show real-time data for visitor who view our main page without click on specific product yet
                	angular.element(document.getElementById('mainMenuPage')).scope().findAllAuctions();
                    
                });
            });
            
        }
        
        
        function sendName() {
        	
//         	alert("HELLO SEND NAME");
            var name = "Hello"
            stompClient.send("/app/hello", {}, JSON.stringify({ 'name': name }));

        }
        
        function showGreeting(message) {
            alert(message);
        }
        
        $(function(){    
            setTimeout(function() {
               $("wsButton").trigger('click');
            },1);
         });
        connect();
 </script>
 <!-- End WebSocket -->
	