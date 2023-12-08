// checks tickets under each username 
<%@ page import ="java.sql.*" %>
<%
String user_id = (String) session.getAttribute("user");
ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs1;
rs1 = stmt.excuteQuery(“select * from tickets where username= ‘“+userid”’ ”)
%>

// if the flight is full, uses the user's info and adds them to waiting list
<%@ page import ="java.sql.*" %>
<%
    String user_id = (String) session.getAttribute("user");
    String airline_id = request.getParameter("airline-id") + "";
    String aircraft_id = request.getParameter("aircraft-id") + "";
    String dep_date = request.getParameter("departing-date") + "";

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs1;
    rs1 = stmt.executeUpdate("insert into waitinglist('username', 'airline-id', 'aircraft-id', 'departing-date') value ('" + user_id +
        "', '" + airline_id + "' ,'" + aircraft_id + "' , '" + dep_date + "')");
%>
