<%@page import="java.text.SimpleDateFormat"%>
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

    String lnamefname = isBlankNull(jsonInput.optString("g.lname"));
    String roomno = isBlankNull(jsonInput.optString("room_no"));
    String totalBill = isBlankNull(jsonInput.optString("total_bill"));
    String check_in = isBlankNull(jsonInput.optString("check_in"));
    String check_out = isBlankNull(jsonInput.optString("check_out"));
    String createdBy = isBlankNull(jsonInput.optString("ud.fname"));

    SimpleDateFormat inputFormat = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd");

    String condition = "";

    if (!lnamefname.isEmpty()) {
        condition += " AND (g.lname ILIKE '%" + lnamefname + "%' OR g.fname ILIKE '%" + lnamefname + "%') ";
    }
    if (!roomno.isEmpty()) {
        condition += " AND r.room_no = " + roomno + " ";
    }
    if (!totalBill.isEmpty()) {
        condition += " AND b.total_bill = " + totalBill + " ";
    }
    if (!check_in.isEmpty()) {
        condition += " AND b.check_in BETWEEN '" +
                outputFormat.format(inputFormat.parse(check_in)) +
                " 00:00:00' AND '" +
                outputFormat.format(inputFormat.parse(check_in)) +
                " 23:59:59' ";
    }
    if (!check_out.isEmpty()) {
        condition += " AND b.check_out BETWEEN '" +
                outputFormat.format(inputFormat.parse(check_out)) +
                " 00:00:00' AND '" +
                outputFormat.format(inputFormat.parse(check_out)) +
                " 23:59:59' ";
    }
    if (!createdBy.isEmpty()) {
        condition += " AND ud.fname ILIKE '%" + createdBy + "%' ";
    }

    try {
        // PostgreSQL FUNCTION call (NOT MySQL CALL)
        String sql = "SELECT * FROM get_bookings_dtls(?)";
        con = dbc.getConnection();
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, condition);

        rst = pstmt.executeQuery();

        JSONArray jsonResponse = new JSONArray();
        int iRow = 0;

        while (rst.next()) {
            JSONObject booking = new JSONObject();
            iRow++;

            booking.put("index", iRow);
            booking.put("bookingid", isBlankNull(rst.getString("bookingid")));
            booking.put("GuestName", isBlankNull(rst.getString("guestname")));
            booking.put("room_no", isBlankNull(rst.getString("room_no")));
            booking.put("totalBill", isBlankNull(rst.getString("total_bill")));
            booking.put("check_in", isBlankNull(rst.getString("check_in")));
            booking.put("check_out", isBlankNull(rst.getString("check_out")));
            booking.put("createdBy", isBlankNull(rst.getString("createdby")));

            jsonResponse.put(booking);
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
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
