package com.oceanview.dao;

import com.oceanview.model.User;

public interface UserDao {
    User findByUsernameAndPassword(String username, String password);
}
