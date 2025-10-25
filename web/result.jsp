<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 设置请求编码为UTF-8以解决中文乱码问题
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="com.example.beans.User" scope="page" />
<jsp:setProperty name="user" property="*" />

<html>
<head>
    <title>注册信息确认</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .info-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            margin-top: 0;
        }
        .info-group {
            margin-bottom: 15px;
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        .info-label {
            font-weight: bold;
            color: #555;
            display: inline-block;
            width: 150px;
        }
        .info-value {
            color: #333;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #008CBA;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .back-link:hover {
            background-color: #007B9A;
        }
    </style>
</head>
<body>
    <div class="info-container">
        <h2>注册信息确认</h2>
        
        <div class="info-group">
            <span class="info-label">用户名:</span>
            <span class="info-value"><jsp:getProperty name="user" property="username" /></span>
        </div>
        
        <div class="info-group">
            <span class="info-label">密码:</span>
            <span class="info-value"><jsp:getProperty name="user" property="password" /></span>
        </div>
        
        <div class="info-group">
            <span class="info-label">安全问题:</span>
            <span class="info-value"><jsp:getProperty name="user" property="securityQuestion" /></span>
        </div>
        
        <div class="info-group">
            <span class="info-label">安全问题答案:</span>
            <span class="info-value"><jsp:getProperty name="user" property="securityAnswer" /></span>
        </div>
        
        <p>恭喜您已成功注册！</p>
        
        <a href="index.jsp" class="back-link">返回注册页面</a>
    </div>
</body>
</html>