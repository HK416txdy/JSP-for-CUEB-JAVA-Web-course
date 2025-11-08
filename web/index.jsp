<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="src.Product" %>
<%@ page import="src.ProductDAO" %>
<%@ page import="src.Cart" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>电子商城</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        .products {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .product {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            margin: 10px;
            padding: 20px;
            width: 250px;
            text-align: center;
        }
        .product img {
            max-width: 100%;
            height: 150px;
            object-fit: cover;
        }
        .product h3 {
            color: #333;
            margin: 10px 0;
        }
        .product p {
            color: #666;
            font-size: 14px;
        }
        .price {
            font-size: 18px;
            font-weight: bold;
            color: #e74c3c;
            margin: 10px 0;
        }
        .view-link {
            display: inline-block;
            background-color: #3498db;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 10px;
        }
        .view-link:hover {
            background-color: #2980b9;
        }
        .cart-info {
            text-align: right;
            margin-bottom: 20px;
        }
        .cart-link {
            background-color: #2ecc71;
            color: white;
            padding: 10px 15px;
            text-decoration: none;
            border-radius: 4px;
        }
        .cart-link:hover {
            background-color: #27ae60;
        }
    </style>
</head>
<body>
    <h1>欢迎来到电子商城</h1>
    
    <div class="cart-info">
        <%
            Cart cart = (Cart) session.getAttribute("cart");
            if (cart == null) {
                cart = new Cart();
                session.setAttribute("cart", cart);
            }
            int totalQuantity = cart.getTotalQuantity();
        %>
        <a href="cart.jsp" class="cart-link">购物车 (<%= totalQuantity %>)</a>
    </div>
    
    <div class="products">
        <%
            List<Product> products = ProductDAO.getAllProducts();
            for (Product product : products) {
        %>
            <div class="product">
                <h3><%= product.getName() %></h3>
                <p><%= product.getDescription() %></p>
                <div class="price">¥<%= String.format("%.2f", product.getPrice()) %></div>
                <a href="product.jsp?id=<%= product.getId() %>" class="view-link">查看详情</a>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>