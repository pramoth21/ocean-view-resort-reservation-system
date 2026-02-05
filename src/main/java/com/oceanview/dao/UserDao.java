package com.oceanview.dao;

import com.oceanview.model.User;

import java.util.List;

public interface UserDao {
    User findByUsernameAndPassword(String username, String password);
    boolean createReceptionist(String username, String hashedPassword);
    List<User> findAllReceptionists();
    boolean deleteReceptionist(int userId);
}
