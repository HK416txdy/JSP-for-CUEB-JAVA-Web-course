<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>First Page</title>
</head>
<body>
    <h2>请输入目标页面信息</h2>
    <form method="post" action="input.jsp">
        <label for="targetUrl">要浏览的网址:</label>
        <input type="text" id="targetUrl" name="targetUrl" placeholder="例如: input.jsp" value="input.jsp"><br><br>
        
        <label for="inputName">输入框的名称:</label>
        <input type="text" id="inputName" name="inputName" placeholder="例如: sname" value="sname"><br><br>
        
        <label for="inputValue">自动填入输入框的值:</label>
        <input type="text" id="inputValue" name="inputValue" placeholder="例如: 张三" value="张三"><br><br>
        
        <input type="submit" value="提交">
    </form>
</body>
</html>