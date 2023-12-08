<%@ page import ="java.sql.*" %>
<%
String user_id = (String) session.getAttribute("user");
ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs1;
rs1 = stmt.excuteQuery(“select * from tickets where username= ‘“+userid”’ ”)
%>
