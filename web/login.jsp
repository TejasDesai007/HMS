<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style/css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <link href="style/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <script src="js/JQuery.js" type="text/javascript"></script>
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
        <form id="frmLoginCrdt" name="frmLoginCrdt" method="POST" action="ValidateCredentials">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8 offset-sm-2 center-card">
                        <div class="card custom-width">
                            <div class="card-body ">
                                <h5 class="card-title"><i class="fas fa-hotel"></i> Apex Hotels</h5>
                                Welcome to Apex Hotels! Enter Your Credentials Here
                                <div class="row mt-3">
                                    <div class="col-8">
                                        <label for="txtUserNm">User Name: </label>  <input type="textbox" id="txtUserNm" class="form-control form-control-sm bg-white" name="txtUserNm" autocomplete="off"/>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-8">
                                        <label for="txtPassword">Password: </label> <input type="password" id="txtPassword" class="form-control form-control-sm bg-white" name="txtPassword" autocomplete="off"/>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-4">
                                        <button type="textbox" id="btnLogin" class="btn btn-success" name="btnLogin" >Proceed</button>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class='col-8'>
                                        <small>Don't Have Account <a href='frmRegistration.jsp'>Register Here</a></small>

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
