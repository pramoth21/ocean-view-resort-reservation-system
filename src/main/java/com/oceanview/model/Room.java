package com.oceanview.model;

public class Room {
    private int roomId;
    private String roomNo;
    private int roomTypeId;
    private String typeCode; // for display
    private boolean active;

    public Room() {}

    public Room(int roomId, String roomNo, int roomTypeId, String typeCode, boolean active) {
        this.roomId = roomId;
        this.roomNo = roomNo;
        this.roomTypeId = roomTypeId;
        this.typeCode = typeCode;
        this.active = active;
    }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public String getRoomNo() { return roomNo; }
    public void setRoomNo(String roomNo) { this.roomNo = roomNo; }

    public int getRoomTypeId() { return roomTypeId; }
    public void setRoomTypeId(int roomTypeId) { this.roomTypeId = roomTypeId; }

    public String getTypeCode() { return typeCode; }
    public void setTypeCode(String typeCode) { this.typeCode = typeCode; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}