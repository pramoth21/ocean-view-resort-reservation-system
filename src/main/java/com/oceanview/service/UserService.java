package com.oceanview.service;

import com.oceanview.dao.DaoFactory;
import com.oceanview.model.User;
import com.oceanview.util.PasswordUtil;

import java.util.List;

public class UserService {

    public boolean registerReceptionist(String username, String rawPassword) {
        String hashed = PasswordUtil.hashPassword(rawPassword);
        return DaoFactory.userDao().createReceptionist(username, hashed);
    }

    public List<User> listReceptionists() {
        return DaoFactory.userDao().findAllReceptionists();
    }

    public boolean removeReceptionist(int userId) {
        return DaoFactory.userDao().deleteReceptionist(userId);
    }
}