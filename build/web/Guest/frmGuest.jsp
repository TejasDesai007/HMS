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
        String guestId = isBlankNull(request.getParameter("guestid"));
        MySqlConnection dbc = new MySqlConnection();
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rst = null;
        String lname = "";
        String fname = "";
        String address1 = "";
        String address2 = "";
        String city = "";
        String state = "";
        String country = "";
        String pincode = "";
        String UID_type = "";
        String UID_NO = "";
        String phone = "";

        if (guestId != null && !guestId.trim().isEmpty()) {
            try {

                con = dbc.getConnection();
                pstmt = con.prepareStatement("SELECT * FROM guests WHERE guestid = ?");
                pstmt.setInt(1, Integer.parseInt(guestId));
                rst = pstmt.executeQuery();
                if (rst.next()) {
                    lname = rst.getString("lname");
                    fname = rst.getString("fname");
                    address1 = rst.getString("address1");
                    address2 = rst.getString("address2");
                    city = rst.getString("city");
                    state = rst.getString("state");
                    country = rst.getString("country");
                    pincode = rst.getString("pincode");
                    UID_type = rst.getString("UID_type");
                    UID_NO = rst.getString("UID_NO");
                    phone = rst.getString("phone");
                    System.out.println(lname);

                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error fetching guest details.");
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
        <script src="js/RoomDtls.js?v=03122024074234" type="text/javascript"></script>
        <script src="js/OnlyNumbers.js" type="text/javascript"></script>
        <script src="js/Guest.js" type="text/javascript"></script>
        <jsp:include page="include/menu.jsp"/>
    </head>
    <body class="bg-success">
        <!-- Main Content with Bootstrap Card -->
        <div class="container mt-5">
            <form id="frmGuestDtls" action="InsertGuest" method="POST">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card bg-light text-dark">
                            <div class="card-header text-center">
                                <h2>Insert Guests Details</h2>
                            </div>
                            <div class="card-body">
                                <div class="row mb-3">
                                    <div class="col-6">
                                        <label for="txtLName">Last Name:</label>
                                        <input type="text" id="txtLName" name="txtLName" class="form-control form-control-sm" placeholder="Enter Last Name" value="<%=lname%>" />
                                    </div>
                                    <div class="col-6">
                                        <label for="txtFName">First Name:</label>
                                        <input type="text" id="txtFName" name="txtFName" class="form-control form-control-sm" placeholder="Enter First Name" value="<%=fname%>" />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-6">
                                        <label for="txtAddress1">Address Line 1:</label>
                                        <input type="text" id="txtAddress1" name="txtAddress1" class="form-control form-control-sm" placeholder="Enter Address Line 1" value="<%=address1%>" />
                                    </div>
                                    <div class="col-6">
                                        <label for="txtAddress2">Address Line 2:</label>
                                        <input type="text" id="txtAddress2" name="txtAddress2" class="form-control form-control-sm" placeholder="Enter Address Line 2"  value="<%=address2%>"/>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-4">
                                        <label for="txtCity">City:</label>
                                        <input type="text" id="txtCity" name="txtCity" class="form-control form-control-sm" placeholder="Enter City"  value="<%=city%>"/>
                                    </div>
                                    <div class="col-4">
                                        <label for="txtState">State:</label>
                                        <input type="text" id="txtState" name="txtState" class="form-control form-control-sm" placeholder="Enter State" value="<%=state%>"/>
                                    </div>
                                    <div class="col-4">
                                        <label for="txtCountry">Country:</label>
                                        <input type="text" id="txtCountry" name="txtCountry" class="form-control form-control-sm" placeholder="Enter Country" value="<%=country%>"/>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-4">
                                        <label for="txtPincode">Pincode:</label>
                                        <input type="text" id="txtPincode" name="txtPincode" class="form-control form-control-sm" placeholder="Enter Pincode" value="<%=pincode%>"/>
                                    </div>
                                    <div class="col-4">
                                        <label for="ddlUIDType">UID Type:</label>
                                        <input type="text" id="ddlUIDType" name="ddlUIDType" class="form-control form-control-sm" placeholder="Enter UID Type" value="<%=UID_type%>"/>
                                    </div>
                                    <div class="col-4">
                                        <label for="txtUIDNo">UID No:</label>
                                        <input type="text" id="txtUIDNo" name="txtUIDNo" class="form-control form-control-sm" placeholder="Enter UID No" value="<%=UID_NO%>"/>
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <div class="col-6">
                                        <label for="txtPhone">Phone:</label>
                                        <input type="text" id="txtPhone" name="txtPhone" class="form-control form-control-sm" placeholder="Enter Phone Number" value="<%=phone%>"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col text-center">
                                        <button type="submit" class="btn btn-success">Submit<i class="fas fa-paper-plane"></i></button>
                                        <input type="hidden" id="txtUserId" name="txtUserId" value="<%=strUserId%>">
                                        <input type="hidden" id="txtGuestId" name="txtGuestId" value="<%= isBlankNull(guestId)%>">

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
