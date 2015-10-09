<%@page import="java.io.InputStream"%>
<%@ include file="../import.jsp" %>
<div class="container ng-scope" ng-view="">
<%
	// NEED deze file beveiligen met paswoord = anti hacker
	String relativeFilePath = request.getParameter("relativeFilePath");
	String filePath = pythonPath + relativeFilePath;
%>
<h1 class="ng-scope">File: <%= filePath %></h1>
<%
	try
	{
		BufferedReader br = new BufferedReader(new FileReader(filePath));
		String line = null;
		while ((line = br.readLine()) != null) 
		{
		 	out.write(line);
		 	out.write("<br>");
		}
		br.close();	
	}
	catch(Exception e)
	{
		out.write("<div class=\"text-danger\">There doesn't seem to be a file here...</div>");
	}
	
%>
</div>