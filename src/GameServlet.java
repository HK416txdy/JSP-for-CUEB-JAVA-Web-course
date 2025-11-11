import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class GameServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // 检查是否是重新开始游戏
        String restart = request.getParameter("restart");
        if ("true".equals(restart)) {
            // 清除session中的游戏数据
            session.removeAttribute("low");
            session.removeAttribute("high");
            session.removeAttribute("guessCount");
            session.removeAttribute("lastGuess");
        }
        
        // 初始化游戏参数
        Integer low = (Integer) session.getAttribute("low");
        Integer high = (Integer) session.getAttribute("high");
        Integer guessCount = (Integer) session.getAttribute("guessCount");
        
        // 如果是新游戏，初始化参数
        if (low == null || high == null || guessCount == null) {
            low = 0;
            high = 999;
            guessCount = 0;
            session.setAttribute("low", low);
            session.setAttribute("high", high);
            session.setAttribute("guessCount", guessCount);
        }
        
        // 获取用户反馈
        String feedback = request.getParameter("feedback");
        Integer lastGuess = (Integer) session.getAttribute("lastGuess");
        
        // 根据反馈调整猜测范围
        if ("low".equals(feedback) && lastGuess != null) {
            low = lastGuess + 1;
            session.setAttribute("low", low);
        } else if ("high".equals(feedback) && lastGuess != null) {
            high = lastGuess - 1;
            session.setAttribute("high", high);
        } else if ("correct".equals(feedback) && lastGuess != null) {
            // 猜对了，游戏结束
            request.setAttribute("gameOver", true);
            request.setAttribute("finalGuess", lastGuess);
            request.getRequestDispatcher("/game.jsp").forward(request, response);
            return;
        }
        
        // 增加猜测次数
        guessCount++;
        session.setAttribute("guessCount", guessCount);
        
        // 计算新的猜测值（使用二分法）
        int newGuess = low + (high - low) / 2;
        session.setAttribute("lastGuess", newGuess);
        
        // 设置请求属性供JSP使用
        request.setAttribute("guess", newGuess);
        request.setAttribute("guessCount", guessCount);
        request.setAttribute("low", low);
        request.setAttribute("high", high);
        
        // 检查是否超过最大猜测次数
        if (guessCount > 10) {
            request.setAttribute("tooManyGuesses", true);
        }
        
        request.getRequestDispatcher("/game.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}