<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.MySqlConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page!!!!!!!!!!!</title>
    </head>
    <body>
        <h1>Hello here </h1>
        <%
            MySqlConnection dbc = new MySqlConnection();
            Connection con = null;
            PreparedStatement pstmt = null;
            ResultSet rst = null;
            try {
                dbc = new MySqlConnection();
                con = dbc.getConnection();
                out.println("Connection String : " + String.valueOf(con));
            } catch (Exception ex) {
                out.println("Error : " + ex.getMessage());
            }
        %>
    </body>
</html>
