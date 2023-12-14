<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reservations For Selected Entity</title>
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

        .bookings-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around; /* Adjust as needed */
        }

        .ticket-container {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px;
            width: 300px; /* Adjust width as needed */
        }

        .cancel-btn {
            background-color: #f44336;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .success-message {
            color: green;
            font-weight: bold;
            margin-top: 10px;
        }

        .error-message {
            color: red;
            font-weight: bold;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <nav>
        <h2>Reservations For Selected Entity</h2>
        <a href="reservationsSelect.jsp">Select Reservation Type</a>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>

<%
String flight = request.getParameter("flight-number");
String firstname = request.getParameter("customer-first");
String lastname = request.getParameter("customer-last");

try {
    Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");

    // Prepare different SQL queries based on provided parameters
    String ticketQuery = "";
    PreparedStatement ticketStmt = null;

    if (flight != null) {
        ticketQuery = "SELECT * FROM ticket WHERE flight_num = ?";
        ticketStmt = con.prepareStatement(ticketQuery);
        ticketStmt.setInt(1, Integer.parseInt(flight));
    } else if (firstname != null && lastname != null) {
        ticketQuery = "SELECT * FROM ticket t JOIN user u ON t.user_id = u.id WHERE u.firstName = ? AND u.lastName = ?";
        ticketStmt = con.prepareStatement(ticketQuery);
        ticketStmt.setString(1, firstname);
        ticketStmt.setString(2, lastname);
    } else if (lastname.equals(null)) {
        ticketQuery = "SELECT * FROM ticket t JOIN user u ON t.user_id = u.id WHERE u.firstName = ?";
        ticketStmt = con.prepareStatement(ticketQuery);
        ticketStmt.setString(1, firstname);
    } else if (firstname.equals(null)) {
        ticketQuery = "SELECT * FROM ticket t JOIN user u ON t.user_id = u.id WHERE u.lastName = ?";
        ticketStmt = con.prepareStatement(ticketQuery);
        ticketStmt.setString(1, lastname);
    }

    // Execute the prepared statement and retrieve the result set
    try (ResultSet resultSet = ticketStmt.executeQuery()) {
%>
    <!-- Output ticket, flight, and user information within a table with boxed entries -->
    <style>
        /* CSS styles for boxed table entries */
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        th {
            padding-top: 12px;
            padding-bottom: 12px;
            text-align: left;
            background-color: #333;
            color: white;
        }
    </style>
    <table>
        <thead>
            <tr>
                <th>Ticket ID</th>
                <th>User ID</th>
                <th>Fare ID</th>
                <th>Class</th>
                <th>Purchase Date</th>
                <th>Booking Fee</th>
                <th>Flight Number</th>
            </tr>
        </thead>
        <tbody>
<%
    while (resultSet.next()) {
%>
            <tr>
                <td><div class="boxed-entry"><%= resultSet.getInt("ticket_id") %></div></td>
                <td><div class="boxed-entry"><%= resultSet.getInt("user_id") %></div></td>
                <td><div class="boxed-entry"><%= resultSet.getString("fare") %></div></td>
                <td><div class="boxed-entry"><%= resultSet.getString("class") %></div></td>
                <td><div class="boxed-entry"><%= resultSet.getTimestamp("purchased") %></div></td>
                <td><div class="boxed-entry"><%= resultSet.getFloat("booking_fee") %></div></td>
                <td><div class="boxed-entry"><%= resultSet.getInt("flight_num") %></div></td>
            </tr>
<%
    }
%>
        </tbody>
    </table>
<%
    }
} catch (SQLException e) {
    e.printStackTrace();
}
%>

</body>
</html>