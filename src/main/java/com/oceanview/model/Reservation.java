package com.oceanview.model;

import java.time.LocalDate;

/**
 * Reservation entity represents a room booking.
 * Each reservation is linked to exactly one Guest.
 */
public class Reservation {

    private int reservationNo;
    private Guest guest;

    // keep old roomType for compatibility
    private String roomType;

    // NEW: actual room id (nullable)
    private Integer roomId;

    private LocalDate checkIn;
    private LocalDate checkOut;
    private String status;

    public Reservation() {}

    public Reservation(int reservationNo, Guest guest, String roomType,
                       Integer roomId,
                       LocalDate checkIn, LocalDate checkOut, String status) {
        this.reservationNo = reservationNo;
        this.guest = guest;
        this.roomType = roomType;
        this.roomId = roomId;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.status = status;
    }

    public int getReservationNo() { return reservationNo; }
    public void setReservationNo(int reservationNo) { this.reservationNo = reservationNo; }

    public Guest getGuest() { return guest; }
    public void setGuest(Guest guest) { this.guest = guest; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public Integer getRoomId() { return roomId; }
    public void setRoomId(Integer roomId) { this.roomId = roomId; }

    public LocalDate getCheckIn() { return checkIn; }
    public void setCheckIn(LocalDate checkIn) { this.checkIn = checkIn; }

    public LocalDate getCheckOut() { return checkOut; }
    public void setCheckOut(LocalDate checkOut) { this.checkOut = checkOut; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}