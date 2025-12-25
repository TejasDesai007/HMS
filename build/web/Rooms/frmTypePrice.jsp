<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.PostgreSqlConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>

<%
    String strUserId = String.valueOf(session.getAttribute("UserId"));
    if ("".equals(isBlankNull(strUserId)) || "null".equalsIgnoreCase(strUserId)) {
        response.sendRedirect("Login");
        session.removeAttribute("UserId");
    } else {
%>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="js/OnlyNumbers.js"></script>
        <script src="js/JQuery.js"></script>
        <script src="js/TypePrice.js"></script>
        <script src="js/DeleteType.js"></script>
        <jsp:include page="include/menu.jsp"/>
    </head>

    <body class="bg-success">

        <div class="container mt-5">
            <form id="frmTypeP" action="InsertType" method="POST">
                <div class="card bg-light text-dark">
                    <div class="card-header text-center">
                        <h4>Insert Rooms Types and Price Details</h4>
                    </div>
                    <div class="card-body">

                        <div class="row">
                            <div class="col-2">Room Type:</div>
                            <div class="col-4">
                                <input type="text" id="txtRoomType" name="txtRoomType"
                                       class="form-control form-control-sm"
                                       placeholder="Enter Room Type"/>
                            </div>
                            <div class="col-2">Type Price:</div>
                            <div class="col-4">
                                <input type="text" id="txtTypePrice" name="txtTypePrice"
                                       class="form-control form-control-sm"
                                       placeholder="Enter Type price"
                                       onkeydown="allowOnlyNumbersAndDecimal(event)"/>
                            </div>
                        </div>

                        <div class="row justify-content-center mt-3">
                            <div class="col-md-2 text-center">
                                <button type="submit" class="btn btn-success">
                                    Submit <i class="fas fa-paper-plane"></i>
                                </button>
                                <input type="hidden" name="txtUserId" value="<%=strUserId%>"/>
                            </div>
                        </div>

                    </div>
                </div>
            </form>
        </div>

        <!-- LIST SECTION -->
        <div class="container mt-5">
            <div class="card bg-light text-dark">
                <div class="card-header text-center">
                    <h4>Rooms Types and Price Details</h4>
                </div>

                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th class="text-center"></th>
                            <th class="text-center">Type</th>
                            <th class="text-center">Price</th>
                            <th class="text-center">Created By</th>
                        </tr>
                    </thead>
                    <tbody>

                        <%
                            PostgreSqlConnection dbc;
                            Connection con = null;
                            PreparedStatement pstmt = null;
                            ResultSet rst = null;

                            try {
                                dbc = new PostgreSqlConnection();
                                con = dbc.getConnection();

                                pstmt = con.prepareStatement(
                                        "SELECT rtp.type_id, rtp.type, rtp.type_price, ud.fname "
                                        + "FROM roomstypesdetails rtp "
                                        + "JOIN userdetails ud ON ud.userid = rtp.created_by"
                                );

                                rst = pstmt.executeQuery();

                                boolean hasData = false;
                                while (rst.next()) {
                                    hasData = true;
                        %>
                        <tr>
                            <td class="text-center">
                                <button onclick="DeleteType(<%=rst.getInt("type_id")%>)"
                                        type="button"
                                        class="btn btn-primary btn-sm">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </td>
                            <td class="text-center"><%=rst.getString("type")%></td>
                            <td class="text-center">&#8377; <%=rst.getBigDecimal("type_price")%></td>
                            <td class="text-center"><%=rst.getString("fname")%></td>
                        </tr>
                        <%
                            }

                            if (!hasData) {
                        %>
                        <tr>
                            <td colspan="4" class="text-center">Heyy! nothing’s here</td>
                        </tr>
                        <%
                                }

                            } catch (Exception ex) {
                                ex.printStackTrace();
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

                    </tbody>
                </table>
            </div>
        </div>

    </body>
</html>
<% }%>
