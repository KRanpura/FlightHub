<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
List<Map<String, String>> usersList = new ArrayList<>();

try {
    // Establish the database connection
    try (Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "Devanshi#")) {
        String query = "SELECT * FROM user WHERE role = 'customer'";

        // Create a PreparedStatement
        try (PreparedStatement stmt = con.prepareStatement(query);
                ResultSet result = stmt.executeQuery()) {

            // Process the ResultSet
            while (result.next()) {
                Map<String, String> user = new HashMap<>();
                user.put("id", String.valueOf(result.getInt("id")));
                user.put("username", result.getString("username"));
                user.put("firstName", result.getString("firstName"));
                user.put("lastName", result.getString("lastName"));
                user.put("email", result.getString("email"));
                user.put("role", result.getString("role"));
                user.put("phone", result.getString("phone"));
                usersList.add(user);
            }
        }
    }
} catch (SQLException e) {
    // Handle SQLException (log or display an error message)
    e.printStackTrace();
} 

%>

<!DOCTYPE html>
<html>
<head>
    <title>Search Flights</title>
    <style>
        body {
            margin: 0;
            padding: 0;
        }

        nav {
            background-color: #333;
            overflow: hidden;
            color: white;
            text-align: center;
            padding: 10px;
        }

        nav a {
            color: #f2f2f2;
            text-decoration: none;
            padding: 14px 16px;
            display: inline-block;
        }

        nav a:hover {
            background-color: #ddd;
            color: black;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
        }

        form input {
            margin: 5px;
        }
    </style>
</head>
<body>
    <nav>
        <h2>Search Flights</h2>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>
    <div>
		<form action="checkFlights.jsp" method="POST">
            <label>Select User:</label>
            <select name="selectedUser">
                <% for (Map<String, String> user : usersList) { %>
                    <option value="<%= user.get("id") %>"><%= user.get("username") %></option>
                <% } %>
            </select>
		    Departing Airport: <input type="text" name="departing-airport" required/> <br/>
		    Departing Date: <input type="date" name="departing-date" required/> <br/>
		    Arriving Airport: <input type="text" name="arriving-airport" required/> <br/>
		    Arrival Date: <input type="date" name="arrival-date" required/> <br/>
		    Flexibility:
		    <label>
		        <input type="radio" name="flexibility" required value="exact"> Exact dates <br/>
		    </label>
		    <label>
		        <input type="radio" name="flexibility" value="flexible"> +/- 3 days <br/>
		    </label>
		    <p>
		        <input type="submit" value="Submit">
		    </p>
		</form>
    </div>
</body>
</html>