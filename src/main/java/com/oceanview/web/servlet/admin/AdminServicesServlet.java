package com.oceanview.web.servlet.admin;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.ServiceItem;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminServicesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("services", DaoFactory.serviceDao().findAll());
        req.getRequestDispatcher("/WEB-INF/views/admin_services.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String action = req.getParameter("action");

        if ("create".equals(action)) {
            ServiceItem s = new ServiceItem();
            s.setServiceCode(req.getParameter("serviceCode"));
            s.setServiceName(req.getParameter("serviceName"));
            s.setPrice(Double.parseDouble(req.getParameter("price")));
            s.setActive("1".equals(req.getParameter("active")));
            DaoFactory.serviceDao().create(s);
        } else if ("update".equals(action)) {
            ServiceItem s = new ServiceItem();
            s.setServiceId(Integer.parseInt(req.getParameter("serviceId")));
            s.setServiceCode(req.getParameter("serviceCode"));
            s.setServiceName(req.getParameter("serviceName"));
            s.setPrice(Double.parseDouble(req.getParameter("price")));
            DaoFactory.serviceDao().update(s);
        } else if ("toggle".equals(action)) {
            int id = Integer.parseInt(req.getParameter("serviceId"));
            boolean active = "1".equals(req.getParameter("active"));
            DaoFactory.serviceDao().setActive(id, active);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/services");
    }
}