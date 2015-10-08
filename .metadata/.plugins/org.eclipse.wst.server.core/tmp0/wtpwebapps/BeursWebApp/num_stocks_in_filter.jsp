<%@page import="java.util.HashMap"%>
<%@ include file="import.jsp" %>
<%
	String filter = request.getParameter("stockSelection").toString();
	DatabaseInteraction dbInt = new DatabaseInteraction("backtest_real");
	try
	{
		int numSatisfy = dbInt.getNumSatisfyFilter(filter);
		
		if(numSatisfy == 0)
		{
			out.write("<div class=\"text-danger\">0 matches found</div>");
		}
		else
		{
			out.write(numSatisfy + " matches found");
		}
	}
	catch(Exception exception) // invalid query
	{
		out.write("<div class=\"text-danger\">invalid query</div>");
	}
	
	
	
%>