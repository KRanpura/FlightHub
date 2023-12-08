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


// checks all flights that match the user's criteria
<%@ page import ="java.sql.*" %>
<%
    String dep_air = request.getParameter("departing-airport") + "";
    String dep_date = request.getParameter("departing-date") + "";
    String arr_air = request.getParameter("arriving-airport") + "";
    String arr_date = request.getParameter("arrival-date") + "";

    
    String filter1 = request.getParameter("price") + "";
    String filter2 = request.getParameter("stops") + "";
    String filter3 = request.getParameter("airline") + "";
    String filter4 = request.getParameter("take-off-time") + "";
    String filter5 = request.getParameter("landing-time") + "";

    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs1;
    String sql= "";

    rs1 = stmt.executeQuery("select * from flights where dep_airport= '"
    + dep_air + "' and dep_date='" + dep_date + "' and arr_airport= '" 
    + arr_air + "' and arr_date='" + arr_date + "' ");


    /*if(!dep_air.equals(null))
    {
        sql += "select * from flights where dep_airport='" + dep_air + "'";
    }
    if(!dep_date.equals(null))
    {
        sql += "select * from flights where dep_date='" + dep_date + "'";
    }
    if(!arr_air.equals(null))
    {
        sql += "select * from flights where arr_airport='" + arr_air + "'";
    }
    if(!arr_date.equals(null))
    {
        sql += "select * from flights where arr_date='" + arr_date + "'";
    }
    if(filter1 != null && !filter1.isEmpty())
    {
        sql += "select * from flights where price <='" + filter1 + "'";
    }
    if(filter2 != null && !filter2.isEmpty())
    {
        sql += "select * from flights where stops <='" + filter2 + "'";
    }
    if(filter3 != null && !filter3.isEmpty())
    {
        sql += "select * from flights where airline='" + filter3 + "'";
    }
    if(filter4 != null && !filter4.isEmpty())
    {
        sql += "select * from flights where dept_date='" + filter4 + "'";
    }
    if(filter5 != null && !filter5.isEmpty())
    {
        sql += "select * from flights where arr_date='" + filter5 + "'";
    }
    
    rs1 = stmt.executeQuery(sql);*/

    if(rs1.next())
    {
        response.sendRedirect("reservation.jsp");
    }
    else
    {
        out.println("No match for flight, <a href='searchFlights.jsp'>try again</a>");
    }
%>
