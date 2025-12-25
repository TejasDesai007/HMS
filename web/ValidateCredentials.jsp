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

    String strUserName = isBlankNull(request.getParameter("txtUserNm"));
    String strPassword = isBlankNull(request.getParameter("txtPassword"));

    try {
        con = dbc.getConnection();

        // PostgreSQL: remove BINARY (case-sensitive by default)
        pstmt = con.prepareStatement(
                "SELECT userid, fname FROM userdetails WHERE username = ? AND password = ?"
        );
        pstmt.setString(1, strUserName);
        pstmt.setString(2, strPassword);

        rst = pstmt.executeQuery();

        if (rst.next()) {
            session.setAttribute("UserId", rst.getString("userid"));
            session.setAttribute("UserName", rst.getString("fname"));
            response.sendRedirect("Home");
        } else {
            response.sendRedirect("Login");
        }

    } catch (Exception ex) {
        out.println("Error in ValidateCredentials.jsp >> " + ex.getMessage());
    } finally {
        if (rst != null) {
            rst.close();
        }
        if (pstmt != null) {
            pstmt.close();
        }
        if (con != null) {
            con.close();
        }
    }
%>
