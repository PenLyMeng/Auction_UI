package org.khmeracademy.auction.controllers;

import java.util.Map;

import org.khmeracademy.auction.filtering.InvoiceFilter;
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
@RequestMapping("/rest/invoice")
public class InvoiceController {
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	//TODO: GET ALL USER CREDIT WITH ENDING AMOUNT 
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>>findAllInvoiceDetails(){

		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange( WS_URL + "/find-all-invoice-details" , HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	
	//TODO: GET FIND INVOICE DETAIL BY INVOICE_ID
	@RequestMapping(value="/{invoice_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findInvoiceDetailByInvoiceId(@PathVariable int invoice_id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-invoice-detail-by-invoice-id/" + invoice_id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
}
