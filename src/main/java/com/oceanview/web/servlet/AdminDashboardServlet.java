package com.oceanview.web.servlet;

import com.oceanview.service.ReportService;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminDashboardServlet extends HttpServlet {
    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("revenue", reportService.getTotalRevenueFromBills());
        req.getRequestDispatcher("/WEB-INF/views/admin_dashboard.jsp").forward(req, resp);
    }
}
