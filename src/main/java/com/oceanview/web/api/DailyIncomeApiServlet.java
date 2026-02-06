package com.oceanview.web.api;

import com.oceanview.service.ReportService;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

public class DailyIncomeApiServlet extends HttpServlet {

    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        StringBuilder sb = new StringBuilder();
        sb.append("{\"ok\":true,\"days\":[");
        for (int i = 6; i >= 0; i--) {
            LocalDate d = LocalDate.now().minusDays(i);
            double rev = reportService.getRevenueForDate(d);
            sb.append("{\"date\":\"").append(d).append("\",\"revenue\":").append(rev).append("}");
            if (i != 0) sb.append(",");
        }
        sb.append("]}");

        resp.getWriter().write(sb.toString());
    }
}