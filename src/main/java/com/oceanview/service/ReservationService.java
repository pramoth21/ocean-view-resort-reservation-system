package com.oceanview.service;

import com.oceanview.dao.DaoFactory;
import com.oceanview.dao.GuestDao;
import com.oceanview.dao.ReservationDao;
import com.oceanview.model.Guest;
import com.oceanview.model.Reservation;

import java.util.List;

public class ReservationService {

    private final GuestDao guestDao;
    private final ReservationDao reservationDao;

    public ReservationService() {
        this.guestDao = DaoFactory.guestDao();
        this.reservationDao = DaoFactory.reservationDao();
    }

    // NEW: for guestId reuse
    public Guest getGuestById(int id) {
        return guestDao.findById(id);
    }

    public int addReservation(Guest guest, Reservation reservation) {

        // If guest already has ID, skip registering (re-use existing guest)
        if (guest.getGuestId() > 0) {
            Guest dbGuest = guestDao.findById(guest.getGuestId());
            if (dbGuest == null)
                return -1;
            reservation.setGuest(dbGuest);
            return reservationDao.insert(reservation);
        }

        // Old flow (contact check)
        Guest existingGuest = guestDao.findByContactNumber(guest.getContactNumber());

        if (existingGuest == null) {
            int guestId = guestDao.save(guest);
            guest.setGuestId(guestId);
        } else {
            guest = existingGuest;
        }

        reservation.setGuest(guest);
        return reservationDao.insert(reservation);
    }

    public Reservation getReservation(int reservationNo) {
        return reservationDao.findById(reservationNo);
    }

    public boolean modifyReservation(Reservation reservation) {
        return reservationDao.update(reservation);
    }

    public boolean cancelReservation(int reservationNo) {
        return reservationDao.cancel(reservationNo);
    }

    public boolean updateStatus(int reservationNo, String status) {
        return reservationDao.updateStatus(reservationNo, status);
    }

    public List<Reservation> listActiveReservations() {
        return reservationDao.findAllActive();
    }
}