<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>Monthly Sales Report</title>
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
    <h2>Monthly Sales Report</h2>
    <a href= "selectMonth.jsp">Return to Select Month</a>
    <a href="homepage.jsp">Homepage</a>
    <a href="logout.jsp">Log out</a>
</nav>

<% 
    try {
        Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project", "root", "khushi@2411");

        String salesMonthStr = request.getParameter("sales-month");
        Date salesDate = Date.valueOf(salesMonthStr);

        String query = "SELECT SUM(fare) AS total_sales FROM ticket WHERE MONTH(purchased) = ? AND YEAR(purchased) = ?";

        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setInt(1, salesDate.getMonth() + 1); // Adding 1 to match SQL's month numbering
            pstmt.setInt(2, salesDate.getYear() + 1900); // Adding 1900 to match SQL's year representation

            try (ResultSet resultSet = pstmt.executeQuery()) {
%>
                <table>
                    <thead>
                        <tr>
                        	<th>Month Number</th>
                            <th>Total Sales</th> 
                        </tr>
                    </thead>
                    <tbody>
<%
                while (resultSet.next()) {
%>
                        <tr>
                        	<td><%= salesDate.getMonth()+1 %></td>
                            <td><%= resultSet.getFloat("total_sales") %></td>
                        </tr>
<%
                }}}
%>
                    </tbody>
                </table>
<%	
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

</body>
</html>