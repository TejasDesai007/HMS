<jsp:useBean id="obj" class="com.Guest"/>
<jsp:setProperty property="*" name="obj"/>
<%
    if (obj.Guest() == null) {
        response.sendRedirect("GuestList");
//        out.println("successFull");
    } else {
        out.println(obj.Guest());
    }
%>
