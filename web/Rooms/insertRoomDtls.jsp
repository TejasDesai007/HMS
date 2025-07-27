<jsp:useBean id="obj" class="com.RoomDtls"/>
<jsp:setProperty property="*" name="obj"/>
<%
    if (obj.RoomDtls() == null) {
        response.sendRedirect("RoomsList");
//        out.println("successFull");
    } else {
        out.println(obj.RoomDtls());
    }
%>
