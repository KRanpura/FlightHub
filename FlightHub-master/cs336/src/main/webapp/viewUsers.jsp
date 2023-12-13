<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.sql.*" %>

<%! 
    // Function to retrieve user data from the database
    public List<Map<String, String>> getUsers() {
        List<Map<String, String>> users = new ArrayList<>();
        
        try {
            // Establish the database connection
            try (Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411")) {
                String query = "SELECT * FROM user WHERE role != 'admin'";

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
                        users.add(user);
                    }
                }
            }
        } catch (SQLException e) {
            // Handle SQLException (log or display an error message)
            e.printStackTrace();
        }

        return users;
    }
%>

<%
    List<Map<String, String>> usersList = getUsers();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FlightHub Accounts</title>
    <style>
        body {
            padding: 20px;
            text-align: center;
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

        .error-message {
            color: red;
        }

        table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        button {
            padding: 5px 10px;
            background-color: #ff0000;
            color: #fff;
            border: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <nav>
        <h2 style="color: white;">View FlightHub Users</h2>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>

    <table>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Role</th>
            <th>Phone</th>
            <th>Action</th>
        </tr>
        <% for (Map<String, String> user : usersList) { %>
            <tr>
                <td><%= user.get("id") %></td>
                <td><%= user.get("username") %></td>
                <td><%= user.get("firstName") %></td>
                <td><%= user.get("lastName") %></td>
                <td><%= user.get("email") %></td>
                <td><%= user.get("role") %></td>
                <td><%= user.get("phone") %></td>
                <td><button onclick="removeUser('<%= user.get("id") %>')">Remove</button></td>
            </tr>
        <% } %>
    </table>

    <script>
        function removeUser(userId) {
            // Use AJAX to send a request to delete the user
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    // Reload the page after successful deletion
                    location.reload();
                }
            };

            xhr.open("POST", "removeUser.jsp?id=" + userId, true);
            xhr.send();
        }
    </script>
</body>
</html>