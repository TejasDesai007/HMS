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

    String roomNo = isBlankNull(jsonInput.optString("room_no"));
    String roomType = isBlankNull(jsonInput.optString("room_type"));
    String roomDesc = isBlankNull(jsonInput.optString("room_dscrpt"));

    // PostgreSQL query (DATE_FORMAT → TO_CHAR, LIKE → ILIKE)
    String query
            = "SELECT r.roomid, r.room_no, r.status, r.room_type, r.price_per_day, "
            + "r.room_dscrpt, TO_CHAR(r.created_on, 'DD-MM-YYYY') AS created_on, "
            + "u.fname AS created_by "
            + "FROM rooms r "
            + "JOIN userdetails u ON u.userid = r.created_by "
            + "WHERE 1=1 ";

    if (!roomNo.isEmpty()) {
        query += " AND r.room_no::TEXT ILIKE ?";
    }
    if (!roomType.isEmpty()) {
        query += " AND r.room_type ILIKE ?";
    }
    if (!roomDesc.isEmpty()) {
        query += " AND r.room_dscrpt ILIKE ?";
    }

    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement(query);

        int paramIndex = 1;

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
            room.put("price_per_day", rst.getBigDecimal("price_per_day"));
            room.put("room_dscrpt", rst.getString("room_dscrpt"));
            room.put("created_on", rst.getString("created_on"));
            room.put("created_by", rst.getString("created_by"));

            jsonResponse.put(room);
        }

        response.getWriter().write(jsonResponse.toString());

    } catch (Exception ex) {
        ex.printStackTrace();
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
