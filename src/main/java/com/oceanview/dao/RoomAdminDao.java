package com.oceanview.dao;

import com.oceanview.model.Room;
import java.util.List;

public interface RoomAdminDao {
    List<Room> findAll();
    boolean create(String roomNo, int roomTypeId, boolean active);
    boolean setActive(int roomId, boolean active);
}