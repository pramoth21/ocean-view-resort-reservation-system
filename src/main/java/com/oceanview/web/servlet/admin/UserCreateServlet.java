package com.oceanview.web.servlet.admin;

import com.oceanview.service.UserService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class UserCreateServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || password == null ||
                username.trim().isEmpty() || password.trim().isEmpty()) {

            resp.sendRedirect(req.getContextPath()
                    + "/admin/users?error=All+fields+required");
            return;
        }

        boolean ok = userService.registerReceptionist(username, password);

        if (ok) {
            resp.sendRedirect(req.getContextPath()
                    + "/admin/users?msg=Receptionist+created+successfully");
        } else {
            resp.sendRedirect(req.getContextPath()
                    + "/admin/users?error=Username+already+exists");
        }
    }
}