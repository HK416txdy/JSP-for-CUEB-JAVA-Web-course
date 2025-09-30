import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TimeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应内容类型
        response.setContentType("text/html;charset=UTF-8");
        
        // 获取当前时间
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String currentTime = now.format(formatter);
        
        // 输出HTML内容
        response.getWriter().println("<!DOCTYPE html>");
        response.getWriter().println("<html>");
        response.getWriter().println("<head>");
        response.getWriter().println("    <title>当前时间</title>");
        response.getWriter().println("    <meta http-equiv='refresh' content='1'>"); // 每秒刷新
        response.getWriter().println("</head>");
        response.getWriter().println("<body>");
        response.getWriter().println("    <h1>当前时间</h1>");
        response.getWriter().println("    <h2>" + currentTime + "</h2>");
        response.getWriter().println("</body>");
        response.getWriter().println("</html>");
    }
}