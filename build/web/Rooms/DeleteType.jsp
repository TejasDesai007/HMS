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
    String typeid = isBlankNull(request.getParameter("typeid"));

    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement("DELETE FROM roomstypesdetails WHERE type_id = ?");
        pstmt.setString(1, typeid);

        int rowsAffected = pstmt.executeUpdate(); // Use executeUpdate to execute the DELETE query
        if (rowsAffected > 0) {
            out.println("Deleted Successfully!");
        } else {
            out.println("No record found with the given type ID.");
        }

    } catch (SQLException ex) {
        // Check for foreign key constraint violation or other specific errors
        if (ex.getMessage().toLowerCase().contains("foreign key constraint fails")) {
            out.println("Cannot delete: The type is used in Rooms Details.");
        } else {
            out.println("Error occurred: " + ex.getMessage());
        }
    } finally {
        // Ensure resources are closed properly
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
