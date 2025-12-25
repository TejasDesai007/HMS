<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
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

        String roomid = isBlankNull(request.getParameter("roomid"));

        PostgreSqlConnection dbc = new PostgreSqlConnection();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;

        String room_no = "";
        String room_type = "";
        String price_per_day = "";
        String room_dscrpt = "";

        if (!roomid.isEmpty()) {
            try {
                con = dbc.getConnection();
                pstmt = con.prepareStatement(
                        "SELECT room_no, room_type, price_per_day, room_dscrpt FROM rooms WHERE roomid = ?"
                );
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
        }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="js/JQuery.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet"/>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
        <script src="js/RoomDtls.js"></script>
        <script src="js/OnlyNumbers.js"></script>

        <jsp:include page="include/menu.jsp"/>
    </head>

    <body class="bg-success">
        <div class="container mt-5">
            <form id="frmRoomsDtls" action="RoomInsert" method="POST">

                <div class="card bg-light text-dark">
                    <div class="card-header text-center">
                        <h2>Insert Rooms Details</h2>
                    </div>

                    <div class="card-body">

                        <div class="row">
                            <div class="col-2">Room No:</div>
                            <div class="col-4">
                                <input type="text" id="txtRoomNo" name="txtRoomNo"
                                       class="form-control form-control-sm"
                                       value="<%=room_no%>"
                                       onkeydown="allowOnlyNumbers(event)"/>
                                <label class="text-danger d-none" id="lblValidateRooms">
                                    <small>The room already exists!</small>
                                </label>
                            </div>

                            <div class="col-2">Room Type:</div>
                            <div class="col-4">
                                <%
                                    try {
                                        dbc = new PostgreSqlConnection();
                                        con = dbc.getConnection();
                                        pstmt = con.prepareStatement(
                                                "SELECT type_id, type, type_price FROM roomstypesdetails"
                                        );
                                        rst = pstmt.executeQuery();
                                %>
                                <select id="slcRoomType" name="slcRoomType"
                                        class="form-select form-control-sm select2"
                                        onchange="setRoomPrice()">
                                    <option value="">Select Room Type</option>
                                    <%
                                        while (rst.next()) {
                                    %>
                                    <option value="<%=rst.getInt("type_id")%>"
                                            data-price="<%=rst.getBigDecimal("type_price")%>"
                                            <% if (room_type.equalsIgnoreCase(rst.getString("type"))) { %>selected<% }%>>
                                        <%=rst.getString("type")%> : <%=rst.getBigDecimal("type_price")%>
                                    </option>
                                    <% } %>
                                </select>
                                <%
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
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-2">Room Price:</div>
                            <div class="col-4">
                                <input type="text" id="txtRoomPrice" name="txtRoomPrice"
                                       class="form-control form-control-sm"
                                       value="<%=price_per_day%>"
                                       onkeydown="allowOnlyNumbersAndDecimal(event)"/>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-2">Room Description:</div>
                            <div class="col-10">
                                <textarea id="txtRoomdscrpt" name="txtRoomdscrpt"
                                          class="form-control" rows="4"><%=room_dscrpt%></textarea>
                            </div>
                        </div>

                        <div class="row justify-content-center mt-3">
                            <button type="submit" class="btn btn-success">
                                Submit <i class="fas fa-paper-plane"></i>
                            </button>
                            <input type="hidden" name="txtUserId" value="<%=strUserId%>"/>
                            <input type="hidden" name="txtRoomId" value="<%=isBlankNull(roomid)%>"/>
                        </div>

                    </div>
                </div>

            </form>
        </div>
    </body>
</html>

<% }%>
