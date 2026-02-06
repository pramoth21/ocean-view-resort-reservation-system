package com.oceanview.dao;

import java.time.LocalDate;

public interface RoomDao {

    String availableRoomsJson(String typeCode, LocalDate checkIn, LocalDate checkOut);
}