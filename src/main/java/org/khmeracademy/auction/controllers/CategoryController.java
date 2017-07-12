package org.khmeracademy.auction.controllers;

import java.util.Map;

import org.khmeracademy.auction.entities.input.AddCategory;
import org.khmeracademy.auction.filtering.CategoryFilter;
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
@RequestMapping("/rest/category")
public class CategoryController {
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAllCategories(CategoryFilter filter, Pagination pagination){
		String url  = UriComponentsBuilder.fromHttpUrl(WS_URL + "/find-all-categories")
				.queryParam("page",pagination.getPage())
				.queryParam("limit", pagination.getLimit())
				.queryParam("categoryName", filter.getCategoryName())
				.toUriString();
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange( url , HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(value="/find-main-category", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findMainCategories(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-main-category", HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Map<String , Object>> addCategory(@RequestBody AddCategory addCategory){
		
		// REQUEST = REQUEST BODY + HEADER
		HttpEntity<Object> request = new HttpEntity<Object>(addCategory,header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/add-category", HttpMethod.POST , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(method = RequestMethod.PUT)
	public ResponseEntity<Map<String , Object>> updateCategory(@RequestBody AddCategory updateCategory){
		
		// REQUEST = REQUEST BODY + HEADER
		HttpEntity<Object> request = new HttpEntity<Object>(updateCategory,header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/update-category", HttpMethod.PUT , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
	
	@RequestMapping(value="/{category_id}", method=RequestMethod.DELETE)
		public ResponseEntity<Map<String, Object>> deleteCategory(@PathVariable int category_id ){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/delete-category/"+category_id, HttpMethod.DELETE, request, Map.class, category_id);
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
		
	}
	// Get Category by ID
	@RequestMapping(value="/{category_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findCategoryByID( @PathVariable int category_id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-category-by-id/"+ category_id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}
}
