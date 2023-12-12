<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*" %>

<%! 
    // Function to retrieve user reservations from the database
    public List<Map<String, String>> getReservations(int userId) {
        List<Map<String, String>> reservations = new ArrayList<>();
        
        try {
            // Establish the database connection
            try (Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411")) {
            	String query = "SELECT t.id AS ticket_id, f.flight_number, d.name AS departure_airport, " +
                        "f.departure_date_time, a.name AS arrival_airport, " +
                        "f.arrival_date_time, ti.purchase_date_time " +
                        "FROM Ticket t " +
                        "JOIN TicketForFlight tf ON t.id = tf.ticket_id " +
                        "JOIN Flight f ON tf.flight_number = f.flight_number " +
                        "JOIN Airport d ON f.departure_airport = d.id " +
                        "JOIN Airport a ON f.arrival_airport = a.id " +
                        "JOIN Ticket ti ON t.id = ti.id " +
                        "WHERE t.user_id = ?";
                // Create a PreparedStatement
                try (PreparedStatement stmt = con.prepareStatement(query)){
                    stmt.setInt(1, userId);
                    try (ResultSet result = stmt.executeQuery()){
                        // Process the ResultSet
                        while (result.next()){
                            Map<String, String> reservation = new HashMap<>();
                            reservation.put("ticket_id", String.valueOf(result.getInt("ticket_id")));
                            reservation.put("flight_number", String.valueOf(result.getInt("flight_number")));
                            reservation.put("departure_airport", result.getString("departure_airport"));
                            reservation.put("departure_date_time", result.getString("departure_date_time"));
                            reservation.put("arrival_airport", result.getString("arrival_airport"));
                            reservation.put("arrival_date_time", result.getString("arrival_date_time"));
                            reservation.put("purchase_date_time", result.getString("purchase_date_time"));
                            reservations.add(reservation);
                        }
                    }
                }
            }
        }
        catch (SQLException e) {
            // Handle SQLException (log or display an error message)
            e.printStackTrace();
        }

        return reservations;
    }
%>

<%
    int userId = (int) session.getAttribute("userId");
    List<Map<String, String>> reservationsList = getReservations(userId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Flight Reservations</title>
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

        .error-message {
            color: red;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        button {
            padding: 5px 10px;
            background-color: #ff0000;
            color: #fff;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <nav>
        <h2 style="color: white;">View Flight Reservations</h2>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>
    <table>
        <tr>
            <th>Ticket ID</th>
            <th>Flight Number</th>
            <th>Departure Airport</th>
            <th>Departure Date</th>
            <th>Arrival Airport</th>
            <th>Arrival Date</th>
            <th>Purchase Date</th>
            <th>Action</th>
        </tr>
        <% if (reservationsList.isEmpty()) { %>
            <tr>
                <td colspan="6">No reservations found.</td>
            </tr>
        <% } else { %>
            <% for (Map<String, String> reservation : reservationsList) { %>
                <tr>
                    <td><%= reservation.get("ticket_id") %></td>
                    <td><%= reservation.get("flight_number") %></td>
                    <td><%= reservation.get("departure_airport") %></td>
                    <td><%= reservation.get("departure_date_time") %></td>
                    <td><%= reservation.get("arrival_airport") %></td>
                    <td><%= reservation.get("arrival_date_time") %></td>
                    <td><%= reservation.get("purchase_date_time") %></td>
                    <td>
                        <form method="POST" action="cancelFlight.jsp">
                            <input type="hidden" name="ticket_id" value="<%= reservation.get("ticket_id") %>">
                            <button type="submit">Cancel</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        <% } %>
    </table>
</body>
</html>
