<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.Cart" %>
<%@ page import="src.CartItem" %>
<%@ page import="src.Product" %>
<%@ page import="java.util.Collection" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>购物车</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            padding: 30px;
        }
        h1 {
            color: #333;
            margin-top: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .product-info {
            display: flex;
            align-items: center;
        }
        .product-image {
            width: 80px;
            height: 80px;
            margin-right: 15px;
        }
        .product-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .quantity-control {
            display: flex;
            align-items: center;
        }
        .quantity-control input {
            width: 50px;
            text-align: center;
            margin: 0 5px;
        }
        .btn {
            display: inline-block;
            padding: 8px 15px;
            margin: 5px;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            border: none;
        }
        .btn-primary {
            background-color: #3498db;
            color: white;
        }
        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }
        .btn-success {
            background-color: #2ecc71;
            color: white;
            padding: 12px 25px;
            font-size: 16px;
        }
        .summary {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin: 10px 0;
            font-size: 18px;
        }
        .total {
            font-weight: bold;
            font-size: 20px;
            color: #e74c3c;
        }
        .actions {
            text-align: right;
            margin: 20px 0;
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
        .empty-cart {
            text-align: center;
            padding: 50px;
            color: #666;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.jsp" class="back-link">&larr; 继续购物</a>
        
        <h1>购物车</h1>
        
        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            
            if (cart.isEmpty()) {
        %>
            <div class="empty-cart">
                <h2>购物车是空的</h2>
                <p>您还没有添加任何商品到购物车。</p>
                <a href="index.jsp" class="btn btn-primary">去购物</a>
            </div>
        <%
            } else {
                Collection<CartItem> items = cart.getItems();
        %>
                <table>
                    <thead>
                        <tr>
                            <th>商品</th>
                            <th>单价</th>
                            <th>数量</th>
                            <th>小计</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (CartItem item : items) {
                                Product product = item.getProduct();
                        %>
                            <tr>
                                <td>
                                    <div class="product-info">
                                        <div class="product-image">
                                            <img src="images/<%= product.getImage() %>" alt="<%= product.getName() %>">
                                        </div>
                                        <div>
                                            <div><%= product.getName() %></div>
                                            <div style="font-size: 12px; color: #666;"><%= product.getDescription() %></div>
                                        </div>
                                    </div>
                                </td>
                                <td>¥<%= String.format("%.2f", product.getPrice()) %></td>
                                <td>
                                    <div class="quantity-control">
                                        <form action="cartAction.jsp" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                                            <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
                                            <button type="submit" class="btn btn-primary" <%= item.getQuantity() <= 1 ? "disabled" : "" %>>-</button>
                                        </form>
                                        
                                        <input type="text" value="<%= item.getQuantity() %>" readonly>
                                        
                                        <form action="cartAction.jsp" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                                            <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                                            <button type="submit" class="btn btn-primary">+</button>
                                        </form>
                                    </div>
                                </td>
                                <td>¥<%= String.format("%.2f", item.getTotalPrice()) %></td>
                                <td>
                                    <form action="cartAction.jsp" method="post">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="productId" value="<%= product.getId() %>">
                                        <button type="submit" class="btn btn-danger">删除</button>
                                    </form>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
                
                <div class="summary">
                    <div class="summary-item">
                        <span>商品总数:</span>
                        <span><%= cart.getTotalQuantity() %></span>
                    </div>
                    <div class="summary-item total">
                        <span>总计:</span>
                        <span>¥<%= String.format("%.2f", cart.getTotalPrice()) %></span>
                    </div>
                </div>
                
                <div class="actions">
                    <form action="cartAction.jsp" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="clear">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('确定要清空购物车吗？')">清空购物车</button>
                    </form>
                    <button class="btn btn-success">结算</button>
                </div>
        <%
            }
        %>
    </div>
</body>
</html>