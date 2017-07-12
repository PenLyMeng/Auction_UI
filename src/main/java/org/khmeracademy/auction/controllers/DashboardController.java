package org.khmeracademy.auction.controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/rest/dashboard")
public class DashboardController {
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	@RequestMapping(value="/{bid_date}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findBidHistoryByDate(@PathVariable String bid_date){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-bid-history-by-bid-date/" + bid_date, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	// ==== Today's Auction Transactions ==== EAN SOKCHOMRERN === 06/10/2016
	@RequestMapping(value="/find-all-today-bid", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAllTodayBid(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-all-today-bid", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(value="/find-all-today-bidden-products", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAllTodayBiddenProducts(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-all-today-bidden-products", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(value="/find-all-today-bidders", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAllTodayBidders(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-all-today-bidders", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(value="/find-all-today-new-products", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAllTodayNewProducts(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-all-today-new-products", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(value="/find-today-total-revenue", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findTodayTotalRevenue(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-today-total-revenue", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	// FIND HIGH BIDDING. EAN SOKCHOMRERN. 06/10/2016
	@RequestMapping(value="/find-high-bidding", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findHighBidding(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-high-bidding", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
}
