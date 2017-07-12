<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Topup Management</title>

<!-- header -->
<jsp:include page="header.jsp"></jsp:include>

<!-- menu -->
<jsp:include page="menu.jsp"></jsp:include>
<!-- left content -->
<jsp:include page="left-content.jsp"></jsp:include>
</head>
	
<!-- ============================================================== -->
<!-- Start right Content here -->
<!-- ============================================================== -->                      
<div class="content-page" ng-controller="ctrlTopup">
<!-- Start content -->
  <div class="content">
    <div class="container">

      <!-- Page-Title -->
      <div class="row">
          <div class="col-sm-12">
              <h4 class="page-title">Topup Management</h4>
              <ol class="breadcrumb">
                <li><a href="#">DENH TLAI</a></li>
                <li class="active">Topup Management</li>
              </ol>
          </div>
      </div>
      
     <!--  ================= FORM TOPUP ========================== -->
      <div class="row">
        <div class="col-lg-12">
          <div class="card-box">
            <h4 class="m-t-0 header-title"><b>Form Topup </b></h4>
                
            <form class="form-horizontal" role="form"  data-parsley-validate novalidate>
              <div class="form-group">
                <label for="amount" class="col-sm-4 control-label">UserName *</label>
                <div class="col-sm-4">
                	<!-- <input type="text" required class="form-control" id="userid"  ng-model="userid" placeholder="Please Enter Username"> -->
                	<select class="form-control required" name="user" 
						ng-change="getAllUsers()"
						ng-model="user_id" id="user_id" required 
						ng-options="u.user_id as u.user_name for u in user">
						<option value="" style="display:none">-- Choose UserName --</option>

					</select>
                </div>
              </div>
              
              <div class="form-group">
                <label for="inputEmail3" class="col-sm-4 control-label">Currency</label>
                <div class="col-sm-7" ng-init="curr='USD'">
                  <div class="radio radio-info radio-inline">
                    <input type="radio" id="currency1" value="USD" ng-model="curr" name="currency">
                    <label for="currency1">USD (Dollar) </label>
                  </div>
                  <div class="radio radio-inline">
                    <input type="radio" id="currency2" value="KHR"  ng-model="curr" name="currency">
                    <label for="currency2">KHR (Reil)</label>
                  </div>
                </div>
              </div>
              
              <div class="form-group">
                <label for="amount" class="col-sm-4 control-label">Amount *</label>
                <div class="col-sm-4">
                	<input type="number" required class="form-control" id="amount"  ng-model="balance" placeholder="Amount of money">
                </div>
              </div>
              <div class="form-group">
                <div class="col-sm-offset-4 col-sm-8">
                	<button type="submit" class="btn btn-primary waves-effect waves-light" 
                			ng-disabled="balance < 1 || !(!!balance)" ng-click="addTopUp()">
                		<i class="fa fa-plus" aria-hidden="true"></i> Topup
                	</button>
                	<button type="reset" class="btn btn-danger waves-effect waves-light m-l-5">
                		<i class="fa fa-times" aria-hidden="true"></i> Cancel
                	</button>
                </div>
              </div>
            </form>
          </div>
        </div>
      </div>

	 <!--  ================= TABLE SHOW USER CREDIT WITH ENGING AMOUNT ========================== -->
      <div class="row">
        <div class="col-sm-12">
          <div class="card-box">
            <h4 class="m-t-0 m-b-30 header-title"><b>View Enging Amount Of User</b></h4>
            <div class="row">
              <div class="col-sm-8">
                <form role="form">
                  <div class="form-group contact-search m-b-30">
                    <input type="text" id="search" class="form-control"
                      placeholder="Search..." ng-model="str_search">
                    <button type="submit" class="btn btn-white">
                      <i class="fa fa-search"></i>
                    </button>
                  </div>
                  <!-- form-group -->
                </form>
              </div>
            </div>

            <div class="table-responsive">
              <table class="table table-hover table-actions-bar">
                <thead>
                  <tr>
                    <th>Credit ID</th>
                    <th>Full Name</th>
                    <th>Credit Date</th>
                    <th>Beginning Amount</th>
                    <th>Transaction Type</th>
                    <th>Amount</th>
                    <th>Ending Amount</th>
                
                  </tr>
                </thead>
                <tbody class="body">
                  <tr ng-repeat="uea in userEndingAmount | filter:str_search | orderBy:'-credit_id'">
                    <td ng-cloak>{{uea.credit_id}}</td>
                    <td ng-cloak>{{uea.user.last_name + " " + uea.user.first_name}}</td>
                    <td ng-cloak>{{uea.credit_date}}</td>
                    <td ng-cloak>{{uea.beginning_amount}}</td>
                    <td ng-cloak>{{uea.transaction_type}}</td>
                    <td ng-cloak>{{uea.amount}}</td>
                    <td ng-cloak>{{uea.ending_amount}}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          	<!-- Pagination-->
			<div class="row">
				<div class="col-sm-6">
					<div class="dataTables_info" id="datatable-editable_info"
						role="status" aria-live="polite" ng-cloak>{{pages}} to {{totalpages}} pages of {{totalcount}}
						entries</div>
				</div>
				<div class="col-sm-6">
					<div id="PAGINATION" class="pull-right"></div>
				</div>
			</div>
			<!-- End Pagination-->
          </div>

        </div>
      </div>
    </div>
  </div>
</div>


<!-- footer -->
<jsp:include page="footer.jsp"></jsp:include>
<script src="${pageContext.request.contextPath}/resources/scripts/topup-angular.js"></script>
