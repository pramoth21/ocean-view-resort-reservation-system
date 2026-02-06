package com.oceanview.web.servlet.admin;

import com.oceanview.dao.DaoFactory;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminRatesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("rates", DaoFactory.roomRate2Dao().findAll());
        req.setAttribute("types", DaoFactory.roomTypeDao().findAll());
        req.getRequestDispatcher("/WEB-INF/views/admin_rates.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");

        if ("create".equals(action)) {
            int typeId = Integer.parseInt(req.getParameter("roomTypeId"));
            double price = Double.parseDouble(req.getParameter("price"));
            boolean active = "1".equals(req.getParameter("active"));
            DaoFactory.roomRate2Dao().create(typeId, price, active);
        } else if ("update".equals(action)) {
            int rateId = Integer.parseInt(req.getParameter("rateId"));
            double price = Double.parseDouble(req.getParameter("price"));
            DaoFactory.roomRate2Dao().update(rateId, price);
        } else if ("toggle".equals(action)) {
            int rateId = Integer.parseInt(req.getParameter("rateId"));
            boolean active = "1".equals(req.getParameter("active"));
            DaoFactory.roomRate2Dao().setActive(rateId, active);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/rates");
    }
}