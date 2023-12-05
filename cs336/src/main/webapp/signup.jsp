<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FlightHub Sign-up</title>
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
		<h2>FlightHub Sign-up</h2>
		<form action="makeAccount.jsp" method="POST">
			First name: <input type = "text" name = "first"/> <br/>
			Last name: <input type = "text" name = "last"/> <br/>
			Email: <input type= "text" name = "email"/> <br/>
            Username: <input type="text" name="username"/> <br/>
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
			    <input type="submit" value="Make my account"> <br/>
			</p>
        </form>
	</div>

</body>
</html>