<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<body class="fixed-left" ng-app="myApp">

	<!-- Begin page -->
	<div id="wrapper">
		<!-- Top Bar Start -->
		<div class="topbar">
			<!-- LOGO -->
			<div class="topbar-left">
				<div class="text-right" style="padding-top:10px; margin-left:15px">
					<a href="${pageContext.request.contextPath}/admin" class="logo"><img
						src="${pageContext.request.contextPath}/resources/static/images/logo-dashboard.png"
						class="img-responsive" width="170"></a>
				</div>
			</div>

			<!-- Button mobile view to collapse sidebar menu -->
			<div class="navbar navbar-default" role="navigation">
				<div class="container" style="padding:10px; padding-top:25px;">
					<div class="">
						<div class="pull-left">
							<button class="button-menu-mobile open-left">
								<i class="ion-navicon"></i>
							</button>
							<span class="clearfix"></span>
						</div>

						<ul class="nav navbar-nav navbar-right pull-right">
							<li class="dropdown hidden-xs"><a href="#" data-target="#"
								class="dropdown-toggle waves-effect" data-toggle="dropdown"
								aria-expanded="true"> <i class="icon-bell"></i>
							</a>
								<ul class="dropdown-menu dropdown-menu-lg">
									<li class="notifi-title"><span
										class="label label-default pull-right">New 3</span>Notification</li>
									<li class="list-group nicescroll notification-list">
										<!-- list item--> <a href="javascript:void(0);"
										class="list-group-item">
											<div class="media">
												<div class="pull-left p-r-10">
													<em class="fa fa-diamond fa-2x text-primary"></em>
												</div>
												<div class="media-body">
													<h5 class="media-heading">A new order has been placed
														A new order has been placed</h5>
													<p class="m-0">
														<small>There are new settings available</small>
													</p>
												</div>
											</div>
									</a> <!-- list item--> <a href="javascript:void(0);"
										class="list-group-item">
											<div class="media">
												<div class="pull-left p-r-10">
													<em class="fa fa-cog fa-2x text-custom"></em>
												</div>
												<div class="media-body">
													<h5 class="media-heading">New settings</h5>
													<p class="m-0">
														<small>There are new settings available</small>
													</p>
												</div>
											</div>
									</a> <!-- list item--> <a href="javascript:void(0);"
										class="list-group-item">
											<div class="media">
												<div class="pull-left p-r-10">
													<em class="fa fa-bell-o fa-2x text-danger"></em>
												</div>
												<div class="media-body">
													<h5 class="media-heading">Updates</h5>
													<p class="m-0">
														<small>There are <span
															class="text-primary font-600">2</span> new updates
															available
														</small>
													</p>
												</div>
											</div>
									</a> <!-- list item--> <a href="javascript:void(0);"
										class="list-group-item">
											<div class="media">
												<div class="pull-left p-r-10">
													<em class="fa fa-user-plus fa-2x text-info"></em>
												</div>
												<div class="media-body">
													<h5 class="media-heading">New user registered</h5>
													<p class="m-0">
														<small>You have 10 unread messages</small>
													</p>
												</div>
											</div>
									</a> <!-- list item--> <a href="javascript:void(0);"
										class="list-group-item">
											<div class="media">
												<div class="pull-left p-r-10">
													<em class="fa fa-diamond fa-2x text-primary"></em>
												</div>
												<div class="media-body">
													<h5 class="media-heading">A new order has been placed
														A new order has been placed</h5>
													<p class="m-0">
														<small>There are new settings available</small>
													</p>
												</div>
											</div>
									</a> <!-- list item--> <a href="javascript:void(0);"
										class="list-group-item">
											<div class="media">
												<div class="pull-left p-r-10">
													<em class="fa fa-cog fa-2x text-custom"></em>
												</div>
												<div class="media-body">
													<h5 class="media-heading">New settings</h5>
													<p class="m-0">
														<small>There are new settings available</small>
													</p>
												</div>
											</div>
									</a>
									</li>
									<li><a href="javascript:void(0);"
										class="list-group-item text-right"> <small
											class="font-600">See all notifications</small>
									</a></li>
								</ul></li>
							<li class="hidden-xs"><a href="#" id="btn-fullscreen"
								class="waves-effect"><i class="icon-size-fullscreen"></i></a></li>
							<li class="hidden-xs"><a href="#"
								class="right-bar-toggle waves-effect"><i
									class="icon-settings"></i></a></li>
						
								<sec:authorize access="isAuthenticated()">
									<li class="nav-item dropdown logined" style="margin-top:-20px;">
										<a class="nav-link dropdown-toggle profile waves-effect" data-toggle="dropdown" href="#" 
											aria-expanded="true">
										<span class="lang" key="welcome"><sec:authentication property="principal.username" /></span>  
										<img src="${pageContext.request.contextPath}/resources/static/assets/images/users/avatar-1.jpg" alt="user-img"
									class="img-circle">
								
										</a>
										<ul class="dropdown-menu">
											<li><a href="javascript:void(0)"><i
													class="ti-user m-r-5"></i> Profile</a></li>
											<li><a href="javascript:void(0)"><i
													class="ti-settings m-r-5"></i> Settings</a></li>
											<li><a href="javascript:void(0)"><i
													class="ti-lock m-r-5"></i> Lock screen</a></li>
											<li><a href="${pageContext.request.contextPath}/logout"><i
													class="ti-power-off m-r-5 lang" key="logout"></i> Logout</a></li>
										</ul>
										
									</li>
								</sec:authorize>							
						
						</ul>
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
		<!-- Top Bar End -->