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

        String guestId = isBlankNull(request.getParameter("guestid"));

        PostgreSqlConnection dbc = new PostgreSqlConnection();
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

        if (!guestId.isEmpty()) {
            try {
                con = dbc.getConnection();

                pstmt = con.prepareStatement(
                        "SELECT lname, fname, address1, address2, city, state, country, pincode, uid_type, uid_no, phone "
                        + "FROM guests WHERE guestid = ?"
                );
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
                    UID_type = rst.getString("uid_type");
                    UID_NO = rst.getString("uid_no");
                    phone = rst.getString("phone");
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
        <script src="js/Guest.js"></script>
        <jsp:include page="include/menu.jsp"/>
    </head>

    <body class="bg-success">
        <div class="container mt-5">
            <form id="frmGuestDtls" action="InsertGuest" method="POST">

                <div class="card bg-light text-dark">
                    <div class="card-header text-center">
                        <h2>Insert Guests Details</h2>
                    </div>

                    <div class="card-body">

                        <div class="row mb-3">
                            <div class="col-6">
                                <label>Last Name:</label>
                                <input type="text" name="txtLName" class="form-control form-control-sm" value="<%=lname%>"/>
                            </div>
                            <div class="col-6">
                                <label>First Name:</label>
                                <input type="text" name="txtFName" class="form-control form-control-sm" value="<%=fname%>"/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-6">
                                <label>Address Line 1:</label>
                                <input type="text" name="txtAddress1" class="form-control form-control-sm" value="<%=address1%>"/>
                            </div>
                            <div class="col-6">
                                <label>Address Line 2:</label>
                                <input type="text" name="txtAddress2" class="form-control form-control-sm" value="<%=address2%>"/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-4">
                                <label>City:</label>
                                <input type="text" name="txtCity" class="form-control form-control-sm" value="<%=city%>"/>
                            </div>
                            <div class="col-4">
                                <label>State:</label>
                                <input type="text" name="txtState" class="form-control form-control-sm" value="<%=state%>"/>
                            </div>
                            <div class="col-4">
                                <label>Country:</label>
                                <input type="text" name="txtCountry" class="form-control form-control-sm" value="<%=country%>"/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-4">
                                <label>Pincode:</label>
                                <input type="text" name="txtPincode" class="form-control form-control-sm" value="<%=pincode%>"/>
                            </div>
                            <div class="col-4">
                                <label>UID Type:</label>
                                <input type="text" name="ddlUIDType" class="form-control form-control-sm" value="<%=UID_type%>"/>
                            </div>
                            <div class="col-4">
                                <label>UID No:</label>
                                <input type="text" name="txtUIDNo" class="form-control form-control-sm" value="<%=UID_NO%>"/>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-6">
                                <label>Phone:</label>
                                <input type="text" name="txtPhone" class="form-control form-control-sm" value="<%=phone%>"/>
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" class="btn btn-success">
                                Submit <i class="fas fa-paper-plane"></i>
                            </button>
                            <input type="hidden" name="txtUserId" value="<%=strUserId%>"/>
                            <input type="hidden" name="txtGuestId" value="<%=isBlankNull(guestId)%>"/>
                        </div>

                    </div>
                </div>

            </form>
        </div>
    </body>
</html>

<% }%>
