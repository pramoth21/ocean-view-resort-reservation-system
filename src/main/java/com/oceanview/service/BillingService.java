package com.oceanview.service;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.Bill;
import com.oceanview.model.Reservation;
import com.oceanview.model.RoomRate2;
import com.oceanview.util.DateUtil;

import java.util.List;


public class BillingService {

    public Bill calculateBill(Reservation reservation, double discountPercent) {

        int nights = DateUtil.nightsBetween(
                reservation.getCheckIn(),
                reservation.getCheckOut()
        );

        // 🔥 Use NEW room_rates2 table
        List<RoomRate2> rates = DaoFactory.roomRate2Dao().findAll();

        double ratePerNight = 0.0;

        for (RoomRate2 r : rates) {
            if (r.getTypeCode().equalsIgnoreCase(reservation.getRoomType())
                    && r.isActive()) {
                ratePerNight = r.getPricePerNight();
                break;
            }
        }

        if (ratePerNight == 0.0) {
            throw new RuntimeException(
                    "Active room rate not found for type: "
                            + reservation.getRoomType()
            );
        }

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