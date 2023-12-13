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
        <% String username = (String) session.getAttribute("user"); %>
        <h2>Bookings for <%=username %></h2>
        <a href="searchFlights.jsp">Search Flights</a>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>

    <div class="bookings-container">
        <%
            int user_id = (int) session.getAttribute("user_id");
            String successParam = request.getParameter("success");
            String reasonParam = request.getParameter("reason");
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");

                // Fetch ticket information for the logged-in user
                String ticketQuery = "SELECT * FROM ticket WHERE user_id = ?";
                try (PreparedStatement ticketStmt = con.prepareStatement(ticketQuery)) {
                    ticketStmt.setInt(1, user_id);

                    try (ResultSet ticketResult = ticketStmt.executeQuery()) {
                        while (ticketResult.next()) {
                            int ticketId = ticketResult.getInt("ticket_id");
                            int flight_num = ticketResult.getInt("flight_num");
                            float fare = ticketResult.getFloat("fare");
                            String ticketClass = ticketResult.getString("class");
                            Timestamp purchaseDateTime = ticketResult.getTimestamp("purchased");
                            float bookingFee = ticketResult.getFloat("booking_fee");

                            // Fetch flight information for the corresponding flight_num
                            String flightInfoQuery = "SELECT * FROM flight WHERE flight_number = ?";
                            try (PreparedStatement flightStmt = con.prepareStatement(flightInfoQuery)) {
                                flightStmt.setInt(1, flight_num);
                                try (ResultSet flightResult = flightStmt.executeQuery()) {
                                    if (flightResult.next()) {
                                        String departureAirport = flightResult.getString("departure_airport_id");
                                        String arrivalAirport = flightResult.getString("arrival_airport_id");
                                        Timestamp departureDateTime = flightResult.getTimestamp("departure_date_time");
                                        Timestamp arrivalDateTime = flightResult.getTimestamp("arrival_date_time");

                                        // Fetch user information for the logged-in user
                                        String userQuery = "SELECT * FROM user WHERE id = ?";
                                        try (PreparedStatement userStmt = con.prepareStatement(userQuery)) {
                                            userStmt.setInt(1, user_id);
                                            try (ResultSet userResult = userStmt.executeQuery()) {
                                                if (userResult.next()) {
                                                    String firstName = userResult.getString("firstName");
                                                    String lastName = userResult.getString("lastName");

                                                    // Output ticket, flight, and user information within a form container
                                                    %>
                                                    <div class="ticket-container">
                                                        <form action="cancelBooking.jsp" method="POST">
                                                            <h2>Ticket Information</h2>
                                                            <p>Ticket ID: <%= ticketId %></p>
                                                            <p>Flight number: <%= flight_num %></p>
                                                            <p>Fare: <%= fare %></p>
                                                            <p>Class: <%= ticketClass %></p>
                                                            <p>Purchase Date/Time: <%= purchaseDateTime %></p>
                                                            <p>Booking Fee: <%= bookingFee %></p>

                                                            <h2>Flight Information</h2>
                                                            <p>Departure Airport: <%= departureAirport %></p>
                                                            <p>Arrival Airport: <%= arrivalAirport %></p>
                                                            <p>Departure Date/Time: <%= departureDateTime %></p>
                                                            <p>Arrival Date/Time: <%= arrivalDateTime %></p>

                                                            <h2>User Information</h2>
                                                            <p>First Name: <%= firstName %></p>
                                                            <p>Last Name: <%= lastName %></p>

                                                            <input type="hidden" name="ticket_id" value="<%= ticketId %>">
                                                            <input type="submit" class="cancel-btn" value="Cancel Booking">
                                                        </form>
                                                    </div>
                                                    <%
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </div>

    <%
        // Check for success or error messages in URL parameters
        if (successParam != null && reasonParam != null) {
            boolean success = Boolean.parseBoolean(successParam);
            String message = "";
            if (success) {
                message = "Booking canceled successfully!";
            } else {
                if ("incorrectClass".equals(reasonParam)) {
                    message = "Error: Booking couldn't be canceled. Class is not 'bus' or 'first'.";
                } else if ("incorrectInfo".equals(reasonParam)) {
                    message = "Error: Booking couldn't be canceled. Incorrect information.";
                }
            }
    %>
        <div class="<%= success ? "success-message" : "error-message" %>">
            <%= message %>
        </div>
    <%
        }
    %>

</body>
</html>