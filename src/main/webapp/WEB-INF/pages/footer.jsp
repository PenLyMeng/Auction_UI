<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>		
		
		</div>
	</div>
	<!-- ================ Ending Content Section ================= -->

<!-- ================ Starting Footer Section ================= -->
	<footer>
		<div class="container">
			<div class="row">
				<div class="col-md-5">
					<img src="${pageContext.request.contextPath}/resources/static/images/denhtlai.png" class="img-responsive" style="width:80%">
					<p>&copy; <spring:message code="2016_privacy_policy"></spring:message></p>
				</div>
				<div class="col-md-5">
					<div class="container">
					    <!-- Collect the nav links, forms, and other content for toggling -->
					    <div class="navfooter">
					      <ul class="nav navbar-nav">
					       	<li class="active"><a href="${pageContext.request.contextPath}/index"><spring:message code="home"></spring:message></a></li>
<!-- 					        <li><a href="sell_first_step.html" class="lang" key="seller">Seller</a></li> -->
<%-- 					        <li><a href="#"><spring:message code="buyer"></spring:message></a></li> --%>
					        <li><a href="${pageContext.request.contextPath}/contactus"><spring:message code="contact_s"></spring:message></a></li>
					        <li><a href="${pageContext.request.contextPath}/aboutus"><spring:message code="about"></spring:message></a></li>
					      </ul>
					    </div><!-- /.navbar-collapse -->
					</div><!-- /.container -->
				</div>
				<div class="col-md-2 text-center facebook">
					<i class="fa fa-facebook-square fa-2x" aria-hidden="true" style="color: #5061c6;"></i>
					<i class="fa fa-twitter-square fa-2x" aria-hidden="true" style="color: #42ceec;"></i>
					<i class="fa fa-google-plus-square fa-2x" aria-hidden="true" style="color: #d73d32;"></i>
				</div>
			</div>
		</div>
	</footer>
	<!-- ================ Ending Footer Section ================= -->

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/static/js/jquery-2.1.3.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/static/js/bootstrap.min.js">
</script>
<script src="${pageContext.request.contextPath}/resources/static/js/moment.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/js/moment-with-locales.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/js/angular-moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/assets/plugins/bootstrap-inputmask/bootstrap-inputmask.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/static/assets/plugins/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/static/assets/plugins/dropzone/dist/dropzone.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function() {

		jQuery('#datepicker').datepicker();
	});
</script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/static/js/jquery.bootpag.min.js"></script>
</div>
</body>
</html>