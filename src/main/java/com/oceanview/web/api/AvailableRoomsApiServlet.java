package com.oceanview.web.api;

import com.oceanview.dao.DaoFactory;
import com.oceanview.util.DateUtil;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

public class AvailableRoomsApiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            String type = req.getParameter("type");
            LocalDate inDate = DateUtil.parseDate(req.getParameter("checkIn"));
            LocalDate outDate = DateUtil.parseDate(req.getParameter("checkOut"));

            String json = DaoFactory.roomDao().availableRoomsJson(type, inDate, outDate);
            resp.getWriter().write(json);

        } catch (Exception e) {
            resp.getWriter().write("{\"ok\":false,\"message\":\"Invalid inputs\"}");
        }
    }
}