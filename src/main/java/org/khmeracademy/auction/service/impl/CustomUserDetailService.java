package org.khmeracademy.auction.service.impl;

import org.khmeracademy.auction.entities.User;
import org.khmeracademy.auction.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service("CustomUserDetailService")
public class CustomUserDetailService implements UserDetailsService {
	
	@Autowired
	private UserService userService;
	
	@Override
	public UserDetails loadUserByUsername(String user_name) throws UsernameNotFoundException {
		User user = userService.getUserByName(user_name);
		if(user == null){
			System.out.println("User not found");
			throw new UsernameNotFoundException("User not found");
		}
		System.out.println(user.getRoles().get(0).getRole_name());
	
		return user;
	}

}
