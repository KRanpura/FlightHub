<%
	session.invalidate();
	out.println("Session terminated!");
	out.println("To return to login, <a href='login.jsp'>click here</a>");
	out.println("To return to signup, <a href='signup.jsp'>click here</a>");
%>