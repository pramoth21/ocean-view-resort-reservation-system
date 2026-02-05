package com.oceanview.web.servlet.admin;

import com.oceanview.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class UserManageServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("users", userService.listReceptionists());
        req.getRequestDispatcher("/WEB-INF/views/admin_users.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        try {
            int userId = Integer.parseInt(req.getParameter("userId"));
            userService.removeReceptionist(userId);
        } catch (Exception ignored) {}

        resp.sendRedirect(req.getContextPath() + "/admin/users");
    }
}