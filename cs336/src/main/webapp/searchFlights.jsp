<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            Departing Airport: <input type="text" name="departing-airport" required/> <br/>
            Departing Date: <input type="text" name="departing-date" placeholder="YY-MM-DD" required/> <br/>
            Arriving Airport: <input type="text" name="arriving-airport" required/> <br/>
            Arrival Date: <input type="text" name="arrival-date" placeholder="YY-MM-DD" required/> <br/>
			Flexibility:
			<label>
        		<input type="radio" name="flexibility" value="exact"> Exact dates <br/>
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