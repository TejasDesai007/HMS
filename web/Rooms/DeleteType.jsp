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

    String typeid = isBlankNull(request.getParameter("typeid"));

    try {
        if (typeid.isEmpty()) {
            out.println("Type ID is required.");
            return;
        }

        con = dbc.getConnection();

        pstmt = con.prepareStatement(
            "DELETE FROM roomstypesdetails WHERE type_id = ?"
        );
        pstmt.setInt(1, Integer.parseInt(typeid));

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Deleted Successfully!");
        } else {
            out.println("No record found with the given type ID.");
        }

    } catch (SQLException ex) {

        // PostgreSQL foreign-key violation SQLSTATE
        if ("23503".equals(ex.getSQLState())) {
            out.println("Cannot delete: The type is used in Rooms Details.");
        } else {
            out.println("Error occurred: " + ex.getMessage());
        }

    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (Exception e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
