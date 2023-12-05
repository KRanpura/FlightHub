<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>
        <%
            String username = (String) session.getAttribute("user");
            if (username != null) {
                out.print("Hello " + username);
            } else {
                response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
            }
        %>
    </title>
</head>
<body>
    <%
        String name = (String) session.getAttribute("user");
        if (name != null) {
    %>
            <h1>Hello <%= username %>!</h1>
            <p>Welcome to your user page!</p>
            <a href="logout.jsp">Log out</a>
    <%
        } else {
            response.sendRedirect("login.jsp"); // Redirect to login page if user is not logged in
        }
    %>
</body>
</html>