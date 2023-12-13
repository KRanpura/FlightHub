<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Highest Revenue Customer</title>
    <style>
       body {
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        nav {
            background-color: #333;
            overflow: hidden;
            color: white;
            text-align: center;
            padding: 10px;
            width: 100%;
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

        table {
            margin-top: 20px;
            border-collapse: collapse;
            width: 80%;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #333;
            color: white;
        }
    </style>
</head>
<body>

<nav>
    <h2>Highest Revenue Customer</h2>
    <a href="homepage.jsp">Homepage</a>
    <a href="logout.jsp">Log out</a>
</nav>

<%
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");

        String query = "SELECT u.username, u.firstName, u.lastName, u.email, SUM(t.booking_fee) AS total_booking_fee " +
                       "FROM user u " +
                       "JOIN ticket t ON u.id = t.user_id " +
                       "GROUP BY u.username, u.firstName, u.lastName, u.email " +
                       "ORDER BY total_booking_fee DESC " +
                       "LIMIT 1";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            try (ResultSet resultSet = pstmt.executeQuery()) {
%>
                <table>
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Total Revenue</th>
                        </tr>
                    </thead>
                    <tbody>
<%
                while (resultSet.next()) {
%>
                    <tr>
                        <td><%= resultSet.getString("username") %></td>
                        <td><%= resultSet.getString("firstName") %></td>
                        <td><%= resultSet.getString("lastName") %></td>
                        <td><%= resultSet.getString("email") %></td>
                        <td><%= resultSet.getFloat("total_booking_fee") %></td>
                    </tr>
<%
                }
%>
                    </tbody>
                </table>
<%
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

</body>
</html>