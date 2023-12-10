<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modify Site Info</title>
    <style>
        body {
            padding: 20px;
            text-align: center;
        }

        nav {
            background-color: #333;
            overflow: hidden;
        }

        nav a {
            float: left;
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        nav a:hover {
            background-color: #ddd;
            color: black;
        }

        .form-container {
            display: grid;
            gap: 20px;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            margin-top: 20px; 
        }

        .form-container .form {
            border: 1px solid #ccc;
            padding: 20px;
            text-align: left;
        }

        .error-message {
            color: red;
        }
    </style>
</head>
<body>
	<nav>
		 <h2 style="color: white;">Modify Site Info</h2>
         <a href="homepage.jsp">Homepage</a>
         <a href="logout.jsp">Log out</a>
    </nav>
    <div class = "form-container">
	    <div class="form">
	        <h2>Modify Airport Info</h2>
	        <form action="handleModInfo.jsp" method="POST">
	            Airport ID: <input type="text" name="airport_id" required /> <br />
	            Airport name: <input type="text" name="airport_name" required/> <br />
	            <p>I would like to:</p>
	            <label>
	                <input type="radio" name="modPort" value="add" required/> Add Airport <br />
	            </label>
	            <label>
	                <input type="radio" name="modPort" value="remove" /> Remove Airport <br />
	            </label>
	            <label>
	                <input type="radio" name="modPort" value="update" /> Update Airport Name <br />
	            </label>
	            <p>
	                <input type="submit" name= "airport" value="Execute modification" /> <br />
	            </p>
	        </form>
	        <%
	        	String success0 = (String) request.getAttribute("successAirport");
	            String error0 = (String) request.getAttribute("errorAirport");
	            if (error0 != null && !error0.isEmpty()) {
	        %>
	            <div class="error-message">
	                <p><strong>Error:</strong> <%= error0 %></p>
	            </div>
	        <%
	            }
	            if (success0 != null && !success0.isEmpty()) {
	        %>
	        	<div class="success-message">
	                <p><strong>Success:</strong> <%= success0 %></p>
	            </div>
	        <%
	            }
	        %>
	    </div>
	
	    <div class="form">
	        <h2>Modify Airline Info</h2>
	        <form action="handleModInfo.jsp" method="POST">
	            Airline ID: <input type="text" name="airline_id" required/> <br />
	            Airline name: <input type="text" name="airline_name" required/> <br />
	            <p>I would like to:</p>
	            <label>
	                <input type="radio" name="modLine" value="add" required/> Add Airline<br />
	            </label>
	            <label>
	                <input type="radio" name="modLine" value="remove" /> Remove Airline <br />
	            </label>
	            <label>
	                <input type="radio" name="modLine" value="update" /> Update Airline Name <br />
	            </label>
	            <p>
	                <input type="submit" name = "airline" value="Execute modification" /> <br />
	            </p>
	        </form>
	        <%
	        	String success = (String) request.getAttribute("successAirline");
	            String error = (String) request.getAttribute("errorAirline");
	            if (error != null && !error.isEmpty()) {
	        %>
	            <div class="error-message">
	                <p><strong>Error:</strong> <%= error %></p>
	            </div>
	        <%
	            }
	            if (success != null && !success.isEmpty()) {
	        %>
	        	<div class="success-message">
	                <p><strong>Success:</strong> <%= success %></p>
	            </div>
	        <%
	            }
	        %>
	        
	    </div>
	
	    <div class="form">
	        <h2>Modify Aircraft Info</h2>
	        <form action="handleModInfo.jsp" method="POST">
	            Aircraft ID: <input type="text" name="aircraft_id" required/> <br />
	            Aircraft name: <input type="text" name="aircraft_name" required/> <br />
	            Airline ID: <input type="text" name="airline_id" required/> <br />
	            Capacity: <input type="text" name="capacity" /> <br />
	            
	            <p>I would like to:</p>
	            <label>
	                <input type="radio" name="modCraft" value="add" required/> Add Aircraft<br />
	            </label>
	            <label>
	                <input type="radio" name="modCraft" value="remove" /> Remove Aircraft <br />
	            </label>
	            <label>
	                <input type="radio" name="modCraft" value="update" /> Update Aircraft Info <br />
	            </label>
	            <p>
	                <input type="submit" name = "aircraft" value="Execute modification" /> <br />
	            </p>
	        </form>
	        <%
	        	String success2 = (String) request.getAttribute("successAircraft");
	            String error2 = (String) request.getAttribute("errorAircraft");
	            if (error2 != null && !error2.isEmpty()) {
	        %>
	            <div class="error-message">
	                <p><strong>Error:</strong> <%= error2 %></p>
	            </div>
	        <%
	            }
	            if (success2 != null && !success2.isEmpty()) {
	        %>
	        	<div class="success-message">
	                <p><strong>Success:</strong> <%= success2 %></p>
	            </div>
	        <%
	            }
	        %>
	    </div>
	    
	    <div class="form">
	    <h2>Modify Flight Info</h2>
	    <form action="handleModInfo.jsp" method="POST">
			Flight number: <input type="text" name="flight_num" required/> <br />
			Aircraft ID: <input type="text" name="craft_id" required/> <br />
			Airline ID: <input type="text" name="line_id" required/> <br />
			Departure Airport: <input type="text" name="dep_airport" required/> <br />
			Arrival Airport: <input type="text" name="arr_airport" required/> <br />
			Price: <input type="text" name="price" /> <br />
			Departure: <input type="datetime-local" name="dep_date" /> <br />
			Arrival: <input type="datetime-local" name="arr_date" /> <br />
			Domestic: 
			<label>
			    <input type="radio" name="is_domestic" value="Yes" required/> Yes
			</label>
			<label>
			    <input type="radio" name="is_domestic" value="No" /> No
			</label> <br />
	
	        <p>I would like to:</p>
	        <label>
	            <input type="radio" name="modFlight" value="add" required/> Add Flight<br />
	        </label>
	        <label>
	            <input type="radio" name="modFlight" value="remove" /> Remove Flight <br />
	        </label>
	        <label>
	            <input type="radio" name="modFlight" value="update" /> Update Flight Info <br />
	        </label>
	        <p>
	            <input type="submit" name = "flight" value="Execute modification" /> <br />
	        </p>
	    </form>
	        <%
	        	String success3 = (String) request.getAttribute("successFlight");
	            String error3 = (String) request.getAttribute("errorFlight");
	            if (error3 != null && !error3.isEmpty()) {
	        %>
	            <div class="error-message">
	                <p><strong>Error:</strong> <%= error %></p>
	            </div>
	        <%
	            }
	            if (success3 != null && !success3.isEmpty()) {
	        %>
	        	<div class="success-message">
	                <p><strong>Success:</strong> <%= success3 %></p>
	            </div>
	        <%
	            }
	        %>
	    </div>
	    
    </div>

</body>
</html>