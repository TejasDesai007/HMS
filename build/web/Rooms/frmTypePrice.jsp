<%@page import="com.MySqlConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.DBConnection"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="style/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="style/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/OnlyNumbers.js" type="text/javascript"></script>
        <script src="js/JQuery.js" type="text/javascript"></script>
        <script src="js/TypePrice.js" type="text/javascript"></script>
        <script src="js/DeleteType.js" type="text/javascript"></script>
        <jsp:include page="include/menu.jsp"/>
    </head>
    <body class="bg-success">
        <!-- Main Content with Bootstrap Card -->
        <div class="container mt-5">
            <form id="frmTypeP" action="InsertType" method="POST">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card bg-light text-dark">
                            <div class="card-header text-center">
                                <h4>Insert Rooms types and price Details</h4>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-2">
                                        <label for="txtRoomType">Room Type: </label>
                                    </div>
                                    <div class="col-4">
                                        <input type="text" id="txtRoomType"name="txtRoomType" class="form-control form-control-sm" placeholder="Enter Room Type"/>
                                    </div>
                                    <div class="col-2">
                                        <label for="txtTypePrice">Type price: </label>
                                    </div>
                                    <div class="col-4">
                                        <input type="text" id="txtTypePrice" name="txtTypePrice" class="form-control form-control-sm" placeholder="Enter Type price" onkeydown="allowOnlyNumbersAndDecimal(event)"/>
                                    </div>
                                </div>
                                <div class="row d-flex justify-content-center  mt-3" style="height:50px;">
                                    <div class="col-12 col-md-2">
                                        <button type="submit" class="btn btn-success">Submit <i class="fas fa-paper-plane"></i></button>
                                        <input type="text" id="txtUserId" class="d-none" name="txtUserId" value="<%=strUserId%>"/>
                                    </div>
                                </div>

                            </div>
                        </div>


                    </div>

                </div>
            </form>
        </div>

        <div class="container mt-5">
            <div class="row">
                <div class="col-md-12">
                    <div class="card bg-light text-dark">
                        <div class="card-header text-center">
                            <h4>Rooms types and price Details</h4>
                        </div>

                        <table class="table table-bordered table-striped">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col" class="text-center"></th>
                                    <th scope="col" class="text-center">Type</th>
                                    <th scope="col" class="text-center">Price</th>
                                    <th scope="col" class="text-center">CreatedBy</th>
                                </tr>
                            </thead>
                            <tbody >

                                <%
                                    MySqlConnection dbc;
                                    PreparedStatement pstmt = null;
                                    ResultSet rst = null;
                                    Connection con = null;
                                    try {
                                        dbc = new MySqlConnection();
                                        con = dbc.getConnection();
                                        pstmt = con.prepareStatement("select type_id, type, type_price, created_by,fname from roomstypesdetails rtp "
                                                + " join ("
                                                + " Select userid,fname from userdetails"
                                                + " )ud on ud.userid = rtp.created_by;", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                        rst = pstmt.executeQuery();

                                        if (rst.next()) {
                                            rst.beforeFirst();
                                            while (rst.next()) {
                                %>

                                <tr>
                                    <td class="text-center"><a><button onclick="DeleteType(<%=rst.getString("type_id")%>)" type="button" class="btn btn-primary btn-sm"><i class="fas fa-trash"></i></button></a></td>
                                    <td class="text-center"><%= rst.getString("type")%></td>
                                    <td class="text-center">&#8377;<%= rst.getDouble("type_price")%></td>
                                    <td class="text-center"><%= rst.getString("fname")%></td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>

                                <tr><h5>Heyy! nothings here</h5></tr>
                                <%
                                        }
                                    } catch (Exception ex) {
                                        ex.printStackTrace();
                                    } finally {
                                        con.close();
                                    }
                                %>
                            </tbody>
                        </table>


                    </div>
                </div>
            </div>
        </div>


    </body>
</html>
<%    }%>
