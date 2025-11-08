<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.Product" %>
<%@ page import="src.ProductDAO" %>
<%@ page import="src.Cart" %>
<%@ page import="src.CartItem" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>商品详情</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .product-detail {
            display: flex;
            gap: 30px;
        }
        .product-image {
            flex: 1;
        }
        .product-info {
            flex: 2;
        }
        .product-image img {
            width: 100%;
            max-width: 300px;
            height: auto;
        }
        h1 {
            color: #333;
            margin-top: 0;
        }
        .price {
            font-size: 24px;
            font-weight: bold;
            color: #e74c3c;
            margin: 20px 0;
        }
        .description {
            color: #666;
            line-height: 1.6;
        }
        .quantity-selector {
            margin: 20px 0;
        }
        .quantity-selector label {
            margin-right: 10px;
        }
        .quantity-selector input {
            width: 60px;
            padding: 5px;
            text-align: center;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px 5px;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            border: none;
            font-size: 16px;
        }
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        .btn-primary:hover {
            background-color: #2980b9;
        }
        .btn-success {
            background-color: #2ecc71;
            color: white;
        }
        .btn-success:hover {
            background-color: #27ae60;
        }
        .btn-secondary {
            background-color: #95a5a6;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #7f8c8d;
        }
        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #3498db;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.jsp" class="back-link">&larr; 返回商品列表</a>
        
        <%
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    int productId = Integer.parseInt(idParam);
                    Product product = ProductDAO.getProductById(productId);
                    
                    if (product != null) {
        %>
                        <div class="product-detail">
                            <div class="product-image">
                                <img src="images/<%= product.getImage() %>" alt="<%= product.getName() %>">
                            </div>
                            <div class="product-info">
                                <h1><%= product.getName() %></h1>
                                <div class="price">¥<%= String.format("%.2f", product.getPrice()) %></div>
                                <div class="description">
                                    <p><%= product.getDescription() %></p>
                                </div>
                                
                                <form action="cartAction.jsp" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <div class="quantity-selector">
                                        <label for="quantity">数量:</label>
                                        <input type="number" id="quantity" name="quantity" value="1" min="1">
                                    </div>
                                    <button type="submit" class="btn btn-success">加入购物车</button>
                                </form>
                            </div>
                        </div>
        <%
                    } else {
        %>
                        <h2>商品未找到</h2>
                        <p>抱歉，找不到指定的商品。</p>
        <%
                    }
                } catch (NumberFormatException e) {
        %>
                    <h2>无效的商品ID</h2>
                    <p>商品ID格式不正确。</p>
        <%
                }
            } else {
        %>
                <h2>缺少商品ID</h2>
                <p>请通过商品列表页面访问商品详情。</p>
        <%
            }
        %>
    </div>
</body>
</html>