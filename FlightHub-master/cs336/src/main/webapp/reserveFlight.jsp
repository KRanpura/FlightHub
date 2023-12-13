<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reserve Flight</title>
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
    <h2>Confirm Flight Booking</h2>
    <a href= "searchFlights.jsp">Return to Search Flights</a>
    <a href= "myBookings.jsp">View My Bookings</a>
    <a href="homepage.jsp">Homepage</a>
    <a href="logout.jsp">Log out</a>
</nav>
<%
    int flightNumber = Integer.parseInt(request.getParameter("flight_number"));
    try {                                                                                                                                                                          // Establish a database connection
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");  
        String checkForTicketsQuery = "SELECT COUNT(*) AS tickets_sold FROM ticket WHERE flight_num = ? AND ticket_id NOT IN (SELECT id FROM Waitinglist)";     
        String capacityQuery = "SELECT aircraft.capacity " +
                "FROM flight " +
                "INNER JOIN aircraft ON flight.aircraft_id = aircraft.id " +
                "WHERE flight.flight_number = ?";        
        try (PreparedStatement pstmt = con.prepareStatement(checkForTicketsQuery)){
            pstmt.setInt(1, flightNumber);
            try (ResultSet ticketResult = pstmt.executeQuery()){
                if (ticketResult.next()){
                    int tickets_sold = ticketResult.getInt("tickets_sold");
                    
                    // Execute the capacity query to get the aircraft capacity
                    try (PreparedStatement capacityStmt = con.prepareStatement(capacityQuery)){
                        capacityStmt.setInt(1, flightNumber);
                        try (ResultSet capacityResult = capacityStmt.executeQuery()){
                            if (capacityResult.next()){
                                int capacity = capacityResult.getInt("capacity");
                                int available_tickets = capacity - tickets_sold;

                                if (available_tickets > 0) {
                                    String buyTicketQuery = "INSERT INTO Ticket(ticket_id, flight_num, user_id, fare, class, purchased, booking_fee) VALUES (DEFAULT, ?, ?, ?, ?, NOW(), ?)";
                                    try (PreparedStatement buyTicketStmt = con.prepareStatement(buyTicketQuery, Statement.RETURN_GENERATED_KEYS)){
                                        int user_id = (int) (session.getAttribute("user_id"));                                                                            // to retrieve id attribute from user in session
                                        float fare = Float.parseFloat(request.getParameter("fare"));
                                        String ticketClass = request.getParameter("class");
                                        float bookingFee = Float.parseFloat(request.getParameter("booking_fee"));
										buyTicketStmt.setInt(1, flightNumber);
                                        buyTicketStmt.setInt(2, user_id);
                                        buyTicketStmt.setFloat(3, fare);
                                        buyTicketStmt.setString(4, ticketClass);
                                        buyTicketStmt.setFloat(5, bookingFee);

                                        int rowChanged =  buyTicketStmt.executeUpdate();
                                        if (rowChanged > 0){
                                            response.sendRedirect("myBookings.jsp");
                                        }
                                    }
                                }  else {
                                    // Your existing code for purchasing a ticket
                                    String buyTicketQuery = "INSERT INTO Ticket(user_id, fare, class, purchased, booking_fee) VALUES (?, ?, ?, NOW(), 0)";
                                    try (PreparedStatement buyTicketStmt = con.prepareStatement(buyTicketQuery, Statement.RETURN_GENERATED_KEYS)) {
                                        int user_id = (int) (session.getAttribute("user_id")); // to retrieve id attribute from user in session
                                        float fare = Float.parseFloat(request.getParameter("fare"));
                                        String ticketClass = request.getParameter("class");
                                       // float bookingFee = Float.parseFloat(request.getParameter("booking_fee"));

                                        buyTicketStmt.setInt(1, user_id);
                                        buyTicketStmt.setFloat(2, fare);
                                        buyTicketStmt.setString(3, ticketClass);
                                        //buyTicketStmt.setFloat(4, bookingFee);

                                        int rowChanged = buyTicketStmt.executeUpdate();
                                        if (rowChanged > 0) {
                                            ResultSet generatedKeys = buyTicketStmt.getGeneratedKeys();
                                            if (generatedKeys.next()) {
                                                int ticket_id = generatedKeys.getInt(1);

                                                // Modify the waiting list query to use the newly inserted ticket_id
                                                String addToWaitlistQuery = "INSERT INTO WaitingList (id, user_id, added) VALUES (?, ?, NOW())";
                                                try (PreparedStatement addToWaitlistStmt = con.prepareStatement(addToWaitlistQuery)) {
                                                    addToWaitlistStmt.setInt(1, ticket_id);
                                                    addToWaitlistStmt.setInt(2, user_id);

                                                    int waitlistRowChanged = addToWaitlistStmt.executeUpdate();
                                                    if (waitlistRowChanged > 0) {
                                %>
                                                        <h2>Waiting List</h2>
                                                        <p>Unfortunately, there are no available tickets for this flight. You have been added to the wait list and will be alerted for any changes.</p>
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
                }
            }
        }
    } catch (SQLException e){
      e.printStackTrace();
    }
%>
</body>
</html>
