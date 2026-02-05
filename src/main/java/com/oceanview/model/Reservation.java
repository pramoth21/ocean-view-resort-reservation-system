package com.oceanview.model;

import java.time.LocalDate;

/**
 * Reservation entity represents a room booking.
 * Each reservation is linked to exactly one Guest.
 */
public class Reservation {

    private int reservationNo;


    private Guest guest;

    private String roomType;
    private LocalDate checkIn;
    private LocalDate checkOut;
    private String status;

    // Empty constructor
    public Reservation() {}

    // Full constructor
    public Reservation(int reservationNo, Guest guest, String roomType,
                       LocalDate checkIn, LocalDate checkOut, String status) {
        this.reservationNo = reservationNo;
        this.guest = guest;
        this.roomType = roomType;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.status = status;
    }

    // ---------- Getters & Setters ----------

    public int getReservationNo() {
        return reservationNo;
    }

    public void setReservationNo(int reservationNo) {
        this.reservationNo = reservationNo;
    }


    public Guest getGuest() {
        return guest;
    }

    public void setGuest(Guest guest) {
        this.guest = guest;
    }

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public LocalDate getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(LocalDate checkIn) {
        this.checkIn = checkIn;
    }

    public LocalDate getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(LocalDate checkOut) {
        this.checkOut = checkOut;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
