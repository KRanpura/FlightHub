<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Flight</title>
</head>
<body>
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
                    <h2>Booking Detials for Flight Number: <%= flightNumber %></h2>
                    <p>Aircraft ID: <%= resultSet.getInt("aircraft_id") %></p>
                    <p>Airline ID: <%= resultSet.getString("airline_id") %></p>
                    <p>Departure Airport: <%= resultSet.getString("departure_airport_id") %></p>
                    <p>Arrival Airport: <%= resultSet.getString("arrival_airport_id") %></p>
                    <p>Price: <%= resultSet.getFloat("price") %></p>
                    <p>Departure Date/Time: <%= resultSet.getTimestamp("departure_date_time") %></p>
                    <p>Arrival Date/Time: <%= resultSet.getTimestamp("arrival_date_time") %></p>
                    <p>Is Domestic: <%= resultSet.getBoolean("is_domestic") %></p>

                    <form action="reserveFlight.jsp" method="POST">                                                            //  reserveFlight.jsp form 
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
