package org.khmeracademy.auction.entities.input;

import org.khmeracademy.auction.entities.User;

public class AddTopUp {
	private int top_up_id;
	private int user_id;     // user object
	private String currency;
	private double amount;

	public int getTop_up_id() {
		return top_up_id;
	}
	public void setTop_up_id(int top_up_id) {
		this.top_up_id = top_up_id;
	}
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
}
