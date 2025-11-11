<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>猜数字游戏</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        h1 {
            color: #333;
        }
        .instructions {
            text-align: left;
            margin: 20px 0;
            padding: 15px;
            background-color: #e9f7fe;
            border-left: 5px solid #4CAF50;
        }
        .btn {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 15px 32px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 10px 2px;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>猜数字游戏</h1>
        
        <div class="instructions">
            <h3>游戏规则：</h3>
            <ol>
                <li>A用户在心中想一个1000以内的整数（0-999）</li>
                <li>B用户负责监督并告知系统猜测结果是大了、小了还是正确</li>
                <li>系统将在10次以内猜出A用户心中的数字</li>
                <li>请诚实反馈每次猜测的结果</li>
            </ol>
        </div>
        
        <form action="game" method="GET">
            <input type="submit" class="btn" value="开始游戏">
        </form>
    </div>
</body>
</html>