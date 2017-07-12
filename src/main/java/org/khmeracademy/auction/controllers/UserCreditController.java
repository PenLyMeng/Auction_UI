package org.khmeracademy.auction.controllers;

import java.util.Map;

import org.khmeracademy.auction.filtering.TopupFilter;
import org.khmeracademy.auction.utils.Pagination;
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
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/rest/user-credit")
public class UserCreditController {
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	//TODO: GET USER CREDIT BY USER ID
	@RequestMapping(value="/{user_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findUserCreditHistoryByUserId(@PathVariable int user_id){
		HttpEntity<Object> request = new HttpEntity<Object>(user_id, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/"+ user_id + "/find-user-credit-by-id/", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	//TODO: GET ALL USER CREDIT WITH ENDING AMOUNT 
		@RequestMapping(value="/user-ending-amount", method = RequestMethod.GET)
		public ResponseEntity<Map<String , Object>>findAllUserCreditWithEndingAmount(TopupFilter filter, Pagination pagination){
			String url  = UriComponentsBuilder.fromHttpUrl(WS_URL + "/find-all-active-user-credit-history-with-ending-amount")
					.queryParam("page",pagination.getPage())
					.queryParam("limit", pagination.getLimit())
					.queryParam("userName", filter.getFullName())
					.toUriString();
			HttpEntity<Object> request = new HttpEntity<Object>(header);
			ResponseEntity<Map> response = rest.exchange( url , HttpMethod.GET , request , Map.class) ;
			return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
		}
	
}
