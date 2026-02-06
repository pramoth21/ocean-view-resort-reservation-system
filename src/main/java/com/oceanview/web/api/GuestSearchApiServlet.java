package com.oceanview.web.api;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.Guest;
import com.oceanview.util.JsonUtil;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class GuestSearchApiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String contact = req.getParameter("contact");
        String name = req.getParameter("name");
        String reservationId = req.getParameter("reservationId");

        // 1) by contact (best)
        if (contact != null && !contact.trim().isEmpty()) {
            Guest g = DaoFactory.guestDao().findByContactNumber(contact.trim());
            if (g == null) {
                resp.getWriter().write("{\"ok\":false,\"message\":\"Guest not found\"}");
            } else {
                resp.getWriter().write(singleGuestJson(g));
            }
            return;
        }

        // 2) by reservation id
        if (reservationId != null && !reservationId.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(reservationId.trim());
                Guest g = DaoFactory.guestDao().findByReservationNo(id);
                if (g == null) resp.getWriter().write("{\"ok\":false,\"message\":\"Guest not found\"}");
                else resp.getWriter().write(singleGuestJson(g));
            } catch (Exception e) {
                resp.getWriter().write("{\"ok\":false,\"message\":\"Invalid reservation id\"}");
            }
            return;
        }

        // 3) by name list
        if (name != null && !name.trim().isEmpty()) {
            List<Guest> list = DaoFactory.guestDao().findByNameLike(name.trim());
            StringBuilder sb = new StringBuilder();
            sb.append("{\"ok\":true,\"results\":[");
            for (int i = 0; i < list.size(); i++) {
                Guest g = list.get(i);
                sb.append("{")
                        .append("\"guestId\":").append(g.getGuestId()).append(",")
                        .append("\"name\":\"").append(JsonUtil.escape(g.getName())).append("\",")
                        .append("\"address\":\"").append(JsonUtil.escape(g.getAddress())).append("\",")
                        .append("\"contact\":\"").append(JsonUtil.escape(g.getContactNumber())).append("\"")
                        .append("}");
                if (i < list.size() - 1) sb.append(",");
            }
            sb.append("]}");
            resp.getWriter().write(sb.toString());
            return;
        }

        resp.getWriter().write("{\"ok\":false,\"message\":\"Provide contact OR name OR reservationId\"}");
    }

    private String singleGuestJson(Guest g) {
        return "{"
                + "\"ok\":true,"
                + "\"guestId\":" + g.getGuestId() + ","
                + "\"name\":\"" + JsonUtil.escape(g.getName()) + "\","
                + "\"address\":\"" + JsonUtil.escape(g.getAddress()) + "\","
                + "\"contact\":\"" + JsonUtil.escape(g.getContactNumber()) + "\""
                + "}";
    }
}