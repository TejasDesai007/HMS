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
        <script src="js/JQuery.js" type="text/javascript"></script>
        <jsp:include page="include/menu.jsp"/>
    </head>
    <body class="bg-success">
        <!-- Main Content with Bootstrap Card -->
        <div class="container mt-5">
            <div class="row">

                <div class="card bg-light text-dark">
                    <div class="card-header text-center">
                        <h2>Welcome to Apex Hotels</h2>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Enjoy Your Stay</h5>
                        <p class="card-text">
                            At Apex Hotels, we strive to provide the best possible service to our guests. From luxurious rooms to world-class dining, everything is crafted to make your experience unforgettable. Explore our exclusive services such as Room Service, Dining, and Spa & Wellness, each tailored to bring you comfort, relaxation, and indulgence. Whether you're traveling for business or leisure, our dedicated team ensures every moment of your stay is extraordinary.

                            Our hotel boasts state-of-the-art amenities, including high-speed internet, conference facilities, and a well-equipped fitness center, catering to the diverse needs of our guests. Enjoy breathtaking views from our elegantly designed rooms, or unwind in our tranquil spa, where rejuvenation meets serenity.


                        </p>
                        <h5 class="card-title">About Us</h5>
                        <p class="card-text">
                            
                            Apex Hotels is more than just a place to stay; it’s a gateway to unparalleled hospitality. With a legacy of excellence and a commitment to innovation, we have been redefining luxury for years. Our mission is to provide a home away from home while ensuring a seamless blend of comfort, style, and impeccable service. At Apex Hotels, your satisfaction is not just our goal—it’s our promise. Experience the difference where hospitality meets perfection!

                        </p>
                    </div>
                </div>


            </div>
        </div>


    </body>
</html>
<%    }%>
