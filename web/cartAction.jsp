<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.Cart" %>
<%@ page import="src.Product" %>
<%@ page import="src.ProductDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    
    Cart cart = (Cart) session.getAttribute("cart");
    if (cart == null) {
        cart = new Cart();
        session.setAttribute("cart", cart);
    }
    
    String action = request.getParameter("action");
    
    if (action != null) {
        if (action.equals("add")) {
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            
            if (productIdStr != null && quantityStr != null) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    int quantity = Integer.parseInt(quantityStr);
                    
                    if (quantity > 0) {
                        Product product = ProductDAO.getProductById(productId);
                        if (product != null) {
                            cart.addItem(product, quantity);
                        }
                    }
                } catch (NumberFormatException e) {
                }
            }
            
            String referer = request.getHeader("Referer");
            if (referer != null && referer.contains("product.jsp")) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect("index.jsp");
            }
            
        } else if (action.equals("remove")) {
            String productIdStr = request.getParameter("productId");
            
            if (productIdStr != null) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    cart.removeItem(productId);
                } catch (NumberFormatException e) {
                }
            }
            
            response.sendRedirect("cart.jsp");
            
        } else if (action.equals("update")) {
            String productIdStr = request.getParameter("productId");
            String quantityStr = request.getParameter("quantity");
            
            if (productIdStr != null && quantityStr != null) {
                try {
                    int productId = Integer.parseInt(productIdStr);
                    int quantity = Integer.parseInt(quantityStr);
                    
                    cart.updateQuantity(productId, quantity);
                } catch (NumberFormatException e) {
                }
            }
            
            response.sendRedirect("cart.jsp");
            
        } else if (action.equals("clear")) {
            session.removeAttribute("cart");
            response.sendRedirect("cart.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>