<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Question</title>
</head>
<body>

<%
    String questionContent = request.getParameter("questionContent");

    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "Devanshi#");
        
        // Insert the new question into the ForumPosts table
        String insertQuery = "INSERT INTO ForumPosts (question) VALUES (?)";
        try (PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
            pstmt.setString(1, questionContent);
            pstmt.executeUpdate();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    
    // Redirect back to the forum page
    response.sendRedirect("forum.jsp");
%>

</body>
</html>