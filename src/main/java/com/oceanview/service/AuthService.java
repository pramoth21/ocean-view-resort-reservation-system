package com.oceanview.service;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.User;

public class AuthService {
    public User login(String username, String password) {
        return DaoFactory.userDao().findByUsernameAndPassword(username, password);
    }
}