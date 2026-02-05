package com.oceanview.dao;

import com.oceanview.model.Guest;

public interface GuestDao {

    Guest findByContactNumber(String contactNumber);

    int save(Guest guest);
}