<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="supportClasses.DatabaseInteraction" %>
<html>
  
  <body>
	<%
		DatabaseInteraction dbInteract = new DatabaseInteraction();
	
		ArrayList<HashMap<String,Object>> queryResult = dbInteract.executeQuery("SELECT * FROM users");
		
		for(HashMap<String,Object> row:queryResult)
		{
			for(String key:row.keySet())
			{
				out.write(key + " " + row.get(key) + "<br>");
			}
			out.write("------------------------------------------");
		}
	%>
  </body>
</html>