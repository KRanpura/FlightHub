<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Search Flights</title>
    <style>
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        form {
            text-align: center;
        }
    </style>
</head>
<body>
    <div>
        <h2>Search for Flights Below.</h2>
        <form action="checkFlights.jsp" method="POST">
            Departing Airport: <input type="text" name="departing-airport" required/> <br/>
            Departing Date: <input type="text" name="departing-date" placeholder="YY-MM-DD" required/> <br/>
            Arriving Airport: <input type="text" name="arriving-airport" required/> <br/>
            Arrival Date: <input type="text" name="arrival-date" placeholder="YY-MM-DD" required/> <br/>

            Price: <input type="text" name="price"/> <br/>
            Number of Stops: <input type="text" name="stops"/> <br/>
            Airline: <input type="text" name="airline"/> <br/>
            Take-off time: <input type="text" name="take-off-time" placeholder="HH:MM"/> <br/>
            Landing time: <input type="text" name="landing-time" placeholder="HH:MM"/> <br/>

			<p>
			    <input type="submit" value="Submit"> <br/>
			</p>
        </form>        
    </div>
</body>
</html>
