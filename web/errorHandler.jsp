<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 设置请求编码以防止中文乱码
    request.setCharacterEncoding("UTF-8");
    
    // 获取错误信息
    String errorMessage = (String) request.getAttribute("errorMessage");
    if (errorMessage == null || errorMessage.isEmpty()) {
        errorMessage = "发生未知错误";
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error Handler</title>
</head>
<body>
    <h1>错误处理页面</h1>
    <p>错误信息：<%= errorMessage %></p>
    <a href="hellouser.jsp">返回重新输入</a>
</body>
</html>