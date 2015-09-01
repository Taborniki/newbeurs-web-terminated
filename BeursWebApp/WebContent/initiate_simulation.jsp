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
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title>Adjust title!</title>
		</head>
		<body>
			<!-- at runtime -->
			<jsp:include page="header.jsp" />
			
			<!-- at runtime TODO compile time van maken?  -->
			<jsp:include page="navigation.html" />
			
			
			<form>
				<p>
					<label for="simulationName">Simulation name</label>
					<input type="text" name="simulationName">
				</p>
				
				<p>
					<label for="description">Description</label>
					<input type="text" name="description">
				</p>
				
				<script>
					// NEED met jsp een array stockeren in javascript die dan geraadpleegd wordt bij updateInfo() functie
				</script>
				
				<p>
					<label for="strategy">Script</label>
					<select id="strategy" onchange="updateInfo()" name="strategy">
					<% 	
						// NEED root vervangen door webapp
						DatabaseInteraction dbInt = new DatabaseInteraction("backtest_real","root");
						QueryResult queryResult = dbInt.getAllTableEntries("strategy");
							
						for(HashMap<String,Object> strategy : queryResult)
						{
							// <option value="first_script.py">first_script.py</option>
							out.write(String.format("<option value=\"%s\">%s</option>",strategy.get("id"),strategy.get("name")));	
						}
					%>
					</select>
				</p>	
			</form>
		</body>
		
	<%} %>
</html>