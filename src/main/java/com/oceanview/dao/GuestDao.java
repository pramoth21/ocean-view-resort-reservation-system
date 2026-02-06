package com.oceanview.dao;

import com.oceanview.model.Guest;
import java.util.List;

public interface GuestDao {
    Guest findByContactNumber(String contactNumber);
    int save(Guest guest);

    // NEW:
    Guest findById(int guestId);
    List<Guest> findByNameLike(String name);
    Guest findByReservationNo(int reservationNo);
}