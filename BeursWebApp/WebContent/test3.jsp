<!DOCTYPE html>
<html>
<head>
	<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
	
</head>
<body>
<form id="simulationForm" action="bestaatniet.jsp">
	<input name="datum" type="date">
	<input type="submit" id="dong" value="initiate simulation">
</form>
<script>
            /* attach a submit handler to the form */
            $("#simulationForm").submit(function(event) {

                /* stop form from submitting normally */
                event.preventDefault();

            });
</script>

</body>
</html>