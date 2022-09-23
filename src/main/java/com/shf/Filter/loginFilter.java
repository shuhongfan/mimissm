package com.shf.Filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * @author shkstart
 * @create 2021-09-17 14:14
 * 判断是否登陆
 */
@WebFilter("/*") //访问所有资源前都会执行该方法
public class loginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        //强制转换
        HttpServletRequest request = (HttpServletRequest) servletRequest;

        //获取请求资源
        String uri = request.getRequestURI();
        //System.out.println("uri = " + uri);
        //放行其他资源
        if ("/".equals(uri) || uri.contains(".css")
                || uri.contains(".js") || uri.contains(".jpg")
                || uri.contains("login.action")) {
            filterChain.doFilter(request, servletResponse);
        } else {
            Object admin = request.getSession().getAttribute("admin");
            //System.out.println("admin = " + admin);
            if (admin != null) {
                filterChain.doFilter(request, servletResponse);
            } else {
                //如果没有登陆跳转到 errorWatch.jsp 让用户跳转到登陆
                request.setAttribute("errmsg", "你尚未登录请登陆");
                request.getRequestDispatcher("/admin/login.jsp").forward(request, servletResponse);
            }
        }


    }

    @Override
    public void destroy() {

    }
}
