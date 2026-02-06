package com.oceanview.dao;

import com.oceanview.model.RoomRate2;
import java.util.List;

public interface RoomRate2Dao {
    List<RoomRate2> findAll();
    boolean create(int roomTypeId, double price, boolean active);
    boolean update(int rateId, double price);
    boolean setActive(int rateId, boolean active);
}