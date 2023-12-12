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
                        	String username = (String) session.getAttribute("user");
                            int user_id = (int) (session.getAttribute("user_id"));                                                                            // to retrieve id attribute from user in session
                            float fare = Float.parseFloat(request.getParameter("fare"));
                            String ticketClass = request.getParameter("ticket_class");
                            float bookingFee = Float.parseFloat(request.getParameter("booking_fee"));

                            buyTicketStmt.setInt(1, user_id);
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
                    else
                    {
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
</body>
</html>
