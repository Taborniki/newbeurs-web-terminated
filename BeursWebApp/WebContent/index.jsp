<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<html>
  
  <body>
	<%
		// The JDBC Connector Class.
		String dbClassName = "com.mysql.jdbc.Driver";

		// Connection string. emotherearth is the database the program
		// is connecting to. You can include user and password after this
		// by adding (say) ?user=paulr&password=paulr. Not recommended!

		String CONNECTION = "jdbc:mysql://127.0.0.1/oakTest";

		// Class.forName(xxx) loads the jdbc classes and
		// creates a drivermanager class factory
		Class.forName(dbClassName);
		Connection c = java.sql.DriverManager.getConnection(CONNECTION,"root","lnrddvnc");

		Statement stmt = null;
		
		String query = "SHOW TABLES";
		
		stmt = c.createStatement();
        ResultSet rs = stmt.executeQuery(query);
        		
        while (rs.next())
        {
        	out.write(rs.getString(1));
        	out.write("<br>");
        }
        
        
		c.close();
		
		DatabaseInteraction db = new DatabaseInteraction();
		out.write(db.getStr());
		
	%>
  </body>
</html>