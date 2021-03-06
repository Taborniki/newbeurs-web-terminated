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
			<title>Initiate simulation</title>
			<!-- vervangen door lokale jquery (er staat al één in WEB-INF -->
			<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
			<script>			
				function updateInfo()
				{
					var strategyId = document.getElementById("strategySelector").value-1;
					var infoToShow = strategyInfo[strategyId];
					document.getElementById("strategyInfoBox").value = infoToShow;
				}
			</script>
			<script>
				$(document).ready(function(){
				    $("#stockSelection").change(function(){				        
				        // ajax
				        var url = "num_stocks_in_filter.jsp";
		                
		                var dataToSend = $("#stockSelection").serialize();
		                
		                /* Send the data using post */
		                var posting = $.post(url, dataToSend);
		                
		                /* Put the results in a div */
		                posting.done(function(data) {
		                    $("#stockSelectionAjaxResult").empty().append(data);
		                });
				        
				    });
				});
			</script>
		</head>
		<body onload="updateInfo()">
			<!-- at runtime -->
			<jsp:include page="header.jsp" />
			
			<!-- at runtime TODO compile time van maken?  -->
			<jsp:include page="navigation.html" />
			
			<form action="launch_simulation.jsp" id="simulationForm" class="ng-pristine ng-valid">
				<div class="form-group">
					<p>
						<label for="simulationName">Simulation name</label>
						<input type="text" name="simulationName">
					</p>
					
					<p>
						<label for="simulationDescription">Description</label>
						<input type="text" name="description">
					</p>
					
					<!-- build up array containing strategy descriptions -->
					<script>
						<% 
							DatabaseInteraction dbInt = new DatabaseInteraction("backtest_real","webapp");
							QueryResult queryResult = dbInt.getAllTableEntries("strategy LEFT JOIN method ON strategy.method=method.id");
													
							// verbetering mogelijk
							// geklooi hieronder is omdat ik niet zeker ben dat bij for each over queryResult hij wel in volgorde van id overloopt	
								
							int numOfStrategies = queryResult.getNumOfEntries();
							String[] strategyDescriptions = new String[numOfStrategies];
							
							int index;
									
							for(HashMap<String,Object> strategy : queryResult)
							{
								// index is 1 minder dan id want index van array telt vanaf 0, id vanaf 1
								index = Integer.parseInt(strategy.get("id").toString())-1;
								strategyDescriptions[index] = strategy.get("description").toString();
							}
							
							// javascript array schrijven
							out.write("var strategyInfo = [");
							for(String description : strategyDescriptions)
							{
								out.write(String.format("\"%s\",",description));
							}
							// TODO laatste komma weghalen die na de laatste description wordt geprint
							out.write("];");
						%>
					</script>
					
					<p>
						<label for="strategy">Strategy</label>
						<select id="strategySelector" onchange="updateInfo()" name="strategyId">
						<% 	
							// queryResult object already created in above code between script tags
							queryResult = dbInt.getAllTableEntries("strategy");
								
							for(HashMap<String,Object> strategy : queryResult)
							{
								// <option value="first_script.py">first_script.py</option>
								out.write(String.format("<option value=\"%s\">%s</option>",strategy.get("id"),strategy.get("name")));	
							}
						%>
						</select>
					</p>	
					
					<p>
						<label for="strategyInfoBox">Strategy readme</label>
						<textarea id="strategyInfoBox" readonly></textarea>
					</p>
					
					<p>
						<label for="stockSelection">Stock selection</label>
						<input type="text" name="stockSelection" id="stockSelection">
						<a target="_blank" href="stock_category_list.jsp">(category list)</a>
						<div id="stockSelectionAjaxResult"></div>
					</p>
					
					<!-- TODO start date limiteren, niet te lang geleden -->
					
					<p>
						<label for="startDate">Start date</label>
						<input id="startDate" type="date" name="startDate">
					</p>
					
					<p>
						<label for="endDate">End date</label>
						<!-- dag van vandaag is de maximale simulatiedatum -->
						<input id="endDate" type="date" name="endDate" max="<%= (new java.text.SimpleDateFormat("yyyy-MM-dd")).format(new java.util.Date()) %>">
					</p>
					
					<p class="submit">			
						<input type="submit" class="btn btn-primary" value="initiate simulation">
					</p>
				</div>
			</form>
			<!-- jQuery for ajax post -->
			<!-- TODO oplossing zodat deze code wel in head kan is door document.ready te gebruiken -->
			<script>
	            /* attach a submit handler to the form */
	            $("#simulationForm").submit(function(event) {
	
	                /* stop form from submitting normally */
	                event.preventDefault();
	                
	                /* get some values from elements on the page: */
	                var $form = $(this);
	                var url = $form.attr('action');
	                
	                // serialize form: data -> string 
	                // vb: name=louis&age=21
	                var dataToSend = $form.serialize();
	                
	                /* Send the data using post */
	                var posting = $.post(url, dataToSend);
	                
	                /* Put the results in a div */
	                posting.done(function(data) {
	                    $("#ajaxResult").empty().append(data);
	                });
	            });
	        </script>
			<div id="ajaxResult"></div>
			<!-- at runtime -->
			<jsp:include page="footer.jsp" />
		</body>
		
	<%} %>
</html>