<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.PostgreSqlConnection"%>

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

    String roomNo = isBlankNull(request.getParameter("roomno"));

    try {
        if (roomNo.isEmpty()) {
            return;
        }

        con = dbc.getConnection();

        pstmt = con.prepareStatement(
                "SELECT roomid FROM rooms WHERE room_no = ?"
        );
        pstmt.setInt(1, Integer.parseInt(roomNo));

        rst = pstmt.executeQuery();

        if (rst.next()) {
            out.println("Exist");
        }

    } catch (Exception ex) {
        out.println("Error in ValidateRoomNo.jsp >> " + ex.getMessage());
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
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
