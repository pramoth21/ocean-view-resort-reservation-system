package com.oceanview.model;

public class RoomRate2 {
    private int rateId;
    private int roomTypeId;
    private String typeCode; // for display
    private double pricePerNight;
    private boolean active;

    public RoomRate2() {}

    public RoomRate2(int rateId, int roomTypeId, String typeCode, double pricePerNight, boolean active) {
        this.rateId = rateId;
        this.roomTypeId = roomTypeId;
        this.typeCode = typeCode;
        this.pricePerNight = pricePerNight;
        this.active = active;
    }

    public int getRateId() { return rateId; }
    public void setRateId(int rateId) { this.rateId = rateId; }

    public int getRoomTypeId() { return roomTypeId; }
    public void setRoomTypeId(int roomTypeId) { this.roomTypeId = roomTypeId; }

    public String getTypeCode() { return typeCode; }
    public void setTypeCode(String typeCode) { this.typeCode = typeCode; }

    public double getPricePerNight() { return pricePerNight; }
    public void setPricePerNight(double pricePerNight) { this.pricePerNight = pricePerNight; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}