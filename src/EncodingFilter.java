import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * 编码过滤器：在请求进入后设置请求与响应的字符编码为指定的编码（默认 UTF-8）
 */
@WebFilter("/*")
public class EncodingFilter implements Filter {
    private String encoding = "UTF-8";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // 从初始化参数读取编码配置（可在 web.xml 中通过 <init-param> 指定）
        String enc = filterConfig.getInitParameter("encoding");
        if (enc != null && !enc.trim().isEmpty()) {
            encoding = enc.trim();
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding(encoding);
        response.setCharacterEncoding(encoding);
        if (response.getContentType() == null) {
            response.setContentType("text/html; charset=" + encoding);
        }
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
