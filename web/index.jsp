<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>用户注册</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .form-container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input, select, textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            padding: 12px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>用户注册</h2>
        <form action="result.jsp" method="post">
            <div class="form-group">
                <label for="username">用户名:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="password">密码:</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="securityQuestion">安全问题:</label>
                <select id="securityQuestion" name="securityQuestion" required>
                    <option value="">请选择一个问题</option>
                    <option value="您母亲的姓名是？">您母亲的姓名是？</option>
                    <option value="您父亲的姓名是？">您父亲的姓名是？</option>
                    <option value="您的出生地是？">您的出生地是？</option>
                    <option value="您最喜欢的学校科目是？">您最喜欢的学校科目是？</option>
                    <option value="您最喜欢的颜色是？">您最喜欢的颜色是？</option>
                    <option value="您最喜欢的食物是？">您最喜欢的食物是？</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="securityAnswer">安全问题答案:</label>
                <input type="text" id="securityAnswer" name="securityAnswer" required>
            </div>
            
            <input type="submit" value="注册">
        </form>
    </div>
</body>
</html>