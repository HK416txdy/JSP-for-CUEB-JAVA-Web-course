<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 这个页面将被user2.jsp通过jsp:include动作包含，从session中获取userName -->
<div style="border: 1px solid #ccc; padding: 10px; margin: 10px;">
    <p><strong>用户名:</strong> <%= session.getAttribute("userName") %></p>
    <p><em>这是通过jsp:include动作包含进来的页面</em></p>
</div>