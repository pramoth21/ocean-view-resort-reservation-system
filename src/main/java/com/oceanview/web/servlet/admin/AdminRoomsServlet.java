package com.oceanview.web.servlet.admin;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.RoomType;

import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;

public class AdminRoomsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("rooms", DaoFactory.roomAdminDao().findAll());
        req.setAttribute("types", DaoFactory.roomTypeDao().findAll());

        req.getRequestDispatcher("/WEB-INF/views/admin_rooms.jsp")
                .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String action = req.getParameter("action");

        try {

            if ("createType".equals(action)) {

                RoomType t = new RoomType();
                t.setTypeCode(req.getParameter("typeCode"));
                t.setTypeName(req.getParameter("typeName"));
                t.setDescription(req.getParameter("description"));
                t.setImagePath(req.getParameter("imagePath"));
                t.setActive("1".equals(req.getParameter("active")));

                DaoFactory.roomTypeDao().create(t);

            } else if ("toggleType".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));
                boolean active = "1".equals(req.getParameter("active"));
                DaoFactory.roomTypeDao().setActive(id, active);

            } else if ("createRoom".equals(action)) {

                String roomNo = req.getParameter("roomNo");
                int typeId = Integer.parseInt(req.getParameter("roomTypeId"));
                boolean active = "1".equals(req.getParameter("active"));

                DaoFactory.roomAdminDao().create(roomNo, typeId, active);

            } else if ("toggleRoom".equals(action)) {

                int id = Integer.parseInt(req.getParameter("id"));
                boolean active = "1".equals(req.getParameter("active"));
                DaoFactory.roomAdminDao().setActive(id, active);
            }

        } catch (Exception ignored) {}

        resp.sendRedirect(req.getContextPath() + "/admin/rooms");
    }
}