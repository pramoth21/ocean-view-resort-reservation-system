package com.oceanview.model;

public class RoomRate {
    private String roomType;
    private double pricePerNight;
    private String imagePath;

    public RoomRate(String roomType, double pricePerNight, String imagePath) {
        this.roomType = roomType;
        this.pricePerNight = pricePerNight;
        this.imagePath = imagePath;
    }

    public String getRoomType() {
        return roomType;
    }

    public double getPricePerNight() {
        return pricePerNight;
    }

    public String getImagePath() {
        return imagePath;
    }
}
