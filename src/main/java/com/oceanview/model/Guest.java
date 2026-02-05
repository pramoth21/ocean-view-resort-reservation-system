package com.oceanview.model;

public class Guest {

    private int guestId;
    private String name;
    private String address;
    private String contactNumber;

    public Guest() {}

    public Guest(String name, String address, String contactNumber) {
        this.name = name;
        this.address = address;
        this.contactNumber = contactNumber;
    }

    public Guest(int guestId, String name, String address, String contactNumber) {
        this.guestId = guestId;
        this.name = name;
        this.address = address;
        this.contactNumber = contactNumber;
    }

    public int getGuestId() {
        return guestId;
    }

    public void setGuestId(int guestId) {
        this.guestId = guestId;
    }

    public String getName() {
        return name;
    }

    public String getAddress() {
        return address;
    }

    public String getContactNumber() {
        return contactNumber;
    }
}