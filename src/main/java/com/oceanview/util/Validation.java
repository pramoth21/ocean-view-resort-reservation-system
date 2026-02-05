package com.oceanview.util;

import java.time.LocalDate;

public class Validation {

    public static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }


    public static String validateReservationInputs(
            String guestName,
            String address,
            String contact,
            String roomType,
            LocalDate checkIn,
            LocalDate checkOut
    ) {
        if (isBlank(guestName))
            return "Guest name is required.";

        if (isBlank(address))
            return "Address is required.";

        if (isBlank(contact))
            return "Contact number is required.";

        if (!contact.matches("\\d{10}"))
            return "Contact number must contain 10 digits.";

        return validateDatesAndRoom(roomType, checkIn, checkOut);
    }


    public static String validateReservationDates(
            String roomType,
            LocalDate checkIn,
            LocalDate checkOut
    ) {
        return validateDatesAndRoom(roomType, checkIn, checkOut);
    }

    private static String validateDatesAndRoom(
            String roomType,
            LocalDate checkIn,
            LocalDate checkOut
    ) {
        if (isBlank(roomType))
            return "Room type is required.";

        if (checkIn == null || checkOut == null)
            return "Check-in and check-out dates are required.";

        if (!checkOut.isAfter(checkIn))
            return "Check-out date must be after check-in date.";

        if (checkIn.isBefore(LocalDate.now()))
            return "Check-in date cannot be in the past.";

        return null; // ✅ Valid
    }
}
