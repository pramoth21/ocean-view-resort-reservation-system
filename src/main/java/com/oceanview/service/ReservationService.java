package com.oceanview.service;

import com.oceanview.dao.DaoFactory;
import com.oceanview.dao.GuestDao;
import com.oceanview.dao.ReservationDao;
import com.oceanview.model.Guest;
import com.oceanview.model.Reservation;

import java.util.List;

/**
 * ReservationService handles all business logic related to
 * guests and reservations.
 */
public class ReservationService {

    private final GuestDao guestDao;
    private final ReservationDao reservationDao;

    public ReservationService() {
        this.guestDao = DaoFactory.guestDao();
        this.reservationDao = DaoFactory.reservationDao();
    }

    /**
     * Add a new reservation.
     * Steps:
     * 1. Check if guest already exists (by contact number)
     * 2. If not exists, save new guest
     * 3. Link guest to reservation
     * 4. Save reservation
     *
     * @param guest Guest details entered by receptionist
     * @param reservation Reservation details
     * @return generated reservation number, or -1 if failed
     */
    public int addReservation(Guest guest, Reservation reservation) {

        // 1️⃣ Check if guest already exists
        Guest existingGuest = guestDao.findByContactNumber(guest.getContactNumber());

        if (existingGuest == null) {
            // 2️⃣ Guest does NOT exist → save new guest
            int guestId = guestDao.save(guest);
            guest.setGuestId(guestId);
        } else {
            // 3️⃣ Guest exists → reuse existing guest
            guest = existingGuest;
        }

        // 4️⃣ Attach guest to reservation
        reservation.setGuest(guest);

        // 5️⃣ Save reservation
        return reservationDao.insert(reservation);
    }

    /**
     * Get reservation by reservation number.
     */
    public Reservation getReservation(int reservationNo) {
        return reservationDao.findById(reservationNo);
    }

    /**
     * Modify an existing reservation.
     * (Guest is NOT modified here)
     */
    public boolean modifyReservation(Reservation reservation) {
        return reservationDao.update(reservation);
    }

    /**
     * Cancel a reservation.
     */
    public boolean cancelReservation(int reservationNo) {
        return reservationDao.cancel(reservationNo);
    }

    /**
     * List all active reservations.
     */
    public List<Reservation> listActiveReservations() {
        return reservationDao.findAllActive();
    }
}
