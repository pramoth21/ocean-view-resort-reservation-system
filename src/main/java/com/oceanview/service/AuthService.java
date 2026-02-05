package com.oceanview.service;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.User;
import com.oceanview.util.PasswordUtil;

public class AuthService {
    public User login(String username, String password) {
        String hashed = PasswordUtil.hashPassword(password);
        return DaoFactory.userDao()
                .findByUsernameAndPassword(username, hashed);
    }
}