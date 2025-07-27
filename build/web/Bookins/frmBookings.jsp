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
        response.sendRedirect("login.jsp");
        session.removeAttribute("UserId");
    } else {
        String bookingid = isBlankNull(request.getParameter("bookingid"));
        MySqlConnection dbc = new MySqlConnection();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        String guest = "";
        String guestName = "";
        String roomno = "";
        String price_per_day = "";
        String noOfDays = "";
        String tax = "";
        String taxPer = "";
        String beverage = "";
        String totalAmt = "";
        if (bookingid != null && !bookingid.trim().isEmpty()) {
            try {
                con = dbc.getConnection();

                pstmt = con.prepareStatement("Call GetBookingsDtls(' ANd bookingid = " + bookingid + " ')");

                rst = pstmt.executeQuery();

                if (rst.next()) {
                    guest = rst.getString("guestid");
                    guestName = rst.getString("GuestName");
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
                try {
                    if (rst != null) {
                        rst.close();
                    }
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (con != null) {
                        con.close();
                    }
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
        <script src="js/OnlyNumbers.js" type="text/javascript"></script>
        <script src="js/Bookings.js?v=05122024600" type="text/javascript"></script>
        <jsp:include page="include/menu.jsp"/>
    </head>
    <body class="bg-success">
        <!-- Main Content with Bootstrap Card -->
        <div class="container mt-5">
            <form id="frmBookingDtls" action="InsertBookings" method="POST">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card bg-light text-dark">
                            <div class="card-header text-center">
                                <h2>Insert Booking Details</h2>
                            </div>
                            <div class="card-body">
                                <div class="row">

                                    <div class="col-2">
                                        <label for="slcGuest">Guest: </label>
                                    </div>
                                    <div class="col-4">
                                        <%
                                            if (bookingid != null && !bookingid.trim().isEmpty()) {
                                        %>
                                        <input type="text" id="txtGuestName" name="txtGuestName" class="form-control form-control-sm" value="<%=guestName%>" placeholder="Enter Days Stay" readonly onkeydown="allowOnlyNumbers(event)"/>
                                        <%
                                        } else {
                                            try {
                                                dbc = new MySqlConnection();
                                                con = dbc.getConnection();
                                                pstmt = con.prepareStatement("Select * from guests", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                                rst = pstmt.executeQuery();
                                        %>
                                        <select id="slcGuest" name="slcGuest" class="form-control-sm form-select select2" >
                                            <option value="0">Select Guest</option> <!-- Default option -->
                                            <%
                                                while (rst.next()) {
                                            %>
                                            <option value="<%= rst.getString("guestid")%>"  <%if (rst.getString("guestid").equals(guest)) {%>selected<%}%> >
                                                <%= rst.getString("fname")%> <%= rst.getString("lname")%>
                                            </option>
                                            <% } %>
                                        </select>
                                        <span id="errGuest" class="text-danger error-message"></span> 

                                        <%
                                                    rst.close();
                                                    pstmt.close();

                                                } catch (Exception e) {
                                                    e.printStackTrace();
                                                    out.println("Error while loading room type");
                                                } finally {

                                                    con.close();

                                                }
                                            }
                                        %>

                                    </div>
                                    <div class="col-2">
                                        <label for="slcRooms">Room: </label>
                                    </div>
                                    <div class="col-4">
                                        <%
                                            if (bookingid != null && !bookingid.trim().isEmpty()) {
                                        %>
                                        <input type="text" id="txtRoomNo" name="txtRoomNo" class="form-control form-control-sm" value="<%=roomno%>" placeholder="Enter Days Stay" readonly onkeydown="allowOnlyNumbers(event)"/>
                                        <%
                                        } else {
                                            try {
                                                dbc = new MySqlConnection();
                                                con = dbc.getConnection();
                                                pstmt = con.prepareStatement("Select * from rooms where status = 'Unoccupied'", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                                                rst = pstmt.executeQuery();
                                        %>
                                        <select id="slcRooms" name="slcRooms" class="form-control-sm form-select select2" >
                                            <option value="0">Select Room</option> <!-- Default option -->
                                            <%
                                                while (rst.next()) {
                                            %>
                                            <option value="<%= rst.getString("roomid")%>" data-price="<%= rst.getInt("price_per_day")%>"  <%if (rst.getString("roomid").equals(roomno)) {%>Selected<%}%>>
                                                <%= rst.getString("room_no")%>(<%= rst.getString("room_type")%>) : <%= rst.getInt("price_per_day")%>&#8377;
                                            </option>
                                            <% } %>
                                        </select>
                                        <span id="errRoom" class="text-danger error-message"></span>
                                        <%
                                                    rst.close();
                                                    pstmt.close();
                                                } catch (Exception e) {
                                                    e.printStackTrace();
                                                    out.println("Error while loading room type");
                                                } finally {

                                                    con.close();

                                                }

                                            }

                                        %>
                                    </div>

                                </div>
                                <div class="row mt-2">
                                    <div class="col-2">
                                        <label for="txtRoomPrice">Room Price per day: </label>
                                    </div>
                                    <div class="col-4">
                                        <input type="text" id="txtRoomPrice" name="txtRoomPrice" class="form-control form-control-sm" value="<%=price_per_day%>" placeholder="Enter Room Price" onkeydown="allowOnlyNumbersAndDecimal(event)"/>
                                        <span id="errRoomPrice" class="text-danger error-message"></span>
                                    </div>
                                    <div class="col-2">
                                        <label for="txtStayDays">Number of days: </label>
                                    </div>
                                    <div class="col-4">
                                        <input type="text" id="txtStayDays" name="txtStayDays" class="form-control form-control-sm" value="<%=noOfDays%>" placeholder="Enter Days Stay" onkeydown="allowOnlyNumbers(event)"/>
                                        <span id="errStayDays" class="text-danger error-message"></span>
                                    </div>
                                </div>
                                <div class="row mt-2">
                                    <div class="col-2">
                                        <label for="txtTaxPrc">Tax(%): </label>
                                    </div>
                                    <div class="col-1">
                                        <input type="text" id="txtTaxPrc" name="txtTaxPrc" class="form-control form-control-sm" value="" placeholder="%" onkeydown="allowOnlyNumbersAndDecimal(event)"/>
                                        <span id="errTaxPrc" class="text-danger error-message"></span>
                                    </div>
                                    <div class="col-2">
                                        <label for="txtTax">Tax(&#8377;): </label>
                                    </div>
                                    <div class="col-2">
                                        <input type="text" readonly id="txtTax" name="txtTax" class="form-control form-control-sm" value="<%=tax%>" placeholder="Tax in &#8377;" onkeydown="allowOnlyNumbersAndDecimal(event)"/>
                                        <span id="errTax" class="text-danger error-message"></span>
                                    </div>
                                    <div class="col-2">
                                        <label for="txtBeverage">Beverages: </label>
                                    </div>
                                    <div class="col-2">
                                        <input type="text" id="txtBeverage" name="txtBeverage" class="form-control form-control-sm" value="<%=beverage%>" placeholder="Enter if any Beverages" onkeydown="allowOnlyNumbersAndDecimal(event)"/>

                                    </div>

                                </div>
                                <div class="row mt-2">
                                    <div class="col-2">
                                        <label for="txtTotalAmt">Total Amount: </label>
                                    </div>
                                    <div class="col-2">
                                        <input type="text" readonly id="txtTotalAmt" name="txtTotalAmt" class="form-control form-control-sm" value="<%=totalAmt%>" placeholder="Total Amount" onkeydown="allowOnlyNumbersAndDecimal(event)"/>

                                    </div>

                                </div>
                                <div class="row mt-2"></div>
                                <div class="row d-flex justify-content-center mt-3" style="height:50px;">
                                    <div class="col-12 col-md-2">
                                        <button type="submit" class="btn btn-success ">Submit <i class="fas fa-paper-plane"></i></button>
                                        <input type="text" id="txtUserId"  class="d-none" name="txtUserId" value="<%= strUserId%>"/>
                                        <input type="text"  id="txtBookingid" class="d-none" name="txtBookingid" value="<%= isBlankNull(bookingid)%>">

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
