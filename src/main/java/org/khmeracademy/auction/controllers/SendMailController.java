package org.khmeracademy.auction.controllers;

import java.util.Map;

import org.khmeracademy.auction.entities.input.SendMail;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;


@RestController
@RequestMapping("/rest/mail")
public class SendMailController {

	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	// add supplier
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Map<String , Object>> sendMail(@RequestBody SendMail sendMail){
		HttpEntity<Object> request = new HttpEntity<Object>(sendMail,header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/send-mail", HttpMethod.POST , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
}
