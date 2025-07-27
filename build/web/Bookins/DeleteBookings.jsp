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
    ResultSet rst = null;
    String bookingid = isBlankNull(request.getParameter("bookingid"));

    try {
        // Ensure bookingid is not empty
        if (bookingid.isEmpty()) {
            out.println("Booking ID is required.");
            return;
        }

        con = dbc.getConnection();

        // Check if the booking exists and if the guest has checked out
        pstmt = con.prepareStatement("SELECT check_out FROM bookings WHERE bookingid = ?");
        pstmt.setString(1, bookingid);
        rst = pstmt.executeQuery();

        if (rst.next()) {
            String strCheckout = rst.getString("check_out");
            if (isBlankNull(strCheckout).equalsIgnoreCase("")) {
                out.println("Cannot delete the booking as the guest has not checked out.");
            } else {
                // Proceed with the deletion if the guest has checked out
                pstmt = con.prepareStatement("DELETE FROM Bookings WHERE bookingid = ?");
                pstmt.setString(1, bookingid);

                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("Booking deleted successfully!");
                } else {
                    out.println("No booking found with the given Booking ID.");
                }
            }
        } else {
            out.println("No booking found with the given Booking ID.");
        }
    } catch (SQLException ex) {
        out.println("Error occurred: " + ex.getMessage());
    } finally {
        // Ensure that resources are properly closed
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
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
