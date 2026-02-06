package com.oceanview.model;

public class ServiceItem {
    private int serviceId;
    private String serviceCode;  // POOL / DINING / LAUNDRY
    private String serviceName;
    private double price;
    private boolean active;

    public ServiceItem() {}

    public ServiceItem(int serviceId, String serviceCode, String serviceName, double price, boolean active) {
        this.serviceId = serviceId;
        this.serviceCode = serviceCode;
        this.serviceName = serviceName;
        this.price = price;
        this.active = active;
    }

    public int getServiceId() { return serviceId; }
    public void setServiceId(int serviceId) { this.serviceId = serviceId; }

    public String getServiceCode() { return serviceCode; }
    public void setServiceCode(String serviceCode) { this.serviceCode = serviceCode; }

    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}