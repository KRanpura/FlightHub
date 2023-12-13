<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Revenue From Selected Source</title>
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
    <h2>Revenue From Selected Source</h2>
    <a href= "flightAirlineCustomerSelect.jsp">Return to Select Revenue Source</a>
    <a href="homepage.jsp">Homepage</a>
    <a href="logout.jsp">Log out</a>
</nav>

<%
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");

        String flight = request.getParameter("flight-number");
        String airline = request.getParameter("airline-id");
        String customer = request.getParameter("customer-id");

        String query;
        if (flight != null) {
            query = "SELECT SUM(booking_fee) AS total_booking_fee FROM ticket WHERE flight_num = ?";
        } else if (airline != null) {
            // Ensure that the join condition is correctly specified in your query
            query = "SELECT SUM(booking_fee) AS total_booking_fee FROM ticket LEFT JOIN flight ON ticket.flight_num = flight.flight_number WHERE airline_id = ?";
        } else {
            query = "SELECT SUM(booking_fee) AS total_booking_fee FROM ticket WHERE user_id = ?";
        }

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            if (flight != null) {
                pstmt.setString(1, flight);
            } else if (airline != null) {
                pstmt.setString(1, airline);
            } else {
                pstmt.setString(1, customer);
            }

            try (ResultSet resultSet = pstmt.executeQuery()) {
%>
                <table>
                    <thead>
                        <tr>
                            <th>Total Revenue</th>
                        </tr>
                    </thead>
                    <tbody>
<%
                while (resultSet.next()) {
%>
                    <tr>
                        <td><%= resultSet.getFloat("total_booking_fee") %></td>
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