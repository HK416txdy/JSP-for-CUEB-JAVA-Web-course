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
        .guess-box {
            background-color: #e3f2fd;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            font-size: 24px;
            font-weight: bold;
        }
        .feedback-buttons {
            margin: 20px 0;
        }
        .btn {
            background-color: #2196F3;
            border: none;
            color: white;
            padding: 15px 25px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 10px 5px;
            cursor: pointer;
            border-radius: 5px;
        }
        .btn-low {
            background-color: #FF9800;
        }
        .btn-high {
            background-color: #F44336;
        }
        .btn-correct {
            background-color: #4CAF50;
        }
        .btn-restart {
            background-color: #9C27B0;
        }
        .btn:hover {
            opacity: 0.8;
        }
        .info {
            background-color: #fff3e0;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
        }
        .game-over {
            background-color: #e8f5e9;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
            font-size: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>猜数字游戏</h1>
        
        <%
            Boolean gameOver = (Boolean) request.getAttribute("gameOver");
            Boolean tooManyGuesses = (Boolean) request.getAttribute("tooManyGuesses");
            
            if (gameOver != null && gameOver) {
                Integer finalGuess = (Integer) request.getAttribute("finalGuess");
        %>
                <div class="game-over">
                    <h2>游戏结束!</h2>
                    <p>系统成功猜出了你心中的数字：<strong><%= finalGuess %></strong></p>
                    <p>总共猜测次数：<strong>${guessCount}</strong> 次</p>
                    <a href="game?restart=true" class="btn btn-restart">重新开始游戏</a>
                </div>
        <%
            } else if (tooManyGuesses != null && tooManyGuesses) {
        %>
                <div class="game-over">
                    <h2>游戏异常!</h2>
                    <p>猜测次数已经超过10次，请检查是否正确反馈了每次猜测结果。</p>
                    <a href="game?restart=true" class="btn btn-restart">重新开始游戏</a>
                </div>
        <%
            } else {
                Integer guess = (Integer) request.getAttribute("guess");
                Integer guessCount = (Integer) request.getAttribute("guessCount");
                Integer low = (Integer) request.getAttribute("low");
                Integer high = (Integer) request.getAttribute("high");
        %>
                <div class="info">
                    <p>请A用户在心中想一个0到999之间的整数</p>
                    <p>B用户请监督并如实反馈猜测结果</p>
                </div>
                
                <div class="guess-box">
                    <p>第 <strong><%= guessCount %></strong> 次猜测</p>
                    <p>系统猜测的数字是：<strong><%= guess %></strong></p>
                </div>
                
                <div class="feedback-buttons">
                    <p>请B用户反馈猜测结果：</p>
                    <a href="game?feedback=low" class="btn btn-low">猜小了</a>
                    <a href="game?feedback=high" class="btn btn-high">猜大了</a>
                    <a href="game?feedback=correct" class="btn btn-correct">猜对了</a>
                </div>
                
                <div class="info">
                    <p>当前猜测范围：<strong><%= low %></strong> 到 <strong><%= high %></strong></p>
                    <a href="game?restart=true" class="btn btn-restart">重新开始游戏</a>
                </div>
        <%
            }
        %>
    </div>
</body>
</html>