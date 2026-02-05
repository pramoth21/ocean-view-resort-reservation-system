package com.oceanview.model;

public class Bill {
    private int reservationNo;
    private int nights;
    private double rate;
    private double discount;
    private double total;

    public Bill(int reservationNo, int nights, double rate, double discount, double total) {
        this.reservationNo = reservationNo;
        this.nights = nights;
        this.rate = rate;
        this.discount = discount;
        this.total = total;
    }

    public int getReservationNo() { return reservationNo; }
    public int getNights() { return nights; }
    public double getRate() { return rate; }
    public double getDiscount() { return discount; }
    public double getTotal() { return total; }
}
