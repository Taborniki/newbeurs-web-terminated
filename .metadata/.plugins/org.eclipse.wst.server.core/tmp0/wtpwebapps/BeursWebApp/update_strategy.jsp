<%@page import="supportClasses.OakDatabaseException"%>
<%@ include file="import.jsp" %>
<%
	// TODO lijn hieronder weggedaan, waarom zou je 5 seconden moeten sleepen? 
	// try{Thread.sleep(5000);}catch(Exception e){}
	String strategyId = request.getParameter("id");
	String isActive = request.getParameter("isActive");
	String parameters = request.getParameter("parameters");
	
	// in de sql server aanpassen
	DatabaseInteraction dbInt = new DatabaseInteraction("backtest_real","webapp");
	
	try
	{
		if(isActive == null)
		{
			// update de parameters
			String userId = request.getSession().getAttribute("loggedInUserId").toString();
			dbInt.setNewParameters(strategyId, userId, parameters);
		}
		else // parameters == null
		{
			// update isActive
			dbInt.setIsActive(strategyId, isActive);
		}
		
		out.write("Changes saved");
	}
	catch(OakDatabaseException e) // parameters waren al up to date
	{
		// niets out.writen
	}
	
	
	
%>