package com.oceanview.web.servlet;

import com.oceanview.AppConstants;
import com.oceanview.model.User;
import com.oceanview.service.AuthService;
import com.oceanview.util.Validation;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("role", req.getParameter("role"));
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String roleWanted = req.getParameter("role");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (Validation.isBlank(username) || Validation.isBlank(password)) {
            req.setAttribute("error", "Username and password are required.");
            req.setAttribute("role", roleWanted);
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        User user = authService.login(username, password);
        if (user == null) {
            req.setAttribute("error", "Invalid login details.");
            req.setAttribute("role", roleWanted);
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        // Ensure correct role login
        if (roleWanted != null && !roleWanted.equalsIgnoreCase(user.getRole())) {
            req.setAttribute("error", "Access denied for this role.");
            req.setAttribute("role", roleWanted);
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        req.getSession().setAttribute(AppConstants.SESSION_USER, user);

        if (AppConstants.ROLE_ADMIN.equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/admin");
        } else {
            resp.sendRedirect(req.getContextPath() + "/receptionist");
        }
    }
}
