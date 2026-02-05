package com.oceanview.web.servlet;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class ReportsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/reports.jsp").forward(req, resp);
    }
}