<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Revenue Source</title>
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
        <h2>Select Revenue Source</h2>
        <a href="homepage.jsp">Homepage</a>
        <a href="logout.jsp">Log out</a>
    </nav>
    <div>
		<form action="revenue.jsp" method="POST">
		    Flight Number: <input type="text" name="flight-number" /> <br/>
		    <p>
		        <input type="submit" value="Submit">
		    </p>
		</form>
    </div>
    <div>
		<form action="revenue.jsp" method="POST">
		    Airline ID: <input type="text" name="airline-id" /> <br/>
		    <p>
		        <input type="submit" value="Submit">
		    </p>
		</form>
    </div>
    <div>
		<form action="revenue.jsp" method="POST">
		    Customer ID: <input type="text" name="customer-id" /> <br/>
		    <p>
		        <input type="submit" value="Submit">
		    </p>
		</form>
    </div>
</body>
</html>