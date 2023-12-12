<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reserve Flight</title>
</head>
<body>
<%
    int flightNumber = Integer.parseInt(request.getParameter("flight_number"));
    try {                                                                                                                                                                          // Establish a database connection
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");  
        String checkForTicketsQuery = "SELECT COUNT(*) AS avaiable_tickets FROM TicketForFlight WHERE flight_number = ? AND ticket_id NOT IN (SELECT id FROM WaitingList)";                                                         
        try (PreparedStatement pstmt = con.prepareStatement(checkForTicketsQuery)){
            pstmt.setInt(1, flightNumber);
            try (ResultSet ticketResult = pstmt.executeQuery()){
                if (ticketResult.next()){
                    int availableTickets = ticketResult.getInt("available_tickets");
                    if (availableTickets > 0){
                        String buyTicketQuery = "INSERT INTO Ticket(user_id, fare, class, purchase_date_time, booking_fee) VALUES (?, ?, ?, NOW(), ?)"; 
                        try(PreparedStatement buyTicketStmt = con.prepareStatement(buyTicketQuery, Statement.RETURN_GENERATED_KEYS)){
                            int userId = ((User) session.getAttribute("user")).getId();                                                                            // to retrieve id attribute from user in session
                            float fare = Float.parseFloat(request.getParameter("fare"));
                            String ticketClass = request.getParameter("ticket_class");
                            float bookingFee = Float.parseFloat(request.getParameter("booking_fee"));

                            buyTicketStmt.setInt(1, userId);
                            buyTicketStmt.setFloat(2, fare);
                            buyTicketStmt.setString(3, ticketClass);
                            buyTicketStmt.setFloat(4, bookingFee);

                            int rowChanged =  buyTicketStmt.executeUpdate();
                            if (rowChanged > 0){
%>
                                <h2>Reservation Complete!</h2>
                                <p>Booked flight number <%= flightNumber %> </p>
<%
                            }
                        }
                    }
                    else{
                        String addToWaitlistQuery = "INSERT INTO WaitingList (id, added_date_time) VALUES (?, NOW())";
                        try (PreparedStatement addToWaitlistStmt = con.prepareStatement(addToWaitlistQuery)){
                            addToWaitlistStmt.setInt(1, flightNumber);
                            int rowChanged = addToWaitlistStmt.executeUpdate();
                            if (rowChanged > 0){
%>
                                <h2>Waiting List</h2>
                                <p>Unfortunately, there are no available tickets for flight number <%= flightNumber %>. You have been added to the waitlist and will be alerted for any changes.</p>
<%
                            }
                        }
                    }
                }
            }
        }
    } catch (SQLException e){
      e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reserve Flight</title>
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
        <h2 style="color: white;">View Flight Status</h2>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>

// rest of HTML format

</body>
</html>
