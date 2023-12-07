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
	            Airport ID: <input type="text" name="airport_id" /> <br />
	            Airport name: <input type="text" name="airport_name" /> <br />
	            <p>I would like to:</p>
	            <label>
	                <input type="radio" name="mod" value="add" /> Add Airport <br />
	            </label>
	            <label>
	                <input type="radio" name="mod" value="remove" /> Remove Airport <br />
	            </label>
	            <label>
	                <input type="radio" name="mod" value="update" /> Update Airport Name <br />
	            </label>
	            <p>
	                <input type="submit" value="Execute modification" /> <br />
	            </p>
	        </form>
	        <%
	            String errorMessage = (String) request.getAttribute("modErrorMessage");
	            if (errorMessage != null && !errorMessage.isEmpty()) {
	        %>
	            <div class="error-message">
	                <p><strong>Error:</strong> <%= errorMessage %></p>
	            </div>
	        <%
	            }
	        %>
	    </div>
	
	    <div class="form">
	        <h2>Modify Airline Info</h2>
	        <form action="handleModInfo.jsp" method="POST">
	            Airline ID: <input type="text" name="airline_id" /> <br />
	            Airline name: <input type="text" name="airline_name" /> <br />
	            <p>I would like to:</p>
	            <label>
	                <input type="radio" name="mod" value="add" /> Add Airline<br />
	            </label>
	            <label>
	                <input type="radio" name="mod" value="remove" /> Remove Airline <br />
	            </label>
	            <label>
	                <input type="radio" name="mod" value="update" /> Update Airline Name <br />
	            </label>
	            <p>
	                <input type="submit" value="Execute modification" /> <br />
	            </p>
	        </form>
	        <%
	            String error = (String) request.getAttribute("modErrorMessage");
	            if (error != null && !error.isEmpty()) {
	        %>
	            <div class="error-message">
	                <p><strong>Error:</strong> <%= error %></p>
	            </div>
	        <%
	            }
	        %>
	    </div>
	
	    <div class="form">
	        <h2>Modify Aircraft Info</h2>
	        <form action="handleModInfo.jsp" method="POST">
	            Aircraft ID: <input type="text" name="aircraft_id" /> <br />
	            Aircraft name: <input type="text" name="aircraft_name" /> <br />
	            Airline ID: <input type="text" name="airline_id" /> <br />
	            Capacity: <input type="text" name="capacity" /> <br />
	            
	            <p>I would like to:</p>
	            <label>
	                <input type="radio" name="mod" value="add" /> Add Aircraft<br />
	            </label>
	            <label>
	                <input type="radio" name="mod" value="remove" /> Remove Aircraft <br />
	            </label>
	            <label>
	                <input type="radio" name="mod" value="update" /> Update Aircraft Info <br />
	            </label>
	            <p>
	                <input type="submit" value="Execute modification" /> <br />
	            </p>
	        </form>
	        <%
	            String err = (String) request.getAttribute("modErrorMessage");
	            if (err != null && !err.isEmpty()) {
	        %>
	            <div class="error-message">
	                <p><strong>Error:</strong> <%= err %></p>
	            </div>
	        <%
	            }
	        %>
	    </div>
	    
	    <div class="form">
	    <h2>Modify Flight Info</h2>
	    <form action="handleModInfo.jsp" method="POST">
			Flight number: <input type="text" name="flight_num" /> <br />
			Aircraft ID: <input type="text" name="craft_id" /> <br />
			Airline ID: <input type="text" name="line_id" /> <br />
			Departure Airport: <input type="text" name="dep_airport" /> <br />
			Arrival Airport: <input type="text" name="arr_airport" /> <br />
			Price: <input type="text" name="price" /> <br />
			Departure Date: <input type="datetime-local" name="dep_date" /> <br />
			Arrival Date: <input type="datetime-local" name="arr_date" /> <br />
			Domestic: 
			<label>
			    <input type="radio" name="is_domestic" value="Yes" /> Yes
			</label>
			<label>
			    <input type="radio" name="is_domestic" value="No" /> No
			</label> <br />
	
	        <p>I would like to:</p>
	        <label>
	            <input type="radio" name="mod" value="add" /> Add Flight<br />
	        </label>
	        <label>
	            <input type="radio" name="mod" value="remove" /> Remove Flight <br />
	        </label>
	        <label>
	            <input type="radio" name="mod" value="update" /> Update Flight Info <br />
	        </label>
	        <p>
	            <input type="submit" value="Execute modification" /> <br />
	        </p>
	    </form>
	    <%
	        String e = (String) request.getAttribute("modErrorMessage");
	        if (e != null && !e.isEmpty()) {
	    %>
	        <div class="error-message">
	            <p><strong>Error:</strong> <%= e %></p>
	        </div>
	    <%
	        }
	    %>
	    </div>
	    
    </div>

</body>
</html>