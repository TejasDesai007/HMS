<%@page import="java.sql.SQLException"%>
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

    String bookingid = isBlankNull(request.getParameter("bookingid"));

    try {
        // Validate bookingid
        if (bookingid.isEmpty()) {
            out.println("Booking ID is required.");
            return;
        }

        con = dbc.getConnection();
        con.setAutoCommit(false);

        // ? Check checkout status
        pstmt = con.prepareStatement(
            "SELECT check_out FROM bookings WHERE bookingid = ?"
        );
        pstmt.setInt(1, Integer.parseInt(bookingid));
        rst = pstmt.executeQuery();

        if (rst.next()) {
            String strCheckout = rst.getString("check_out");

            if (isBlankNull(strCheckout).isEmpty()) {
                out.println("Cannot delete the booking as the guest has not checked out.");
            } else {
                rst.close();
                pstmt.close();

                // ? Delete booking (PostgreSQL table name lowercase)
                pstmt = con.prepareStatement(
                    "DELETE FROM bookings WHERE bookingid = ?"
                );
                pstmt.setInt(1, Integer.parseInt(bookingid));

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("Booking deleted successfully!");
                } else {
                    out.println("No booking found with the given Booking ID.");
                }

                con.commit();
            }
        } else {
            out.println("No booking found with the given Booking ID.");
        }

    } catch (Exception ex) {
        if (con != null) {
            try { con.rollback(); } catch (Exception e) { e.printStackTrace(); }
        }
        out.println("Error occurred: " + ex.getMessage());

    } finally {
        try {
            if (rst != null) rst.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
