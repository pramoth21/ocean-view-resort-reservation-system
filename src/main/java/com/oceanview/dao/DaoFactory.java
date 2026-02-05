package com.oceanview.dao;

import com.oceanview.dao.impl.GuestDaoImpl;
import com.oceanview.dao.impl.ReservationDaoImpl;
import com.oceanview.dao.impl.RoomRateDaoImpl;
import com.oceanview.dao.impl.UserDaoImpl;

public class DaoFactory {
    public static UserDao userDao() { return new UserDaoImpl(); }
    public static ReservationDao reservationDao() { return new ReservationDaoImpl(); }
    public static RoomRateDao roomRateDao() {return new RoomRateDaoImpl();}
    public static GuestDao guestDao() {return new GuestDaoImpl();}
}
