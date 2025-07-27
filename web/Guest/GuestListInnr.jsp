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
    String lname = isBlankNull(jsonInput.optString("lname"));
    String city = isBlankNull(jsonInput.optString("city"));
    String state = isBlankNull(jsonInput.optString("state"));
    String country = isBlankNull(jsonInput.optString("country"));
    String pincode = isBlankNull(jsonInput.optString("pincode"));
    String UID_NO = isBlankNull(jsonInput.optString("UID_NO"));
    String phone = isBlankNull(jsonInput.optString("phone"));

    // Prepare the SQL query with filters
    String query = "Select  guestid, lname, g.fname, address1, address2, city, state, country, pincode, UID_type, UID_NO, phone, DATE_FORMAT(created_on, '%d-%m-%Y') AS createdOn , u.fName"
            + " from guests g "
            + " join( "
            + " Select userid,fName from userdetails "
            + " )u on u.userid = g.created_by "
            + "  WHERE 1=1 ";
        

    if (!lname.isEmpty()) {
        query += " AND (g.lname LIKE ? OR g.fname LIKE ?)";
    }
    if (!city.isEmpty()) {
        query += " AND city LIKE ?";
    }
    if (!state.isEmpty()) {
        query += " AND state LIKE ?";
    }
    if (!country.isEmpty()) {
        query += " AND country LIKE ?";
    }
    if (!pincode.isEmpty()) {
        query += " AND pincode LIKE ?";
    }
    if (!UID_NO.isEmpty()) {
        query += " AND UID_NO LIKE ?";
    }
    if (!phone.isEmpty()) {
        query += " AND phone LIKE ?";
    }
    System.out.println(query);

    // Execute the query
    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement(query);

        int paramIndex = 1;

        // Set parameters for the prepared statement
        if (!lname.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + lname + "%");
            pstmt.setString(paramIndex++, "%" + lname + "%"); // For both lname and fname
        }
        if (!city.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + city + "%");
        }
        if (!state.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + state + "%");
        }
        if (!country.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + country + "%");
        }
        if (!pincode.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + pincode + "%");
        }
        if (!UID_NO.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + UID_NO + "%");
        }
        if (!phone.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + phone + "%");
        }

        rst = pstmt.executeQuery();

        // Prepare the response data as a JSON array
        JSONArray jsonResponse = new JSONArray();
        int iRow = 0;
        while (rst.next()) {
            JSONObject guest = new JSONObject();
            iRow++;
            guest.put("index", iRow);
            guest.put("guestid", rst.getInt("guestid"));
            guest.put("lname", rst.getString("lname"));
            guest.put("fname", rst.getString("fname"));
            guest.put("address1", rst.getString("address1"));
            guest.put("address2", rst.getString("address2"));
            guest.put("city", rst.getString("city"));
            guest.put("state", rst.getString("state"));
            guest.put("country", rst.getString("country"));
            guest.put("pincode", rst.getString("pincode"));
            guest.put("UID_type", rst.getString("UID_type"));
            guest.put("UID_NO", rst.getString("UID_NO"));
            guest.put("phone", rst.getString("phone"));
            guest.put("created_on", rst.getString("createdOn"));
            guest.put("created_by", rst.getString("u.fName"));
            jsonResponse.put(guest);
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
