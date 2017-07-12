package org.khmeracademy.auction.entities.input;

import java.util.Date;

public class AddBid {
	
	private int auction_id;
	private int user_id;
	private double current_price;
	private Date bid_date;
	
	public int getAuction_id() {
		return auction_id;
	}
	public void setAuction_id(int auction_id) {
		this.auction_id = auction_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public double getCurrent_price() {
		return current_price;
	}
	public void setCurrent_price(double current_price) {
		this.current_price = current_price;
	}
	public Date getBid_date() {
		return bid_date;
	}
	public void setBid_date(Date bid_date) {
		this.bid_date = bid_date;
	}
	
}
