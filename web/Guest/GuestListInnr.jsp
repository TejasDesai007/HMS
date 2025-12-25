<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.PostgreSqlConnection"%>
<%@page import="org.json.JSONObject"%> 
<%@page import="org.json.JSONArray"%>  
<%@page contentType="application/json" pageEncoding="UTF-8"%>

<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>

<%
    PostgreSqlConnection dbc = new PostgreSqlConnection();
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rst = null;

    String jsonData = request.getReader().lines()
            .collect(java.util.stream.Collectors.joining());
    JSONObject jsonInput = new JSONObject(jsonData);

    String lname = isBlankNull(jsonInput.optString("lname"));
    String city = isBlankNull(jsonInput.optString("city"));
    String state = isBlankNull(jsonInput.optString("state"));
    String country = isBlankNull(jsonInput.optString("country"));
    String pincode = isBlankNull(jsonInput.optString("pincode"));
    String UID_NO = isBlankNull(jsonInput.optString("UID_NO"));
    String phone = isBlankNull(jsonInput.optString("phone"));

    // PostgreSQL query (DATE_FORMAT → TO_CHAR, LIKE → ILIKE)
    String query =
        "SELECT g.guestid, g.lname, g.fname, g.address1, g.address2, g.city, g.state, g.country, " +
        "g.pincode, g.uid_type, g.uid_no, g.phone, " +
        "TO_CHAR(g.created_on, 'DD-MM-YYYY') AS createdon, u.fname AS created_by " +
        "FROM guests g " +
        "JOIN userdetails u ON u.userid = g.created_by " +
        "WHERE 1=1 ";

    if (!lname.isEmpty()) {
        query += " AND (g.lname ILIKE ? OR g.fname ILIKE ?)";
    }
    if (!city.isEmpty()) {
        query += " AND g.city ILIKE ?";
    }
    if (!state.isEmpty()) {
        query += " AND g.state ILIKE ?";
    }
    if (!country.isEmpty()) {
        query += " AND g.country ILIKE ?";
    }
    if (!pincode.isEmpty()) {
        query += " AND g.pincode::TEXT ILIKE ?";
    }
    if (!UID_NO.isEmpty()) {
        query += " AND g.uid_no ILIKE ?";
    }
    if (!phone.isEmpty()) {
        query += " AND g.phone ILIKE ?";
    }

    query += " ORDER BY g.created_on DESC";

    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement(query);

        int paramIndex = 1;

        if (!lname.isEmpty()) {
            pstmt.setString(paramIndex++, "%" + lname + "%");
            pstmt.setString(paramIndex++, "%" + lname + "%");
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
            guest.put("UID_type", rst.getString("uid_type"));
            guest.put("UID_NO", rst.getString("uid_no"));
            guest.put("phone", rst.getString("phone"));
            guest.put("created_on", rst.getString("createdon"));
            guest.put("created_by", rst.getString("created_by"));

            jsonResponse.put(guest);
        }

        response.getWriter().write(jsonResponse.toString());

    } catch (Exception ex) {
        ex.printStackTrace();
        response.getWriter().write("[]");
    } finally {
        try {
            if (rst != null) rst.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
%>
