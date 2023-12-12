<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Available Flights</title>
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

        table {
            margin-top: 20px;
            border-collapse: collapse;
            width: 80%;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #333;
            color: white;
        }
    </style>
</head>
<body>

<nav>
    <h2>Available Flights</h2>
    <a href= "searchFlights.jsp">Return to Search Flights</a>
    <a href="homepage.jsp">Homepage</a>
    <a href="logout.jsp">Log out</a>
</nav>

<%
    // Establish a database connection
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");

        String dep = request.getParameter("departing-airport");
        String arr = request.getParameter("arriving-airport");
        String flexibility = request.getParameter("flexibility");

        // Get date parameters from the request and convert them to Date objects
        String depDateStr = request.getParameter("departing-date");
        String arrDateStr = request.getParameter("arrival-date");
        Date depDate = Date.valueOf(depDateStr);
        Date arrDate = Date.valueOf(arrDateStr);

        // Fix the SQL query syntax and use placeholders for parameters
        String query;
        if ("flexible".equals(flexibility)) {
            // If flexibility is selected, adjust the query to allow a range of dates
            query = "SELECT * FROM flight WHERE departure_airport_id = ? AND arrival_airport_id = ? " +
                    "AND DATE(departure_date_time) >= ? - INTERVAL 3 DAY AND DATE(arrival_date_time) <= ? + INTERVAL 3 DAY";
        } else {
            // If exact dates are selected, use the original query
            query = "SELECT * FROM flight WHERE departure_airport_id = ? AND arrival_airport_id = ? " +
                    "AND DATE(departure_date_time) >= ? AND DATE(arrival_date_time) <= ?";
        }
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, dep);
            pstmt.setString(2, arr);
            pstmt.setDate(3, depDate);
            pstmt.setDate(4, arrDate);

            try (ResultSet resultSet = pstmt.executeQuery()) {
                // Display flights in a table
%>
                <table>
                    <thead>
                        <tr>
                            <th>Flight Number</th>
                            <th>Airline ID</th>
                            <th>Departure Airport</th>
                            <th>Arrival Airport</th>
                            <th>Price</th>
                            <th>Departure Date/Time</th>
                            <th>Arrival Date/Time</th>
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
                        <td><%= resultSet.getString("airline_id") %></td>
                        <td><%= resultSet.getString("departure_airport_id") %></td>
                        <td><%= resultSet.getString("arrival_airport_id") %></td>
                        <td><%= resultSet.getFloat("price") %></td>
                        <td><%= resultSet.getTimestamp("departure_date_time") %></td>
                        <td><%= resultSet.getTimestamp("arrival_date_time") %></td>
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