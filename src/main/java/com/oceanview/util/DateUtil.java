package com.oceanview.util;

import java.time.LocalDate;

public class DateUtil {
    public static LocalDate parseDate(String val) {
        return LocalDate.parse(val); // expects yyyy-MM-dd from <input type="date">
    }

    public static int nightsBetween(LocalDate in, LocalDate out) {
        return (int) (out.toEpochDay() - in.toEpochDay());
    }
}
