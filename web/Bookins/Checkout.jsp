<%@page import="java.sql.SQLException"%>
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
    String bookingid = isBlankNull(request.getParameter("bookingid"));

    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement("update bookings set check_out = now() where bookingid= ?");
        pstmt.setString(1, bookingid);
        pstmt.executeUpdate();
        pstmt.close();
        
        pstmt = con.prepareStatement("update rooms set status='Unoccupied' where roomid in (select roomid from bookings where bookingid= ?)");
        pstmt.setString(1, bookingid);
        pstmt.executeUpdate();
        pstmt.close();
        response.sendRedirect("BookingsList");
    } catch (SQLException ex) {
        // Check for foreign key constraint violation or other specific errors

        out.println("Error occurred: " + ex.getMessage());

    } finally {
        // Ensure resources are closed properly
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }

%>
