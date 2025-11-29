<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 清除session
    session.invalidate();
    // 重定向到登录页面
    response.sendRedirect(request.getContextPath() + "/login.jsp");
%>