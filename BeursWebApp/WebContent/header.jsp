<div class="container ng-scope" ng-view="">
	<div class="alert alert-info">
		Welcome, user <strong><%= request.getSession().getAttribute("loggedInUserName") %></strong>
		<!-- [userId=<%= request.getSession().getAttribute("loggedInUserId") %>]-->
	</div>

<!-- /div staat in footer -->