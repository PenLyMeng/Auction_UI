package org.khmeracademy.auction.controllers;

import java.util.Map;

import org.khmeracademy.auction.entities.input.AddSupplier;
import org.khmeracademy.auction.filtering.SupplierFilter;
import org.khmeracademy.auction.utils.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@RestController
@RequestMapping("/rest/supplier")
public class SupplierController {
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	// get all suppliers
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAllSuppliers(SupplierFilter filter, Pagination pagination){
		
		String url  = UriComponentsBuilder.fromHttpUrl(WS_URL + "/find-all-suppliers")
				.queryParam("page",pagination.getPage())
				.queryParam("limit", pagination.getLimit())
				.queryParam("userName", filter.getSupplierName())
				.toUriString();
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(url, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	// get supplier by supplier_id
	@RequestMapping(value="/{supplier_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findSupplierById(@PathVariable int supplier_id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-supplier-by-id/"+supplier_id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	// add supplier
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Map<String , Object>> addSupplier(@RequestBody AddSupplier addSupplier){
		HttpEntity<Object> request = new HttpEntity<Object>(addSupplier,header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/add-supplier", HttpMethod.POST , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	// update supplier
	@RequestMapping(method = RequestMethod.PUT)
	public ResponseEntity<Map<String , Object>> updateSupplier(@RequestBody AddSupplier addSupplier){
		HttpEntity<Object> request = new HttpEntity<Object>(addSupplier,header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/update-supplier", HttpMethod.PUT , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	// delete supplier
	@RequestMapping(value="/{supplier_id}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String , Object>> deleteSupplier(@PathVariable int supplier_id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/delete-supplier/"+supplier_id, HttpMethod.DELETE , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(value="/supplier-in-product", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findSupplersInProducts(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-suppliers-in-products", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
}
