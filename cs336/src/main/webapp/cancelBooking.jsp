<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cancel Booking</title>
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

        .confirmation-message {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <nav>
        <%int user_id = -1;
        String username = null;
        if (!session.getAttribute("role").equals("rep"))
        {
            user_id = (int) (session.getAttribute("user_id"));
        }    
        else
        {
            user_id = Integer.parseInt(request.getParameter("selectedUser"));
        } 
        
        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "Devanshi#");

            String query = "SELECT * FROM user WHERE id = ?";
            try (PreparedStatement users = con.prepareStatement(query)) {
                users.setInt(1, user_id);

                try (ResultSet resultquery = users.executeQuery())
                {
                    while(resultquery.next())
                    {
                        username = resultquery.getString("username");
                    }
                }
                
            }
        }catch (SQLException e) {
            e.printStackTrace();
        }%>
        <%if(!session.getAttribute("role").equals("rep"))
        {
            username = (String) session.getAttribute("user");
        }%>

        <h2>Cancel Booking for <%=username %></h2>
        <a href="searchFlights.jsp">Search Flights</a>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>

    <%
        // Get the ticket ID from the request parameter
        int ticketId = Integer.parseInt(request.getParameter("ticket_id"));

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "Devanshi#");

            // Check if the ticket with the specified ticket_id has class "bus" or "first"
            String checkClassQuery = "SELECT class FROM ticket WHERE ticket_id = ?";
            try (PreparedStatement checkClassStmt = con.prepareStatement(checkClassQuery)) {
                checkClassStmt.setInt(1, ticketId);
                try (ResultSet classResult = checkClassStmt.executeQuery()) {
                    if (classResult.next()) {
                        String ticketClass = classResult.getString("class");

                        // Allow deletion only if the ticket class is "bus" or "first"
                        if ("bus".equals(ticketClass) || "first".equals(ticketClass)) {
                            // Delete the ticket from the ticket table
                            String deleteQuery = "DELETE FROM ticket WHERE ticket_id = ?";
                            try (PreparedStatement deleteStmt = con.prepareStatement(deleteQuery)) {
                                deleteStmt.setInt(1, ticketId);
                                int rowsAffected = deleteStmt.executeUpdate();

                                // Redirect to myBookings.jsp with a success or error message
                                String redirectURL = "myBookings.jsp";
                                if (rowsAffected > 0) {
                                    response.sendRedirect(redirectURL + "?success=true&selectedUser=" + user_id);
                                } else {
                                    response.sendRedirect(redirectURL + "?success=false&reason=incorrectInfo&selectedUser=" + user_id);
                                }
                            }
                        } else {
                            // Redirect to myBookings.jsp with an error message for incorrect class
                            response.sendRedirect("myBookings.jsp?success=false&reason=incorrectClass");
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>

</body>
</html>