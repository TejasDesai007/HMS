<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="style/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <script src="js/JQuery.js" type="text/javascript"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <script src="js/RegistrationValidate.js?v=04122024025612" type="text/javascript"></script>
        <style>
            /* Center the card */
            .center-card {
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;

            }
            .custom-width {
                width: 500px; /* Adjust the width as per your requirement */
            }

        </style>
    </head>
    <body class="bg-success">
        <form id="frmRegCrdt" name="frmRegCrdt" method="POST" action="saveRegUser">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8 offset-sm-2 center-card">
                        <div class="card custom-width">
                            <div class="card-body ">
                                <h5 class="card-title"><i class="fas fa-hotel"></i> Apex Hotels</h5>
                                Enter Your Details Here!
                                <div class="row mt-3">
                                    <div class="col-6">
                                        <label for="txtFName">First Name: </label>  <input type="textbox" id="txtFName" class="form-control form-control-sm bg-white" name="txtFName" autocomplete="on"/>
                                    </div>
                                    <div class="col-6">
                                        <label for="txtLName">Last Name: </label>  <input type="textbox" id="txtLName" class="form-control form-control-sm bg-white" name="txtLName" autocomplete="on"/>
                                    </div>
                                </div>

                                <div class="row mt-3">
                                    <div class="col-6">
                                        <label for="txtEmail">Email: </label>  <input type="textbox" id="txtEmail" class="form-control form-control-sm bg-white" name="txtEmail" autocomplete="on"/>
                                    </div>
                                    <div class="col-6">
                                        <label for="txtPhone">Phone: </label>  <input type="textbox" id="txtPhone" class="form-control form-control-sm bg-white" name="txtPhone" autocomplete="on"/>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <label for="txtEmpNo">Employee No.: </label>  <input type="textbox" id="txtEmpNo" class="form-control form-control-sm bg-white" name="txtEmpNo" autocomplete="on"/>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <label for="selUserType">User Type: </label>
                                        <select id="selUserType" class="form-control form-control-sm bg-white" name="selUserType">
                                            <option value="0" selected>Select User Type</option>
                                            <option value="Admin">Admin</option>
                                            <option value="Receptionist">Receptionist</option>
                                            <option value="Manager">Manager</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <label for="txtUserNm">User Name: </label>  <input type="textbox" id="txtUserNm" class="form-control form-control-sm bg-white" name="txtUserNm" autocomplete="on"/>
                                        <small><label id="lblUserNmMsg" class="text-danger d-none"></label></small>
                                    </div>
                                </div>



                                <div class="row mt-3">
                                    <div class="col-12">
                                        <label for="txtPassword">Password: </label> <input type="password" id="txtPassword" class="form-control form-control-sm bg-white" name="txtPassword" autocomplete="on"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <small><label id="lblPasswordMsg" class="d-none"></label></small>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12">
                                        <label for="txtCnfPassword">Confirm Password: </label> <input type="password" id="txtCnfPassword" class="form-control form-control-sm bg-white" name="txtCnfPassword" autocomplete="on"/>
                                    </div>
                                </div>

                                <!-- User Type Select -->


                                <div class="row mt-3">
                                    <div class="col-4">
                                        <button type="button" id="btnRegister" class="btn btn-success" name="btnRegister" >Proceed</button>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </body>
</html>
