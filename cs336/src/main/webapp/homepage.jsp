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
                response.sendRedirect("login.jsp"); // Redirect to login page if the user is not logged in
            }
        %>
    </title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;q 	 
            margin: 0;
        }

        nav {
            background-color: #333;
            overflow: hidden;
        }

        nav a {
            float: left;
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        nav a:hover {
            background-color: #ddd;
            color: black;
        }
    </style>
</head>
<body>
    <%
        String role = (String) session.getAttribute("role");
        if (role.equals("customer")) {
    %>
        <nav>
            <a href="searchFlights.jsp">Search Flights</a>
            <a href="myBookings.jsp">View My Bookings</a>
            <a href="forum.jsp">Q&A Forum</a>
            <a href="logout.jsp">Log out</a>
        </nav>
    <%
        } else if (role.equals("rep")) {
    %>
        <nav>
            <a href="searchFlights.jsp">Search Flights</a>
            <a href="forum.jsp">Answer User Questions</a>
            <a href="logout.jsp">Log out</a>
        </nav>

        <%
        	} else if (role.equals("admin")) {
        %>
             <nav>
     	        <a href="modInfo.jsp">Modify Site Info</a>
     	        <a href="viewUsers.jsp"> View FlightHub Accounts</a>
            	<a href="reservations.jsp"> View Reservations</a>
                <a href="revenue.jsp"> View Revenue</a>
            	<a href="logout.jsp">Log out</a>
        	</nav>
        
        <% 
        	}
            String name = (String) session.getAttribute("user");
            if (name != null) {
        %>
                <h1>Hello <%= username %>!</h1>
                <p>Welcome to your user page!</p>
        <%
            } 
            else {
                response.sendRedirect("login.jsp"); // Redirect to login page if the user is not logged in
            }
        %>
    </body>
</html>