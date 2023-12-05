<%@ page import ="java.sql.*" %>
<%
	String userid = request.getParameter("username");
	String pwd = request.getParameter("password");
	String role = request.getParameter("role");
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project","root", "khushi@2411");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from user where username='" + userid + "' and password='" + pwd + 
	        "' and role='" + role + "'");
	if (rs.next()) 
	{
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
	} 
	else 
	{
		out.println("Account does not exist in database, <a href='login.jsp'>try again</a>");
	}
%>