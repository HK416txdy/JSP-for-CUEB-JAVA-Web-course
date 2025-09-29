<%--
  Created by IntelliJ IDEA.
  User: 给416狠狠注入白色糖浆
  Date: 2025/9/19
  Time: 14:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>找啊找啊找素数</title>
</head>
<body>
    <h2>找素数</h2>
    <p>请输入两个整数,将返回两个数之间的所有素数</p>
    
    <form action="PrimeNumberFinder" method="post">
        <label for="numA">请输入左界:</label>
        <input type="text" id="numA" name="numA">
        <br>
        
        <label for="numB">请输入右界:</label>
        <input type="text" id="numB" name="numB">
        <br>
        
        <input type="submit" value="提交">
    </form>
</body>
</html>