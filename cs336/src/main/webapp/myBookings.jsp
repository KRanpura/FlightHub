<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings</title>
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
    <% String username = (String) session.getAttribute("user"); %>
        <h2>Bookings for <%=username %></h2>
        <a href="searchFlights.jsp">Search Flights</a>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>

    <%
        // Assuming you have a user_id attribute in the session
        int user_id = (int) session.getAttribute("user_id");

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");

            // Fetch ticket information for the logged-in user
            String ticketQuery = "SELECT * FROM ticket WHERE user_id = ?";
            try (PreparedStatement ticketStmt = con.prepareStatement(ticketQuery)) {
                ticketStmt.setInt(1, user_id);

                try (ResultSet ticketResult = ticketStmt.executeQuery()) {
                    while (ticketResult.next()) {
                        int ticketId = ticketResult.getInt("ticket_id");
                        float fare = ticketResult.getFloat("fare");
                        String ticketClass = ticketResult.getString("class");
                        Timestamp purchaseDateTime = ticketResult.getTimestamp("purchased");
                        float bookingFee = ticketResult.getFloat("booking_fee");

                        // Output ticket information here
                        %>
                        <div>
                            <h2>Ticket Information</h2>
                            <p>Ticket ID: <%= ticketId %></p>
                            <p>Fare: <%= fare %></p>
                            <p>Class: <%= ticketClass %></p>
                            <p>Purchase Date/Time: <%= purchaseDateTime %></p>
                            <p>Booking Fee: <%= bookingFee %></p>
                        </div>
                        <%
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>

</body>
</html>