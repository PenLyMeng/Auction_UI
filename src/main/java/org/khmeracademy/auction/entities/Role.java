package org.khmeracademy.auction.entities;

import java.io.Serializable;

import org.springframework.security.core.GrantedAuthority;

public class Role implements Serializable, GrantedAuthority {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3171711552786598575L;
	private int role_id;
	private String role_name;
	
	public int getRole_id() {
		return role_id;
	}
	public void setRole_id(int role_id) {
		this.role_id = role_id;
	}
	public String getRole_name() {
		return role_name;
	}
	public void setRole_name(String role_name) {
		this.role_name = role_name;
	}
	
	@Override
	public String getAuthority() {
		// TODO Auto-generated method stub
		return role_name;
	}
	
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
