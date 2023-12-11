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
    String passengerName = request.getParameter("passenger_name");
  try {                                                                                                                      // Establish a database connection
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");  
        String insertQuery = "INSERT INTO tickets (flight_number, passenger_name) VALUES (?, ?)";                                                         
        try (PreparedStatement pstmt = con.prepareStatement(insertQuery)){
            pstmt.setInt(1, flightNumber);
            pstmt.setInt(1, flightNumber);
      // put more ticket info
            int modifyRows = pstmt.excuteUpdate();
            if (modiyingRows > 0){
%>
              <h2>Reservation Successful!</h2>
              <p>Enjoy, <%= passengerName %></p>
            }
<%
            else{
%>
              <h2>Reservation Failed!</h2>
            // insert waiting list here
<%
            }
        }
    } catch (SQL Exception e){
      e.printStackTrace();
    }
%>
</body>
</html>
