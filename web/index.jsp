<%--疑似是服务器配置问题,即使配置了welcome.file,仍然会定向到index.jsp--%>
<%--添加该页以重定向至first.jsp--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 重定向到first.jsp
    response.sendRedirect("first.jsp");
%>

