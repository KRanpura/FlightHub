<%@ page import ="java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%

	Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cs336project","root", "khushi@2411");
	Statement st = con.createStatement();
	ResultSet rs;
	
	if (request.getParameter("airport")!= null)
	{
		boolean error = false; 
		
		String id = request.getParameter("airport_id");
		String name = request.getParameter("airport_name");
		String mod = request.getParameter("modPort");
		
	    String idCheckQuery = "SELECT * FROM airport WHERE id=?";
	    PreparedStatement idCheckStatement = con.prepareStatement(idCheckQuery);
	    idCheckStatement.setString(1, id);
	    ResultSet idCheckResult = idCheckStatement.executeQuery();
	    
		if (mod.equals("add"))
		{
		    if (idCheckResult.next()) 
		    {
		    	error = true;
		        request.setAttribute("errorAirport", "Cannot execute insertion, airport with this ID already exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
		    }
		    else
		    {
		        String query = "INSERT INTO airport (id, name) VALUES (?, ?)";
		        PreparedStatement pst = con.prepareStatement(query);
		        pst.setString(1, id);
		        pst.setString(2, name);
		        pst.executeUpdate();
		        request.setAttribute("successAirport", "Inserted!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
		    }
		}   
		else if (mod.equals("remove"))
		{
			if (idCheckResult.next())
			{
				String query = "DELETE FROM airport WHERE id = ?";
		        PreparedStatement pst = con.prepareStatement(query);
		        pst.setString(1, id);
		        pst.executeUpdate();
		        request.setAttribute("successAirport", "Removed!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else
			{
				error = true;
		        request.setAttribute("errorAirport", "Cannot execute deletion, airport with this ID does not exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
		else if (mod.equals("update"))
		{
			if (idCheckResult.next())
			{
			    String query = "UPDATE airport SET name = ? WHERE id = ?";
		        PreparedStatement pst = con.prepareStatement(query);
		        pst.setString(1, name);
		        pst.setString(2, id);
		        pst.executeUpdate();
		        request.setAttribute("successAirport", "Updated!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else
			{
				error = true;
		        request.setAttribute("errorAirport", "Cannot execute update, airport with this ID does not exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
	}
	
	if (request.getParameter("airline") != null)
	{
		boolean error = false; 
		
		String id = request.getParameter("airline_id");
		String name = request.getParameter("airline_name");
		String mod = request.getParameter("modLine");
		
		String idCheckQuery = "SELECT * FROM airline WHERE id=?";
	    PreparedStatement idCheckStatement = con.prepareStatement(idCheckQuery);
	    idCheckStatement.setString(1, id);
	    ResultSet idCheckResult = idCheckStatement.executeQuery();
	    
		if (mod.equals("add"))
		{
		    if (idCheckResult.next()) 
		    {
		    	error = true;
		        request.setAttribute("errorAirline", "Cannot execute insertion, airline with this ID already exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
		    }
		    else
		    {
		        String query = "INSERT INTO airline (id, name) VALUES (?, ?)";
		        PreparedStatement pst = con.prepareStatement(query);
		        pst.setString(1, id);
		        pst.setString(2, name);
		        pst.executeUpdate();
		        request.setAttribute("successAirline", "Inserted!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
		    }
		}   
		else if (mod.equals("remove"))
		{
			if (idCheckResult.next())
			{
				String query = "DELETE FROM airline WHERE id = ?";
		        PreparedStatement pst = con.prepareStatement(query);
		        pst.setString(1, id);
		        pst.executeUpdate();
		        request.setAttribute("successAirline", "Removed!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else
			{
				error = true;
		        request.setAttribute("errorAirline", "Cannot execute deletion, airline with this ID does not exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
		else if (mod.equals("update"))
		{
			if (idCheckResult.next())
			{
			    String query = "UPDATE airline SET name = ? WHERE id = ?";
		        PreparedStatement pst = con.prepareStatement(query);
		        pst.setString(1, name);
		        pst.setString(2, id);
		        pst.executeUpdate();
		        request.setAttribute("successAirline", "Updated!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else
			{
				error = true;
		        request.setAttribute("errorAirline", "Cannot execute update, airline with this ID does not exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
		
	}
	if (request.getParameter("airlineInAirport") != null)
	{
		boolean error = false; 
		
		String airline = request.getParameter("airline_id");
		String airport = request.getParameter("airport_id");
		String mod = request.getParameter("modLinePort");
		
		String query = "SELECT * FROM airlineinairport WHERE airline_id=? AND airport_id=?";
	    PreparedStatement t = con.prepareStatement(query);
	    t.setString(1, airline);
	    t.setString(2, airport);
	    ResultSet result = t.executeQuery();
	    
		if (mod.equals("add"))
		{
		    if (result.next()) 
		    {
		    	error = true;
		        request.setAttribute("errorLinePort", "Cannot execute insertion, airline already exists in this airport.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
		    }
		    else
		    {
		        String insert = "INSERT INTO airlineinairport (airline_id, airport_id) VALUES (?, ?)";
		        PreparedStatement pst = con.prepareStatement(insert);
		        pst.setString(1, airline);
		        pst.setString(2, airport);
		        pst.executeUpdate();
		        request.setAttribute("successLinePort", "Inserted!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
		    }
		}   
		else if (mod.equals("remove"))
		{
			if (result.next())
			{
				String delete = "DELETE FROM airlineinairport WHERE airline_id= ? AND airport_id=?";
		        PreparedStatement pst = con.prepareStatement(delete);
		        pst.setString(1, airline);
		        pst.setString(2, airport);
		        pst.executeUpdate();
		        request.setAttribute("successLinePort", "Removed!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else
			{
				error = true;
		        request.setAttribute("errorLinePort", "Cannot execute deletion, airline does not exist at this airport.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
	}
	if (request.getParameter("aircraft") != null)
	{
		boolean error = false; 
		
		int id = Integer.parseInt(request.getParameter("aircraft_id"));
		String name = request.getParameter("aircraft_name");
		String airlineID = request.getParameter("airline_id");
		int capacity = Integer.parseInt(request.getParameter("capacity"));
		String mod = request.getParameter("modCraft");
		
		String idCheckQuery = "SELECT * FROM aircraft WHERE id=?";
	    PreparedStatement idCheckStatement = con.prepareStatement(idCheckQuery);
	    idCheckStatement.setInt(1, id);
	    ResultSet idCheckResult = idCheckStatement.executeQuery();
	    
	    String airlineCheck = "SELECT * FROM airline WHERE id=?";
	    PreparedStatement stmt = con.prepareStatement(airlineCheck);
	    stmt.setString(1, airlineID);
	    ResultSet result = stmt.executeQuery();
	    
		if (mod.equals("add"))
		{
			if (idCheckResult.next())
			{
				error = true;
		        request.setAttribute("errorAircraft", "Cannot execute insertion, aircraft with this ID already exists in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else if (!result.next())
			{
				error = true;
		        request.setAttribute("errorAircraft", "Cannot execute insertion, airline with this ID does not exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else 
			{
		        String query = "INSERT INTO aircraft (id, airline_id, craft_name, capacity) VALUES (?, ?, ?, ?)";
		        PreparedStatement pst = con.prepareStatement(query);
		        pst.setInt(1, id);
		        pst.setString(2, airlineID);
		        pst.setString(3, name);
		        pst.setInt(4, capacity);
		        pst.executeUpdate();
		        request.setAttribute("successAircraft", "Inserted!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
		else if (mod.equals("remove"))
		{
			if (!idCheckResult.next())
			{
				error = true;
		        request.setAttribute("errorAircraft", "Cannot execute deletion, aircraft with this ID does not exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else
			{
				String query = "DELETE FROM aircraft WHERE id = ?";
		        PreparedStatement pst = con.prepareStatement(query);
		        pst.setInt(1, id);
		        pst.executeUpdate();
		        request.setAttribute("successAircraft", "Removed!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
		else if (mod.equals("update"))
		{
			if (!idCheckResult.next())
			{
				error = true;
		        request.setAttribute("errorAircraft", "Cannot execute update, aircraft with this ID does not exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else if (!result.next())
			{
				error = true;
		        request.setAttribute("errorAircraft", "Cannot execute update, airline with this ID does not exist in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
			else 
			{
			    String query = "UPDATE aircraft SET craft_name = ?, airline_id = ?, capacity = ?  WHERE id = ?";
		        PreparedStatement pst = con.prepareStatement(query);
		        pst.setString(1, name);
		        pst.setString(2, airlineID);
		        pst.setInt(3, capacity);
		        pst.setInt(4, id);
		        pst.executeUpdate();
		        request.setAttribute("successAircraft", "Updated!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
	}
	if (request.getParameter("flight") != null)
	{
		boolean error = false;
		int flight_num = Integer.parseInt(request.getParameter("flight_num"));
		int craft_id = Integer.parseInt(request.getParameter("craft_id"));
		String airline = request.getParameter("line_id");
		String dep_airport = request.getParameter("dep_airport");
		String arr_airport = request.getParameter("arr_airport");
		float price = Float.parseFloat(request.getParameter("price"));
		
		String depDateString = request.getParameter("dep_date");
		String arrDateString = request.getParameter("arr_date");

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

		LocalDateTime depDateTime = LocalDateTime.parse(depDateString, formatter);
		LocalDateTime arrDateTime = LocalDateTime.parse(arrDateString, formatter);
		
		String isDomesticString = request.getParameter("is_domestic");
		boolean isDomestic = "Yes".equalsIgnoreCase(isDomesticString);
		
		String mod = request.getParameter("modFlight");
		if (mod.equals("add"))
		{
			try {
				String query = "INSERT INTO flight (flight_number, aircraft_id, airline_id, departure_airport_id, arrival_airport_id, price, departure_date_time, arrival_date_time, is_domestic) " +
			               "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

				PreparedStatement pst = con.prepareStatement(query);
				pst.setInt(1, flight_num);
				pst.setInt(2, craft_id);
				pst.setString(3, airline);
				pst.setString(4, dep_airport);
				pst.setString(5, arr_airport);
				pst.setFloat(6, price);
				pst.setObject(7, depDateTime);
				pst.setObject(8, arrDateTime);
				pst.setBoolean(9, isDomestic);
	    		 pst.executeUpdate();
	    		 request.setAttribute("successFlight", "Inserted!");
			     request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			} catch (SQLException e){
				error = true;
		        request.setAttribute("errorFlight", "Cannot execute insertion, check flight information.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}

		}
		else if (mod.equals("remove"))
		{
			try {
				String query = "DELETE FROM flight WHERE flight_number = ?";
	      		 PreparedStatement pst = con.prepareStatement(query);
	      		 pst.setInt(1, flight_num);
	      		 pst.executeUpdate();
	      		request.setAttribute("successFlight", "Removed!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			} catch (SQLException e) {
				error = true;
		        request.setAttribute("errorFlight", "Cannot execute deletion, flight with this number is not in the database.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
		else if (mod.equals("update"))
		{
			try {
				String query = "UPDATE flight SET aircraft_id = ?, airline_id = ?, departure_airport = ?, arrival_airport = ?, price = ?, departure_date_time = ?, arrival_date_time = ?, is_domestic = ? WHERE flight_number = ?";
	      		 PreparedStatement pst = con.prepareStatement(query);
	      		 pst.setInt(9, flight_num);
	             pst.setInt(1, craft_id);
	      		 pst.setString(2, airline);
	      		 pst.setString(3, dep_airport);
	      		 pst.setString(4, arr_airport);
	      		 pst.setFloat(5, price);
	     		 pst.setObject(6, depDateTime);
	     		 pst.setObject(7, arrDateTime);
	     		 pst.setBoolean(8, isDomestic);	      		 
	     		 pst.executeUpdate();
	     		request.setAttribute("successFlight", "Updated!");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			} catch (SQLException e) {
				error = true;
		        request.setAttribute("errorFlight", "Cannot execute update, check flight info.");
		        request.getRequestDispatcher("modInfo.jsp").forward(request, response);
			}
		}
	}
%>