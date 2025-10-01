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
        <script src="js/OnlyNumbers.js?v=2" type="text/javascript"></script>
        <script src="js/JQuery.js" type="text/javascript"></script>
        
        <script src="js/BookingsList.js?v=4" type="text/javascript"></script>
        <jsp:include page="include/menu.jsp"/>
    </head>
    <body class="bg-success" >


        <div class="container mt-5">
            <div class="row">
                <div class="col-md-12">
                    <div class="card bg-light text-dark">
                        <div class="card-header text-center">
                            <h4>Bookings</h4>
                        </div>

                            <table class="table table-bordered table-responsive table-striped" id="inputTable">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col" class="text-center"></th>
                                    <th scope="col" class="text-center"></th>
                                    <th scope="col" class="text-center"></th>
                                    <th scope="col" class="text-center"></th>
                                    <th scope="col" class="text-center">Guest</th>
                                    <th scope="col" class="text-center">Room No</th>
                                    <th scope="col" class="text-center">Bill</th>
                                    <th scope="col" class="text-center">Check In</th>
                                    <th scope="col" class="text-center">Check Out</th>
                                    <th scope="col" class="text-center">Entered by</th>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td><label for="textbox1" class="d-none">g.lname</label><input type="text" id="textbox1" name="textbox1" class="form-control form-control-sm"></td>
                                    <td><label for="textbox2" class="d-none">room_no</label><input type="text" id="textbox2" name="textbox2" class="form-control form-control-sm"></td>
                                    <td><label for="textbox3" class="d-none">total_bill</label><input type="text" id="textbox3" name="textbox3" onkeydown="allowOnlyNumbersAndDecimal(event)" class="form-control form-control-sm"></td>
                                    <td><label for="textbox4" class="d-none">check_in</label><input type="text" id="textbox4" name="textbox4" onkeydown="handleDateInput(event)" class="form-control form-control-sm"></td>
                                    <td><label for="textbox5" class="d-none">check_out</label><input type="text" id="textbox5" name="textbox5" onkeydown="handleDateInput(event)" class="form-control form-control-sm"></td>
                                    <td><label for="textbox6" class="d-none">ud.fname</label><input type="text" id="textbox6" name="textbox6" class="form-control form-control-sm"></td>
                                    
                                </tr>
                            </thead>
                            <tbody >


                            </tbody>
                        </table>


                    </div>
                </div>
            </div>
        </div>


    </body>
</html>
<%    }%>
