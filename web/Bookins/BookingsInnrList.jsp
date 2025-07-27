<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.MySqlConnection"%>
<%@page import="org.json.JSONObject"%> 
<%@page import="org.json.JSONArray"%>  
<%@page contentType="application/json" pageEncoding="UTF-8"%>

<%!
    // Utility function to handle null or empty strings
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>

<%
    // Initialize the database connection objects
    MySqlConnection dbc = new MySqlConnection();
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rst = null;

    // Get the raw JSON data sent from the frontend
    String jsonData = request.getReader().lines().collect(java.util.stream.Collectors.joining());
    JSONObject jsonInput = new JSONObject(jsonData);  // Convert the raw data into a JSON object

    // Extract parameters from the JSON object
    String lnamefname = isBlankNull(jsonInput.optString("g.lname"));
    String roomno = isBlankNull(jsonInput.optString("room_no"));
    String totalBill = isBlankNull(jsonInput.optString("total_bill"));
    String check_in = isBlankNull(jsonInput.optString("check_in"));
    String check_out = isBlankNull(jsonInput.optString("check_out"));
    String createdBy = isBlankNull(jsonInput.optString("ud.fname"));
    SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");
    // Prepare the SQL query with filters
    String query = "";

    if (!lnamefname.isEmpty()) {
        query += "  and g.lname like ''%" + lnamefname + "%'' or g.fname like ''%" + lnamefname + "%'' ";
    }
    if (!roomno.isEmpty()) {
        query += " AND room_no = "+ roomno +"";
    }
    if (!totalBill.isEmpty()) {
        query += " AND total_bill = "+ totalBill +"";
    }
    if (!check_in.isEmpty()) {
        query += " AND check_in >= ''"+ outputFormat.format(inputFormat.parse(check_in)) +" 00:00:00'' and check_in <= ''"+ outputFormat.format(inputFormat.parse(check_in)) +" 23:59:59'' ";
    }
    if (!check_out.isEmpty()) {
        query += " AND check_out >= ''"+ outputFormat.format(inputFormat.parse(check_out)) +" 00:00:00'' and check_out <= ''"+ outputFormat.format(inputFormat.parse(check_out)) +" 23:59:59'' ";
    }
    if (!createdBy.isEmpty()) {
        query += " AND ud.fname like ''%" + createdBy + "%''";
    }

    // Execute the query
    try {
        query = "Call GetBookingsDtls('" + query + "')";
        System.out.println(query);
        con = dbc.getConnection();
        pstmt = con.prepareStatement(query);

        

        rst = pstmt.executeQuery();

        // Prepare the response data as a JSON array
        JSONArray jsonResponse = new JSONArray();
        int iRow = 0;
        while (rst.next()) {
            JSONObject Bookings = new JSONObject();
            iRow++;
           
            // Populate the JSON object with values from ResultSet
            Bookings.put("index", iRow);
            Bookings.put("bookingid", isBlankNull(rst.getString("bookingid")));
            Bookings.put("GuestName", isBlankNull(rst.getString("GuestName")));
            Bookings.put("room_no", isBlankNull(rst.getString("room_no")));
            Bookings.put("totalBill", isBlankNull(rst.getString("total_bill")));

            // Convert the date format of check_in and check_out
            
            
            Bookings.put("check_in", isBlankNull(rst.getString("check_in")));
            Bookings.put("check_out", isBlankNull(rst.getString("check_out")));

            // Add the JSON object to the response array
            Bookings.put("createdBy", isBlankNull(rst.getString("createdBy")));
            jsonResponse.put(Bookings);
        }

        // Send the JSON response to the frontend
        response.getWriter().write(jsonResponse.toString());

    } catch (Exception ex) {
        ex.printStackTrace();
        // In case of an error, return an empty JSON array
        response.getWriter().write("[]");
    } finally {
        try {
            if (rst != null) {
                rst.close();
            }
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
%>
