package com.oceanview.dao;

import com.oceanview.model.ServiceItem;
import java.util.List;
import java.util.Map;

public interface ServiceDao {

    // used by billing
    Map<String, Double> getActiveServicePricesByCodes(String[] codes);

    // admin management
    List<ServiceItem> findAll();
    boolean create(ServiceItem s);
    boolean update(ServiceItem s);
    boolean setActive(int serviceId, boolean active);
}