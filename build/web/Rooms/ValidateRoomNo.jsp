<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.MySqlConnection"%>
<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>
<%
    MySqlConnection dbc = new MySqlConnection();
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rst = null;
    String roomNo = request.getParameter("roomno");

    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement("Select roomid from rooms where room_no = ?");
        pstmt.setString(1, roomNo);
        System.out.println("Select roomid from rooms where room_no = " + roomNo + "");
        rst = pstmt.executeQuery();
        if (rst.next()) {
            System.out.println("exist");
            out.println("Exist");
        } else {

        }
    } catch (Exception ex) {
        out.println("Error in ValidateRoomNo.jsp >> " + ex.getMessage());
    }
%>
