package com.oceanview.dao;

import com.oceanview.dao.impl.*;
import com.oceanview.dao.impl.RoomAdminDaoImpl;
import com.oceanview.dao.impl.RoomRate2DaoImpl;
import com.oceanview.dao.impl.RoomTypeDaoImpl;

public class DaoFactory {
    public static UserDao userDao() { return new UserDaoImpl(); }
    public static ReservationDao reservationDao() { return new ReservationDaoImpl(); }
    public static GuestDao guestDao() { return new GuestDaoImpl(); }
    public static RoomTypeDao roomTypeDao() { return new RoomTypeDaoImpl(); }
    public static RoomRate2Dao roomRate2Dao() { return new RoomRate2DaoImpl(); }
    public static RoomAdminDao roomAdminDao() { return new RoomAdminDaoImpl(); }
    public static RoomDao roomDao() { return new RoomDaoImpl(); }
    public static ServiceDao serviceDao() { return new ServiceDaoImpl(); }
}