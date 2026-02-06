package com.oceanview.dao;

import com.oceanview.model.RoomType;
import java.util.List;

public interface RoomTypeDao {
    List<RoomType> findAll();
    RoomType findById(int id);
    boolean create(RoomType t);
    boolean update(RoomType t);
    boolean setActive(int id, boolean active);
}