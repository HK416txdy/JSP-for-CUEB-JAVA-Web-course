<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 这个页面将被user.jsp包含，使用的是include指令 -->
<div style="border: 1px solid #ccc; padding: 10px; margin: 10px;">
    <p><strong>用户名:</strong> <%= userName %></p>
    <p><em>这是通过include指令包含进来的页面</em></p>
</div>