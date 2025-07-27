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
        String roomid = isBlankNull(request.getParameter("roomid"));
        MySqlConnection dbc = new MySqlConnection();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        String room_no = "";
        String room_type = "";
        String price_per_day = "";
        String room_dscrpt = "";

        if (roomid != null && !roomid.trim().isEmpty()) {
            try {
                con = dbc.getConnection();
                // Query to fetch room details based on roomid
                pstmt = con.prepareStatement("SELECT * FROM rooms WHERE roomid = ?");
                pstmt.setInt(1, Integer.parseInt(roomid));
                rst = pstmt.executeQuery();

                if (rst.next()) {
                    room_no = rst.getString("room_no");
                    room_type = rst.getString("room_type");
                    price_per_day = rst.getString("price_per_day");
                    room_dscrpt = rst.getString("room_dscrpt");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error fetching room details.");
            } finally {
                try {
                    if (rst != null) rst.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link href="style/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="style/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/JQuery.js" type="text/javascript"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
        <script src="js/RoomDtls.js?v=03122024074234" type="text/javascript"></script>
        <script src="js/OnlyNumbers.js" type="text/javascript"></script>

        <jsp:include page="include/menu.jsp"/>
    </head>
    <body class="bg-success">
        <!-- Main Content with Bootstrap Card -->
        <div class="container mt-5">
            <form id="frmRoomsDtls" action="RoomInsert" method="POST">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card bg-light text-dark">
                            <div class="card-header text-center">
                                <h2>Insert Rooms Details</h2>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-2">
                                        <label for="txtRoomNo">Room No: </label>
                                    </div>
                                    <div class="col-4">
                                        <input type="text" id="txtRoomNo" name="txtRoomNo" class="form-control form-control-sm" value="<%=room_no%>" placeholder="Enter Room No" onkeydown="allowOnlyNumbers(event)"/>
                                        <label class="text-danger d-none" id="lblValidateRooms"><samll>The room already exist!</samll></label>
                                    </div>
                                    <div class="col-2">
                                        <label for="slcRoomType">Room Type: </label>
                                    </div>
                                    <div class="col-4">
                                        <%
                                            
                                            try {
                                                dbc = new MySqlConnection();
                                                con = dbc.getConnection();
                                                pstmt = con.prepareStatement("Select * from roomstypesdetails", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                                rst = pstmt.executeQuery();
                                        %>
                                        <select id="slcRoomType" name="slcRoomType" class="form-control-sm form-select select2" onchange="setRoomPrice()">
                                            <option value="">Select Room Type</option> <!-- Default option -->
                                            <%
                                                while (rst.next()) {
                                            %>
                                            <option value="<%= rst.getString("type_id")%>" data-price="<%= rst.getString("type_price")%>" <%if(room_type.equalsIgnoreCase(rst.getString("type"))){%>selected<%}%> >
                                                <%= rst.getString("type")%> : <%= rst.getString("type_price")%>
                                            </option>
                                            <% } %>
                                        </select>
                                        <%
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                                out.println("Error while loading room type");
                                            }
                                        %>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-2">
                                        <label for="txtRoomPrice">Room Price: </label>
                                    </div>
                                    <div class="col-4">
                                        <input type="text" id="txtRoomPrice" name="txtRoomPrice" class="form-control form-control-sm" value="<%=price_per_day%>" placeholder="Enter Room Price" onkeydown="allowOnlyNumbersAndDecimal(event)"/>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-2">
                                        <label for="txtRoomdscrpt">Room Description: </label>
                                    </div>
                                    <div class="col-10">
                                        <textarea class="form-control" id="txtRoomdscrpt" name="txtRoomdscrpt" rows="4" placeholder="Enter Description"><%=room_dscrpt%></textarea>
                                    </div>

                                </div>
                                <div class="row mt-2"></div>
                                <div class="row d-flex justify-content-center mt-3" style="height:50px;">
                                    <div class="col-12 col-md-2">
                                        <button type="submit" class="btn btn-success ">Submit <i class="fas fa-paper-plane"></i></button>
                                        <input type="text" id="txtUserId"  class="d-none" name="txtUserId" value="<%= strUserId%>"/>
                                        <input type="text" id="txtRoomId" class="d-none" name="txtRoomId" value="<%= isBlankNull(roomid)%>">

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
<% }%>
