<%-- 
    Document   : logout
    Created on : Nov 15, 2024, 1:05:47 PM
    Author     : TEJAS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>
<%
    session.removeAttribute("UserId");
    session.removeAttribute("UserName");
    response.sendRedirect("Home");
    
%>
