package org.khmeracademy.auction.controllers;

import java.util.Map;

import javax.jws.soap.SOAPBinding.Use;

import org.khmeracademy.auction.entities.User;
import org.khmeracademy.auction.entities.input.AddTopUp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/rest/top-up")
public class TopUpController {
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	@RequestMapping(method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addTopUp(@RequestBody AddTopUp addTopUp, @AuthenticationPrincipal User user){
		
		System.out.println(user.getUser_id());
		addTopUp.setUser_id(user.getUser_id());
		HttpEntity<AddTopUp> requst = new HttpEntity<AddTopUp>(addTopUp, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/add-top-up", HttpMethod.POST, requst, Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@RequestMapping(value="/add-top-up", method=RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addTopUpAdmin(@RequestBody AddTopUp addTopUp){
		HttpEntity<AddTopUp> requst = new HttpEntity<AddTopUp>(addTopUp, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/add-top-up", HttpMethod.POST, requst, Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), response.getStatusCode());
	}
}















