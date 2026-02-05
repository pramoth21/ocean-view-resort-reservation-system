package com.oceanview.service;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.model.RoomRate;
import com.oceanview.util.DateUtil;

/**
 * BillingService handles bill calculation logic.
 */
public class BillingService {


    public Bill calculateBill(Reservation reservation, double discountPercent) {

        int nights = DateUtil.nightsBetween(
                reservation.getCheckIn(),
                reservation.getCheckOut()
        );


        RoomRate roomRate =
                DaoFactory.roomRateDao().getRoomRate(reservation.getRoomType());

        if (roomRate == null) {
            throw new RuntimeException("Room rate not found for type: "
                    + reservation.getRoomType());
        }

        double ratePerNight = roomRate.getPricePerNight();

        double gross = nights * ratePerNight;
        double discount = gross * (discountPercent / 100.0);
        double total = gross - discount;

        return new Bill(
                reservation.getReservationNo(),
                nights,
                ratePerNight,
                discount,
                total
        );
    }
}
