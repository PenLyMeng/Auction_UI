package org.khmeracademy.auction.controllers;

import java.util.Date;
import java.util.Map;

import org.khmeracademy.auction.entities.User;
import org.khmeracademy.auction.entities.input.AddBid;
import org.khmeracademy.auction.entities.input.AddInvoice;
import org.khmeracademy.auction.filtering.BidFilter;
import org.khmeracademy.auction.filtering.SupplierFilter;
import org.khmeracademy.auction.utils.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/rest/bidhistory")
public class BidHistoryController {
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addNewBidHistory(@RequestBody AddBid addBid, @AuthenticationPrincipal User user){
		
		System.out.println(user.getUser_id());
		addBid.setUser_id(user.getUser_id());
		//addBid.setBid_date(new Date());
		HttpEntity<AddBid> request = new HttpEntity<AddBid>(addBid, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/add-bid-history", HttpMethod.POST , request , Map.class) ;
		return new ResponseEntity<Map<String, Object>>(response.getBody(), response.getStatusCode());
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findAllBidHistory(BidFilter filter, Pagination pagination){
		
		String url  = UriComponentsBuilder.fromHttpUrl(WS_URL + "/find-all-bid-history")
				.queryParam("page",pagination.getPage())
				.queryParam("limit", pagination.getLimit())
				.queryParam("userName", filter.getUserName())
				.toUriString();
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange( url , HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	//TODO: GET TOTAL BID
	@RequestMapping(value="/total-bid-price", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findTotalBidCurrentPrice(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-total-bid-price", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	// Get Bid History By User_Id
	@RequestMapping(value="/{user_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findBidByUserId(@PathVariable int user_id){
		
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-number-bid-by-user-id-for-each-auction-in-details/" + user_id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}	
	
	
	// Get Bid History By Auction_Id -- 23/08/2016 -- BY EAN SOKCHOMRERN
	@RequestMapping(value="/find-num-bid-and-bidder-in-auction-product-by-auc-id/{auction_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findBidHistoryByAuctionId(@PathVariable int auction_id){
		
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-num-bid-and-bidder-in-auction-product-by-auc-id/" + auction_id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}	
	
	
	//TODO: ADD INVOICE TO INVOICE AND INVOICE DETATIL
	@RequestMapping(value="/add-invoice", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addInvoice(@RequestBody AddInvoice addinvoice){
		
		
		HttpEntity<AddInvoice> request = new HttpEntity<AddInvoice>(addinvoice, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/add-invoice", HttpMethod.POST , request , Map.class) ;
		return new ResponseEntity<Map<String, Object>>(response.getBody(), response.getStatusCode());
	}
	
	// Get all bid winners -- 04/10/2016 -- BY EAN SOKCHOMRERN
//	@RequestMapping(value="/find-all-bid-winners", method = RequestMethod.GET)
//	public ResponseEntity<Map<String, Object>> findAllBidWinners(){
//		
//		HttpEntity<Object> request = new HttpEntity<Object>(header);
//		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-all-bid-winners-with-winner-id" , HttpMethod.GET , request , Map.class) ;
//		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
//		
//		
//	}	
	
	// Get all bid winners -- 04/10/2016 -- BY EAN SOKCHOMRERN
	@RequestMapping(value="/find-all-bid-winners", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findAllBidWinners(BidFilter filter, Pagination pagination){
		
		String url  = UriComponentsBuilder.fromHttpUrl(WS_URL + "/find-all-bid-winners-with-winner-id")
				.queryParam("page",pagination.getPage())
				.queryParam("limit", pagination.getLimit())
				.queryParam("userName", filter.getUserName())
				.toUriString();
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange( url , HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}

}
