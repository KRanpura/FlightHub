<%@ page import="java.sql.*" %>

<%
    // Retrieve the user ID from the request parameters
    String userId = request.getParameter("id");

    if (userId != null && !userId.isEmpty()) {
        try {
            // Establish the database connection
            try (Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "Devanshi#")) {

                // Prepare the SQL statement to delete the user
                String query = "DELETE FROM user WHERE id = ?";
                try (PreparedStatement stmt = con.prepareStatement(query)) {
                    stmt.setString(1, userId);
                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("User with ID " + userId + " has been successfully removed.");
                    } else {
                        out.println("User with ID " + userId + " not found or could not be removed.");
                    }
                }
            }
        } catch (SQLException e) {
            // Handle SQLException (log or display an error message)
            e.printStackTrace();
            out.println("An error occurred while removing the user.");
        }
    } else {
        out.println("Invalid user ID.");
    }
%>