<%@ page import = "java.sql.*" %>
<%
	String first = request.getParameter("first");
	String last = request.getParameter("last");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String userid = request.getParameter("username");
	String pwd = request.getParameter("password");
	String role = request.getParameter("role");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project","root", "khushi@2411");
	Statement st = con.createStatement();
	ResultSet rs;
    String query = "INSERT INTO user (id, firstName, lastName, username, password, role, phone, email) VALUES (DEFAULT, ?, ?, ?, ?, ?, ?, ?)";
    PreparedStatement pst = con.prepareStatement(query);
    pst.setString(1, first);
    pst.setString(2, last);
    pst.setString(3, userid);
    pst.setString(4, pwd);
    pst.setString(5, role);
    pst.setString(6, phone);
    pst.setString(7, email);

    pst.executeUpdate();
    session.setAttribute("user", userid); 
	if (role.equals("customer"))
	{
		response.sendRedirect("customer_homepage.jsp");
	}
	else if (role.equals("rep"))
	{
		response.sendRedirect("rep_homepage.jsp");
	}
	else if (role.equals("admin"))
	{
		response.sendRedirect("admin_homepage.jsp");
	}
%>