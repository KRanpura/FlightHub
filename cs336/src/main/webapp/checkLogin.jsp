<%@ page import ="java.sql.*" %>
<%
	String email = request.getParameter("email");
	String pwd = request.getParameter("password");
	String role = request.getParameter("role");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project","root", "khushi@2411");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from user where email='" + email + "' and password='" + pwd + 
	        "' and role='" + role + "'");
	if (rs.next()) 
	{
		session.setAttribute("email", email);
		session.setAttribute("user", rs.getNString("username"));
		session.setAttribute("user_id", rs.getInt("id"));
		session.setAttribute("role", role);
		response.sendRedirect("homepage.jsp");
	} 
	else 
	{
		out.println("Account does not exist in database, <a href='login.jsp'>try again</a>");
	}
%>