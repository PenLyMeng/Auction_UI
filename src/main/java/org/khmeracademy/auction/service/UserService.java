package org.khmeracademy.auction.service;

import org.khmeracademy.auction.entities.User;

public interface UserService {
	public User getUserByName(String user_name);
	
	public User findUserByUserHash(String user_hash);
	public boolean registerUser(String user_hash);

}
