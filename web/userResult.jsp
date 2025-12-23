<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.model.User" %>
<html>
<head>
    <title>注册结果</title>
</head>
<body>
    <h2>注册成功</h2>
    <%
        com.example.model.User user = (com.example.model.User) request.getAttribute("user");
        if (user != null) {
    %>
    <table>
        <tr>
            <td>用户名:</td>
            <td><%= user.getUsername() %></td>
        </tr>
        <tr>
            <td>邮箱:</td>
            <td><%= user.getEmail() %></td>
        </tr>
        <tr>
            <td>年龄:</td>
            <td><%= user.getAge() %></td>
        </tr>
    </table>
    <p><a href="register.jsp">返回注册页面</a></p>
    <%
        } else {
    %>
    <p>用户信息不存在</p>
    <%
        }
    %>
</body>
</html>