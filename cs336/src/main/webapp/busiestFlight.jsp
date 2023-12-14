<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Flights With Most Tickets Sold</title>
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
    <h2>Flights With Most Tickets Sold</h2>
    <a href="homepage.jsp">Homepage</a>
    <a href="logout.jsp">Log out</a>
</nav>

<%
try {
    Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");

    String query = "SELECT f.flight_number, f.aircraft_id, f.airline_id, f.departure_airport_id, " +
                   "f.arrival_airport_id, f.price, f.departure_date_time, f.arrival_date_time " +
                   "FROM flight f " +
                   "JOIN (" +
                   "   SELECT flight_num, COUNT(*) AS ticket_count " +
                   "   FROM ticket " +
                   "   GROUP BY flight_num " +
                   "   ORDER BY COUNT(*) DESC " +
                   "   LIMIT 5 " +
                   ") t ON f.flight_number = t.flight_num";

    try (PreparedStatement pstmt = con.prepareStatement(query)) {
        try (ResultSet resultSet = pstmt.executeQuery()) {
%>
            <table>
                <thead>
                    <tr>
                        <th>Flight Number</th>
                        <th>Aircraft ID</th>
                        <th>Airline ID</th>
                        <th>Departure Airport ID</th>
                        <th>Arrival Airport ID</th>
                        <th>Price</th>
                        <th>Departure Date/Time</th>
                        <th>Arrival Date/Time</th>
                    </tr>
                </thead>
                <tbody>
<%
            while (resultSet.next()) {
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