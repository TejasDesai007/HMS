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
    String strUserName = isBlankNull(request.getParameter("txtUserNm"));
    String strPassword = isBlankNull(request.getParameter("txtPassword"));
    try {
        con = dbc.getConnection();
        pstmt = con.prepareStatement("select UserId,fname from userdetails where BINARY UserName = ? and BINARY Password = ?");
        pstmt.setString(1, strUserName);
        pstmt.setString(2, strPassword);

        rst = pstmt.executeQuery();
        if (rst.next()) {
//            System.out.println("select UserId,fname from userdetails where BINARY UserName = '" + strUserName + "' and BINARY Password = '" + strPassword + "'");
            session.setAttribute("UserId", "" + rst.getString("UserId") + "");
            session.setAttribute("UserName", "" + rst.getString("fname") + "");
            response.sendRedirect("Home");
        } else {
            response.sendRedirect("Login");
        }
    } catch (Exception ex) {
        out.println("Error in ValidateCredentials.jsp >> " + ex.getMessage());
    }
%>
