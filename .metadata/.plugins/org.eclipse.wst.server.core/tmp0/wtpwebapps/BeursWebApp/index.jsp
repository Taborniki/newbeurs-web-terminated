<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- at compile time -->
<%@ include file="import.jsp" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
			
			<table>
			
				<!-- table header -->
				<tr>
					<th>id</th>
					<th>name</th>
					<th>strategy</th>
					<th>date started</th>
					<th>owner</th>
					<th>status</th>
					<th>running time</th>
				</tr>
			
				<%
					// data ophalen
					DatabaseInteraction dbInt = new DatabaseInteraction("backtest_real","webapp");
					String query = "SELECT STG.name as strategyName, SIM.id as simId, SIM.name as simName, SIM.description, SIM.timestampStart, SIM.timestampEnd, USR.name as owner, SIM.status, SIM.PID ";
					query += "FROM strategy STG ";
					query += "JOIN simulation SIM ON STG.id = SIM.strategy ";
					query += "JOIN user USR ON USR.id = SIM.owner ";
					QueryResult queryResult = dbInt.executeQuery(query);
					
					// iterate over all entries
					for(HashMap<String,Object> simulation : queryResult)
					{
						out.write("<tr>");
						
							// simulation id
							out.write("<td>");
							out.write(simulation.get("simId").toString());
							out.write("</td>");
							
							// simulation name
							out.write("<td>");
							out.write(simulation.get("simName").toString());
							out.write("</td>");
							
							// TODO description
							
							// strategy name
							out.write("<td>");
							out.write(simulation.get("strategyName").toString());
							out.write("</td>");
							
							// start date 
							out.write("<td>");
							out.write(simulation.get("timestampStart").toString().substring(0,10));
							out.write("</td>");
							
							// owner
							out.write("<td>");
							out.write(simulation.get("owner").toString());
							out.write("</td>");
							
							// status
							// TODO kleuren aanpassen
							out.write("<td>");
							String status = simulation.get("status").toString();
							out.write(status);
							if(status.equals("running"))
							{
								out.write(String.format("<a href=\"killSimulation.jsp?simId=%s\">(stop)</a>",simulation.get("simId").toString()));
							}
							out.write("</td>");
							// running time
							
							// calculate difference in time between start and end time
							// TODO * ipv 0? 
							DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.'0'", Locale.ENGLISH);
							java.util.Date startDate = format.parse(simulation.get("timestampStart").toString());
							java.util.Date endDate;
							if(simulation.get("timestampEnd") != null)
							{
								endDate = format.parse(simulation.get("timestampEnd").toString());
							}
							else
							{
								endDate = startDate;
							}
							
							// gettime() is milliseconden
							long diff = endDate.getTime() - startDate.getTime();
							long diffSeconds = diff / 1000 % 60;  
							long diffMinutes = diff / (60 * 1000) % 60; 
							long diffHours = diff / (60 * 60 * 1000) % 60;
							
							out.write("<td>");
							if(diffHours != 0)
							{
								out.write(diffHours + " h ");
							}
							if(diffMinutes != 0)
							{
								out.write(diffMinutes + " m ");
							}
							if(diffSeconds != 0)
							{
								out.write(diffSeconds + " s ");
							}
							out.write("</td>");
							
							// NEED raw en clean output
							
						out.write("</tr>");
					}
				%> 
			</table>
			
		</body>
		
	<%} %>
</html>