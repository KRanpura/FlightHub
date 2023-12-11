<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Available Flights</title>
</head>
<body>

<%
    // Establish a database connection
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");

        String dep = request.getParameter("departing-airport");
        String arr = request.getParameter("arriving-airport");
        String flexibility = request.getParameter("flexibility");

        // Get date-time parameters from the request and convert them to Timestamp objects
        String depDateTimeStr = request.getParameter("departure-date-time");
        String arrDateTimeStr = request.getParameter("arrival-date-time");
        Timestamp depDateTime = Timestamp.valueOf(depDateTimeStr);
        Timestamp arrDateTime = Timestamp.valueOf(arrDateTimeStr);

        // Fix the SQL query syntax and use placeholders for parameters
        String query = "SELECT * FROM flight WHERE departure_airport_id = ? AND arrival_airport_id = ? " +
                       "AND departure_date_time >= ? AND arrival_date_time <= ?";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, dep);
            pstmt.setString(2, arr);
            pstmt.setTimestamp(3, depDateTime);
            pstmt.setTimestamp(4, arrDateTime);

            try (ResultSet resultSet = pstmt.executeQuery()) {
                // Display flights in a table
%>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Flight Number</th>
                            <th>Aircraft ID</th>
                            <th>Airline ID</th>
                            <th>Departure Airport</th>
                            <th>Arrival Airport</th>
                            <th>Price</th>
                            <th>Departure Date/Time</th>
                            <th>Arrival Date/Time</th>
                            <th>Is Domestic</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
<%
                while (resultSet.next()) {
                    // Iterate over the result set and display flights in a table
%>
                    <tr>
                        <td><%= resultSet.getInt("flight_number") %></td>
                        <td><%= resultSet.getInt("aircraft_id") %></td>
                        <td><%= resultSet.getString("airline_id") %></td>
                        <td><%= resultSet.getString("departure_airport_id") %></td>
                        <td><%= resultSet.getString("arrival_airport_id") %></td>
                        <td><%= resultSet.getFloat("price") %></td>
                        <td><%= resultSet.getTimestamp("departure_date_time") %></td>
                        <td><%= resultSet.getTimestamp("arrival_date_time") %></td>
                        <td><%= resultSet.getBoolean("is_domestic") %></td>
                        <td><a href="bookFlight.jsp?flight_number=<%= resultSet.getInt("flight_number") %>">Book</a></td>
                    </tr>
<%
                }
%>
                    </tbody>
                </table>
<%
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

</body>
</html>