package com.oceanview.web.api;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.Guest;
import com.oceanview.util.JsonUtil;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class GuestByContactApiServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {


        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String contact = req.getParameter("contact");

        if (contact == null || contact.trim().isEmpty()) {
            resp.getWriter().write(
                    "{\"ok\":false,\"message\":\"Contact number required\"}"
            );
            return;
        }

        Guest guest = DaoFactory.guestDao().findByContactNumber(contact);

        if (guest == null) {
            resp.getWriter().write(
                    "{\"ok\":false,\"message\":\"Guest not found\"}"
            );
            return;
        }

        String json = "{"
                + "\"ok\":true,"
                + "\"guestId\":" + guest.getGuestId() + ","
                + "\"name\":\"" + JsonUtil.escape(guest.getName()) + "\","
                + "\"address\":\"" + JsonUtil.escape(guest.getAddress()) + "\","
                + "\"contact\":\"" + JsonUtil.escape(guest.getContactNumber()) + "\""
                + "}";

        resp.getWriter().write(json);
    }
}
