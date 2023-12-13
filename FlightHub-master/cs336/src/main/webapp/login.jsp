<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome Page</title>
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
        <h2>Welcome to FlightHub! Login or Sign Up Below.</h2>
        <form action="checkLogin.jsp" method="POST">
            Email: <input type="text" name="email"/> <br/>
            Password: <input type="password" name="password"/> <br/>
            <p>I am a:</p>
    		<label>
        		<input type="radio" name="role" value="customer"> Customer <br/>
    		</label>

    		<label>
        		<input type="radio" name="role" value="rep"> Customer Representative <br/>
    		</label>

    		<label>
       		 	<input type="radio" name="role" value="admin"> Administrator <br/>
    		</label>
			<p>
			    <input type="submit" value="Submit"> <br/>
			</p>
        </form>
        <a href="signup.jsp">Don't have an account? Sign up!</a>
        
    </div>
</body>
</html>