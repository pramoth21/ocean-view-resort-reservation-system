package com.oceanview.dao;

import com.oceanview.model.Reservation;

import java.util.List;

public interface ReservationDao {
    int insert(Reservation r);

    Reservation findById(int reservationNo);

    boolean update(Reservation r);

    boolean cancel(int reservationNo);

    boolean updateStatus(int reservationNo, String status);

    List<Reservation> findAllActive();
}
