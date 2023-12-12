<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Flight</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        nav {
            background-color: #333;
            overflow: hidden;
            color: white;
            text-align: center;
            padding: 10px;
            width: 100%;
        }

        nav a {
            color: #f2f2f2;
            text-decoration: none;
            padding: 14px 16px;
            display: inline-block;
        }

        nav a:hover {
            background-color: #ddd;
            color: black;
        }
    </style>
</head>
<body>

	<nav>
	    <h2>Confirm Flight Booking</h2>
	    <a href= "searchFlights.jsp">Return to Search Flights</a>
	    <a href="homepage.jsp">Homepage</a>
	    <a href="logout.jsp">Log out</a>
	</nav>
<%
    int flightNumber = Integer.parseInt(request.getParameter("flight_number"));                                                // Extract flightNumber parameter from request
    
    try {                                                                                                                      // Establish a database connection
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");
   
        String query = "SELECT * FROM flight WHERE flight_number = ?";                                                         // SQL query retreice flight info using flightNumber 
        try (PreparedStatement pstmt = con.prepareStatement(query)){
            pstmt.setInt(1, flightNumber);
            try (ResultSet resultSet = pstmt.executeQuery()){
                if (resultSet.next()) {                                                                                        // display booking details
%>
                    <h2>Booking Details for Flight Number: <%= flightNumber %></h2>
                    <p>Aircraft ID: <%= resultSet.getInt("aircraft_id") %></p>
                    <p>Airline ID: <%= resultSet.getString("airline_id") %></p>
                    <p>Departure Airport: <%= resultSet.getString("departure_airport_id") %></p>
                    <p>Arrival Airport: <%= resultSet.getString("arrival_airport_id") %></p>
                    <p>Price: <%= resultSet.getFloat("price") %></p>
                    <p>Departure Date/Time: <%= resultSet.getTimestamp("departure_date_time") %></p>
                    <p>Arrival Date/Time: <%= resultSet.getTimestamp("arrival_date_time") %></p>
                    <p>Is Domestic: <%= resultSet.getBoolean("is_domestic") %></p>

                    <form action="reserveFlight.jsp" method="POST">                                                             
                        <input type="hidden" name="flight_number" value="<%= flightNumber %>">
                        <input type="submit" value="Confirm Booking">
                    </form>
<%
                }
            }
        }
    }
    catch (SQLException e){
        e.printStackTrace();
    }
%>
</body>
</html>
