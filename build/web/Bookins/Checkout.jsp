<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
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
    String bookingid = isBlankNull(request.getParameter("bookingid"));

    try {
        con = dbc.getConnection();
        con.setAutoCommit(false);

        // ? Update checkout time (NOW() ? CURRENT_TIMESTAMP)
        pstmt = con.prepareStatement(
            "UPDATE bookings SET check_out = CURRENT_TIMESTAMP WHERE bookingid = ?"
        );
        pstmt.setInt(1, Integer.parseInt(bookingid));
        pstmt.executeUpdate();
        pstmt.close();

        // ? Free the room
        pstmt = con.prepareStatement(
            "UPDATE rooms SET status = 'Unoccupied' " +
            "WHERE roomid = (SELECT roomid FROM bookings WHERE bookingid = ?)"
        );
        pstmt.setInt(1, Integer.parseInt(bookingid));
        pstmt.executeUpdate();
        pstmt.close();

        con.commit();

        response.sendRedirect("BookingsList");

    } catch (Exception ex) {
        if (con != null) {
            try { con.rollback(); } catch (Exception e) { e.printStackTrace(); }
        }
        out.println("Error occurred: " + ex.getMessage());

    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
