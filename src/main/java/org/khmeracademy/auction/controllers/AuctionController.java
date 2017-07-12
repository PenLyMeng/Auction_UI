package org.khmeracademy.auction.controllers;

import java.util.Map;

import org.khmeracademy.auction.entities.User;
import org.khmeracademy.auction.entities.input.AddAuction;
import org.khmeracademy.auction.filtering.AuctionFilter;
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
@RequestMapping("/rest/auction")
public class AuctionController {
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAllAuctions(AuctionFilter filter, Pagination pagination){
		
		String url  = UriComponentsBuilder.fromHttpUrl(WS_URL + "/find-all-auctions")
						.queryParam("page",pagination.getPage())
						.queryParam("limit", pagination.getLimit())
						.queryParam("productName", filter.getProductName())
						.toUriString();
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(url, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(value="/{auction_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAuctionByID(@PathVariable int auction_id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-auction-by-id/" + auction_id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	//Get auction product by category
	@RequestMapping(value="/auc-pro-category/{category_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAuctionProductByCategory(@PathVariable("category_id") int id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-auction-product-by-category-id/" + id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	//Get auction brand by category
	@RequestMapping(value="/auc-brand-category/{category_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAuctionBrandByCategory(@PathVariable("category_id") int id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-auction-brand-by-category-id/" + id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	//Find all best bidding auction
	@RequestMapping(value="/find-all-best-bidding-auctions", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAllBestBiddingAuctions(AuctionFilter filter, Pagination pagination){
		
		String url  = UriComponentsBuilder.fromHttpUrl(WS_URL + "/find-all-best-bidding-auctions")
						.queryParam("page",pagination.getPage())
						.queryParam("limit", pagination.getLimit())
						.queryParam("productName", filter.getProductName())
						.toUriString();
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(url, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Map<String , Object>> addAuction(@RequestBody AddAuction addAuction){
		System.out.println(addAuction);
		HttpEntity<Object> request = new HttpEntity<Object>(addAuction,header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/add-auction", HttpMethod.POST , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}

	@RequestMapping(method = RequestMethod.PUT)
	public ResponseEntity<Map<String , Object>> updateAuction(@RequestBody AddAuction updateAuction){
		HttpEntity<Object> request = new HttpEntity<Object>(updateAuction, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/update-auction", HttpMethod.PUT , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(value="/{auction_id}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String , Object>> deleteAuction(@PathVariable int auction_id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/delete-auction/" + auction_id, HttpMethod.DELETE , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	//=== bidding auction
	@RequestMapping(value="/bid/{auction_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findBiddingAuctionByAuctionId(@PathVariable int auction_id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-bidding-auction-by-auction-id/" + auction_id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	//TODO: FIND ALL AUCTION STATUS 1 ACTIVE
	@RequestMapping(value="/all-auction-active", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAllAuctionsActive(AuctionFilter filter, Pagination pagination){
		
		String url  = UriComponentsBuilder.fromHttpUrl(WS_URL + "/find-all-auctions-active")
						.queryParam("page",pagination.getPage())
						.queryParam("limit", pagination.getLimit())
						.queryParam("productName", filter.getProductName())
						.toUriString();
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(url, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	
	

}
