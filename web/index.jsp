<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="demo" uri="http://www.mydomain.com/samples" %>
.<%-- setencodingcharactor = utf8 --%>
<%
    // 明确设置请求和响应的字符编码为 UTF-8
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>自定义标签演示</title>
</head>
<body>
    <h1>自定义标签演示</h1>
    <p>字面值属性示例：</p>
    <p><demo:greetUser user="小明"/></p>
    <p><demo:greetUser user="${sessionScope.username}"/></p>

</body>
</html>
