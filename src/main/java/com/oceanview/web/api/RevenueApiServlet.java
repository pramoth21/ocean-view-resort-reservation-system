package com.oceanview.web.api;

import com.oceanview.service.ReportService;

import javax.servlet.http.*;
import java.io.IOException;

public class RevenueApiServlet extends HttpServlet {
    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        double revenue = reportService.getTotalRevenueFromBills();
        resp.getWriter().write("{\"ok\":true,\"revenue\":" + revenue + "}");
    }
}