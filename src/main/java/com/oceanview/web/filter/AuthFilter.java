package com.oceanview.web.filter;

import com.oceanview.AppConstants;
import com.oceanview.model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI();
        boolean isPublic =
                path.endsWith("index.jsp") ||
                        path.endsWith("/") ||
                        path.contains("/login") ||
                        path.contains("/css/") ||
                        path.contains("/home");

        if (isPublic) {
            chain.doFilter(request, response);
            return;
        }

        User user = (User) req.getSession().getAttribute(AppConstants.SESSION_USER);
        if (user == null) {
            res.sendRedirect(req.getContextPath() + "/login?role=RECEPTIONIST");
            return;
        }

        // Role-based protection
        if (path.contains("/admin") && !AppConstants.ROLE_ADMIN.equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/receptionist");
            return;
        }
        if (path.contains("/receptionist") && !AppConstants.ROLE_RECEPTIONIST.equals(user.getRole())) {
            res.sendRedirect(req.getContextPath() + "/admin");
            return;
        }

        chain.doFilter(request, response);
    }
}
