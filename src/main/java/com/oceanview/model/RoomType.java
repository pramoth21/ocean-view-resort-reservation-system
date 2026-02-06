package com.oceanview.model;

public class RoomType {
    private int roomTypeId;
    private String typeCode;     // e.g. STANDARD
    private String typeName;     // e.g. Standard Room
    private String description;
    private String imagePath;
    private boolean active;

    public RoomType() {}

    public RoomType(int roomTypeId, String typeCode, String typeName, String description, String imagePath, boolean active) {
        this.roomTypeId = roomTypeId;
        this.typeCode = typeCode;
        this.typeName = typeName;
        this.description = description;
        this.imagePath = imagePath;
        this.active = active;
    }

    public int getRoomTypeId() { return roomTypeId; }
    public void setRoomTypeId(int roomTypeId) { this.roomTypeId = roomTypeId; }

    public String getTypeCode() { return typeCode; }
    public void setTypeCode(String typeCode) { this.typeCode = typeCode; }

    public String getTypeName() { return typeName; }
    public void setTypeName(String typeName) { this.typeName = typeName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}