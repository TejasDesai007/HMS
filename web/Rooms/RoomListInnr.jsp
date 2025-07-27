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
    String roomNo = isBlankNull(jsonInput.optString("room_no"));
    String roomType = isBlankNull(jsonInput.optString("room_type"));
    String roomDesc = isBlankNull(jsonInput.optString("room_dscrpt"));

    // Prepare the SQL query with filters
    String query = "SELECT roomid, room_no, status, room_type, price_per_day, room_dscrpt, DATE_FORMAT(created_on, '%d-%m-%Y') AS createdOn,u.fName as created_by FROM rooms r  "
            + " inner join ( "
            + " Select userid,fName from userdetails "
            + " )u on u.userid = r.created_by "
            + "  WHERE 1=1 ";

    if (!roomNo.isEmpty()) {
        query += " AND room_no LIKE ?";
    }
    if (!roomType.isEmpty()) {
        query += " AND room_type LIKE ?";
    }
    if (!roomDesc.isEmpty()) {
        query += " AND room_dscrpt LIKE ?";
    }

    // Execute the query
    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement(query);

        int paramIndex = 1;

        // Set parameters for the prepared statement
        if (!roomNo.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + roomNo + "%");
        }
        if (!roomType.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + roomType + "%");
        }
        if (!roomDesc.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + roomDesc + "%");
        }

        rst = pstmt.executeQuery();

        // Prepare the response data as a JSON array
        JSONArray jsonResponse = new JSONArray();
        int iRow = 0;
        while (rst.next()) {
            JSONObject room = new JSONObject();
            iRow++;
            room.put("index", iRow);
            room.put("roomid", rst.getInt("roomid"));
            room.put("room_no", rst.getString("room_no"));
            room.put("status", rst.getString("status"));
            room.put("room_type", rst.getString("room_type"));
            room.put("price_per_day", rst.getDouble("price_per_day"));
            room.put("room_dscrpt", rst.getString("room_dscrpt"));
            room.put("created_on", rst.getString("createdOn"));
            room.put("created_by", rst.getString("created_by"));
            jsonResponse.put(room);
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
