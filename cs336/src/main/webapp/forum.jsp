<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A Forum</title>
    <style>
        body {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
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

        .forum-post {
            border: 1px solid #ddd;
            padding: 10px;
            margin: 10px;
            width: 50%;
        }

        .new-question-form {
            width: 50%;
            margin: 20px;
            padding: 10px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>
    <nav>
        <h2 style="color: white;">Q&A Forum</h2>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>

    <div class="forum-posts">
        <% 
            try {
                Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "Devanshi#");
                Statement stmt = con.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM forumposts");

                while (rs.next()) {
        %>
                    <div class="forum-post">
                        <strong>Post ID:</strong> <%= rs.getInt("id") %><br>
                        <strong>Question:</strong> <%= rs.getString("question") %><br>
                        <strong>Answer:</strong> <%= rs.getString("answer") %><br>
                        <% 
                            // Check if the user is a rep, and if so, show the "Edit Answer" link
                            String role = (String) session.getAttribute("role");
                            if (role != null && role.equals("rep")) {
                        %>
                                <a href="editAnswer.jsp?id=<%= rs.getInt("id") %>">Edit Answer</a>
                        <%
                            }
                        %>
                    </div>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </div>

    <div class="new-question-form">
        <h3>Write a New Forum Question</h3>
        <form action="submitQuestion.jsp" method="post">
            <label for="questionContent">Question:</label><br>
            <textarea id="questionContent" name="questionContent" rows="4" cols="50" required></textarea><br>
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>