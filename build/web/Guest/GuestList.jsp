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
        <script src="js/GuestList.js?v=2" type="text/javascript"></script>
        
        <jsp:include page="include/menu.jsp"/>
    </head>
    <body class="bg-success">


        <div class="container mt-5">
            <div class="row">
                <div class="col-md-12">
                    <div class="card bg-light text-dark">
                        <div class="card-header text-center">
                            <h4>Guest List</h4>
                        </div>

                        <table class="table table-bordered table-responsive" id="inputTable" style="table-layout: auto;">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col" class="text-center"></th>
                                    <th scope="col" class="text-center"></th>
                                    <th scope="col" class="text-center"></th>
                                    <th scope="col" class="text-center">Guest</th>
                                    <th scope="col" class="text-center">Address</th>
                                    <th scope="col" class="text-center">City</th>
                                    <th scope="col" class="text-center">State</th>
                                    <th scope="col" class="text-center">Country</th>
                                    <th scope="col" class="text-center">Pincode</th>
                                    <th scope="col" class="text-center">UID type</th>
                                    <th scope="col" class="text-center">UID No</th>
                                    <th scope="col" class="text-center">Phone</th>
                                    <th scope="col" class="text-center">Created On</th>
                                    <th scope="col" class="text-center">Created By</th>
                                    
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td><label for="textbox1" class="d-none">lname</label><input type="text" id="textbox1" name="textbox1" class="form-control form-control-sm"></td>
                                    <td></td>
                                    <td><label for="textbox2" class="d-none">city</label><input type="text" id="textbox2" name="textbox2" class="form-control form-control-sm"></td>
                                    <td><label for="textbox3" class="d-none">state</label><input type="text" id="textbox3" name="textbox3" class="form-control form-control-sm"> </td>
                                    <td><label for="textbox4" class="d-none">country</label><input type="text" id="textbox4" name="textbox4" class="form-control form-control-sm" ></td>
                                    <td><label for="textbox5" class="d-none">pincode</label><input type="text" id="textbox5" name="textbox5" class="form-control form-control-sm" ></td>
                                    <td></td>
                                    <td><label for="textbox6" class="d-none">UID_NO</label><input type="text" id="textbox6" name="textbox6" class="form-control form-control-sm" ></td>
                                    <td><label for="textbox7" class="d-none">phone</label><input type="text" id="textbox7" name="textbox7" class="form-control form-control-sm" ></td>
                                    <td ></td>
                                    <td></td>
                                    
                                    
                                    <!-- Add more textboxes as needed -->
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
