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
        response.sendRedirect("login.jsp");
        session.removeAttribute("UserId");
    } else {

        String bookingid = isBlankNull(request.getParameter("bookingid"));

        PostgreSqlConnection dbc = new PostgreSqlConnection();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;

        String guest = "";
        String guestName = "";
        String roomno = "";
        String price_per_day = "";
        String noOfDays = "";
        String tax = "";
        String beverage = "";
        String totalAmt = "";

        if (!bookingid.isEmpty()) {
            try {
                con = dbc.getConnection();

                // 🔹 PostgreSQL function call
                pstmt = con.prepareStatement(
                        "SELECT * FROM get_bookings_dtls(?)"
                );
                pstmt.setString(1, " AND b.bookingid = " + bookingid);

                rst = pstmt.executeQuery();

                if (rst.next()) {
                    guest = rst.getString("guestname");
                    guestName = rst.getString("guestname");
                    roomno = rst.getString("room_no");
                    price_per_day = rst.getString("room_price");
                    noOfDays = rst.getString("booked_days");
                    tax = rst.getString("taxes");
                    beverage = rst.getString("beverages");
                    totalAmt = rst.getString("total_bill");
                }

            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error fetching booking details.");
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
        <script src="js/OnlyNumbers.js"></script>
        <script src="js/Bookings.js"></script>
        <jsp:include page="include/menu.jsp"/>
    </head>

    <body class="bg-success">
        <div class="container mt-5">
            <form id="frmBookingDtls" action="InsertBookings" method="POST">
                <div class="card bg-light">

                    <div class="card-header text-center">
                        <h2>Insert Booking Details</h2>
                    </div>

                    <div class="card-body">

                        <!-- Guest -->
                        <div class="row">
                            <div class="col-2">Guest:</div>
                            <div class="col-4">
                                <%
                                    if (!bookingid.isEmpty()) {
                                %>
                                <input class="form-control" value="<%=guestName%>" readonly/>
                                <%
                                } else {
                                    try {
                                        dbc = new PostgreSqlConnection();
                                        con = dbc.getConnection();
                                        pstmt = con.prepareStatement("SELECT guestid, fname, lname FROM guests");
                                        rst = pstmt.executeQuery();
                                %>
                                <select id="slcGuest" name="slcGuest" class="form-select select2">
                                    <option value="0">Select Guest</option>
                                    <%
                                        while (rst.next()) {
                                    %>
                                    <option value="<%=rst.getInt("guestid")%>">
                                        <%=rst.getString("fname")%> <%=rst.getString("lname")%>
                                    </option>
                                    <%
                                        }
                                    %>
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
                                    }
                                %>
                            </div>

                            <!-- Room -->
                            <div class="col-2">Room:</div>
                            <div class="col-4">
                                <%
                                    if (!bookingid.isEmpty()) {
                                %>
                                <input class="form-control" value="<%=roomno%>" readonly/>
                                <%
                                } else {
                                    try {
                                        dbc = new PostgreSqlConnection();
                                        con = dbc.getConnection();
                                        pstmt = con.prepareStatement(
                                                "SELECT roomid, room_no, room_type, price_per_day FROM rooms WHERE status = 'Unoccupied'"
                                        );
                                        rst = pstmt.executeQuery();
                                %>
                                <select id="slcRooms" name="slcRooms" class="form-select select2">
                                    <option value="0">Select Room</option>
                                    <%
                                        while (rst.next()) {
                                    %>
                                    <option value="<%=rst.getInt("roomid")%>"
                                            data-price="<%=rst.getBigDecimal("price_per_day")%>">
                                        <%=rst.getString("room_no")%> (<%=rst.getString("room_type")%>) :
                                        <%=rst.getBigDecimal("price_per_day")%>
                                    </option>
                                    <%
                                        }
                                    %>
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
                                    }
                                %>
                            </div>
                        </div>

                        <!-- Pricing -->
                        <div class="row mt-2">
                            <div class="col-2">Room Price:</div>
                            <div class="col-4">
                                <input class="form-control" id="txtRoomPrice" name="txtRoomPrice" value="<%=price_per_day%>"/>
                            </div>
                            <div class="col-2">Days:</div>
                            <div class="col-4">
                                <input class="form-control" id="txtStayDays" name="txtStayDays" value="<%=noOfDays%>"/>
                            </div>
                        </div>

                        <div class="row mt-2">
                            <div class="col-2">Tax:</div>
                            <div class="col-2">
                                <input class="form-control" id="txtTax" name="txtTax" value="<%=tax%>" readonly/>
                            </div>
                            <div class="col-2">Beverage:</div>
                            <div class="col-2">
                                <input class="form-control" id="txtBeverage" name="txtBeverage" value="<%=beverage%>"/>
                            </div>
                            <div class="col-2">Total:</div>
                            <div class="col-2">
                                <input class="form-control" id="txtTotalAmt" name="txtTotalAmt" value="<%=totalAmt%>" readonly/>
                            </div>
                        </div>

                        <div class="row mt-3 text-center">
                            <button class="btn btn-success" type="submit">Submit</button>
                            <input type="hidden" name="txtUserId" value="<%=strUserId%>"/>
                            <input type="hidden" name="txtBookingid" value="<%=bookingid%>"/>
                        </div>

                    </div>
                </div>
            </form>
        </div>
    </body>
</html>

<% }%>
