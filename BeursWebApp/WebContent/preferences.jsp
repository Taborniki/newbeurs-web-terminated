<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- at compile time -->
<%@ include file="import.jsp" %>

<html>
	<!-- check for logged in user -->
	<!-- at compile time -->
	<%@ include file="login_checker.jsp" %>
	
	<!--  TODO form resubmission http://stackoverflow.com/questions/3923904/preventing-form-resubmission -->
	<% 	String loginStatus = (String) request.getSession().getAttribute("loginStatus");
		if(!loginStatus.equals("succeeded")){ %>
		<jsp:include page="login_form.jsp" >
		    <jsp:param name="loginStatus" value="${loginStatus}" />
		</jsp:include>
	<%} 
		else // logInStatus is succeeded
		{%>
		
		<!-- main content of page -->
		<head>
			<link rel="shortcut icon" href="images/oak_o_logo.ico">
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title>Preferences</title>
			<!-- TODO moet hier niet bij dat het javascript is? -->
			
		</head>
		<body>
			<!-- at runtime -->
			<jsp:include page="header.jsp" />
			
			<!-- at runtime TODO compile time van maken?  -->
			<jsp:include page="navigation.html" />
			
			userId = <%= request.getSession().getAttribute("loggedInUserId") %>
			<br>
			ip = <%=request.getRemoteAddr() %>
			<br>
			python path = <%=pythonPath %>
			<br>
			<br>
			Nothing else to see here pal, move on
			
			<!-- at runtime -->
			<jsp:include page="footer.jsp" />
		</body>
		
	<%} %>
</html>