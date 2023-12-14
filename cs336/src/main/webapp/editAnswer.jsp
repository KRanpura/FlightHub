<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Answer</title>
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
    </style>
</head>
<body>

<%
    String postIdParam = request.getParameter("id");

    if (postIdParam != null) {
        int postId = Integer.parseInt(postIdParam);

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "Devanshi#");

            // Check if the form is submitted
            if (request.getMethod().equalsIgnoreCase("post")) {
                String updatedAnswer = request.getParameter("answerContent");

                // Update the answer for the specified post ID
                String updateQuery = "UPDATE ForumPosts SET answer = ? WHERE id = ?";
                try (PreparedStatement updateStmt = con.prepareStatement(updateQuery)) {
                    updateStmt.setString(1, updatedAnswer);
                    updateStmt.setInt(2, postId);
                    updateStmt.executeUpdate();
                }

                // Redirect back to the forum page
                response.sendRedirect("forum.jsp");
            } else {
                // Retrieve the current answer for the specified post ID
                String selectQuery = "SELECT * FROM ForumPosts WHERE id = ?";
                try (PreparedStatement selectStmt = con.prepareStatement(selectQuery)) {
                    selectStmt.setInt(1, postId);
                    ResultSet resultSet = selectStmt.executeQuery();

                    if (resultSet.next()) {
                        String currentAnswer = resultSet.getString("answer");
%>

					<h2>Edit Answer for Post ID <%= postId %></h2>
					<form action="editAnswer.jsp?id=<%= postId %>" method="post">
					    <input type="hidden" name="postId" value="<%= postId %>">
					    <label for="answerContent">Answer:</label><br>
					    <textarea id="answerContent" name="answerContent" rows="4" cols="50" required><%= currentAnswer %></textarea><br>
					    <input type="submit" value="Update Answer">
					</form>
<%
                    } else {
                        out.println("<p>Post not found.</p>");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error updating or retrieving answer.</p>");
        }
    } else {
        out.println("<p>Invalid post ID.</p>");
    }
%>

</body>
</html>