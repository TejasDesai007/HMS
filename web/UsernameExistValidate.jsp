<%@page import="java.sql.*"%>
<%@page import="com.MySqlConnection"%>
<%
    MySqlConnection dbc = new MySqlConnection();
    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rst = null;
    String strUserName = request.getParameter("username");

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");

    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement("SELECT UserId, fname FROM userdetails WHERE BINARY UserName = ?");
        pstmt.setString(1, strUserName);

        rst = pstmt.executeQuery();

        if (rst.next()) {
            response.getWriter().write("{\"status\":\"Invalid\"}");
        } else {
            response.getWriter().write("{\"status\":\"Valid\"}");
        }
    } catch (Exception ex) {
        response.getWriter().write("{\"status\":\"Error\",\"message\":\"" + ex.getMessage() + "\"}");
    } finally {
        if (rst != null) rst.close();
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    }
%>
