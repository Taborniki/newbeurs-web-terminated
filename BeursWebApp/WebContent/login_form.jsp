<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Oak login</title>
</head>
<body>
	<% out.write(request.getParameter("loginStatus")); %>
	<form action="." method="POST">
		<input type="hidden" name="postOrigin" value="login_form">
		<p>
			<label for="account">Account</label> <input type="text"
				name="account">
		</p>
	
		<p>
			<label for="password">Password</label> <input type="password"
				name="password">
		</p>
	
		<p class="submit">
			<input type="submit" value="Go">
		</p>
	</form>
</body>

