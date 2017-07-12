
<!-- ================ Starting Content Section ================= -->
	<div class="container panle1" style="padding:0;" ng-controller="categoryCtrl">
		<div class="row">
			<!-- ============ List Categpries Section ============= -->
			<div class="col-md-3" id="menustand">		
				<div class="panel-group" id="parent">
				   <div class="panel panel-default" ng-repeat="c in maincategory">
				     <div class="panel-heading">
				       <h4 class="panel-title">
				         <a data-toggle="collapse" ng-cloak href="#item-{{$index+1}}" data-parent="#parent">{{c.category_name}}</a>
				       </h4>				 
				     </div>
				     <div class="panel-collapse collapse" ng-cloak id="item-{{$index+1}}">
				       <ul class="list-group">
				         <li class="list-group-item" ng-repeat="subCategory in c.subCategories">&nbsp;&nbsp;
				         <a ng-cloak href="${pageContext.request.contextPath}/itemlist?cat={{subCategory.category_name}}&&id={{subCategory.category_id}}" class="submenu"><i class="fa fa-chevron-right" aria-hidden="true"></i>
				         &nbsp;&nbsp;{{subCategory.category_name}}</a></li>			         
				       </ul>
				     </div>
				   </div>
				  </div>								
			</div> <!-- ============ End List Categpries Section ============= -->