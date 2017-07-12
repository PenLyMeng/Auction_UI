package org.khmeracademy.auction.controllers;

import java.util.Map;

import org.khmeracademy.auction.entities.User;
import org.khmeracademy.auction.entities.input.AddCategory;
import org.khmeracademy.auction.entities.input.AddUser;
import org.khmeracademy.auction.entities.input.UserLogin;
import org.khmeracademy.auction.filtering.UserFilter;
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
@RequestMapping("/rest/user")
public class UserController {

	@Autowired
	private HttpHeaders header;

	@Autowired
	private RestTemplate rest;

	@Autowired
	private String WS_URL;

	// Get all Users
	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllUsers(UserFilter filter, Pagination pagination) {

		String url = UriComponentsBuilder.fromHttpUrl(WS_URL + "/get-all-users")
				.queryParam("page", pagination.getPage()).queryParam("limit", pagination.getLimit())
				.queryParam("userName", filter.getUserName()).toUriString();
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(url, HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	// Add User
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addUser(@RequestBody AddUser addUser) {
		HttpEntity<Object> request = new HttpEntity<Object>(addUser, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/add-user", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	// Update User
	@RequestMapping(method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateUser(@RequestBody AddUser updateUser) {

		// REQUEST = REQUEST BODY + HEADER
		HttpEntity<Object> request = new HttpEntity<Object>(updateUser, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/update-user", HttpMethod.PUT, request, Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	// Get User by ID
	@RequestMapping(value = "/{user_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getUserByID(@PathVariable int user_id) {
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/get-user-by-id/" + user_id, HttpMethod.GET, request,
				Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	// Get User By UserName
	@RequestMapping(value = "/user-name/{user_name}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getUserByName(@PathVariable String user_name) {
		UserLogin login = new UserLogin();
		login.setUser_name(user_name);
		HttpEntity<Object> request = new HttpEntity<Object>(login, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/get-user-by-name/" + user_name, HttpMethod.GET, request,
				Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	// Delete user by id
	@RequestMapping(value = "/{userId}", method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteUsers(@PathVariable int userId) {
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/delete-user/" + userId, HttpMethod.DELETE, request,
				Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	// Get user by verified code

	@RequestMapping(value = "/get-verified-code/{verified_code}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getUserByVerifiedCode(@PathVariable String verified_code) {
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/get-user-by-verified-code/" + verified_code,
				HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	// Update User
	@RequestMapping(value = "/update-user-confirm-email/{verified_code}", method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateUserConfirmEmail(@PathVariable String verified_code) {

		// REQUEST = REQUEST BODY + HEADER
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/update-user-confirm-email/" + verified_code,
				HttpMethod.PUT, request, Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	// Update User profile in userprofile.jsp
	@RequestMapping(value = "/update-user-profile", method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateUserProfile(@RequestBody AddUser updateUser) {

		// REQUEST = REQUEST BODY + HEADER
		HttpEntity<Object> request = new HttpEntity<Object>(updateUser, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/update-user-profile", HttpMethod.PUT, request,
				Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	// Update User password in userprofile.jsp
	@RequestMapping(value = "/update-user-password", method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateUserPassword(@RequestBody AddUser updateUser) {

		// REQUEST = REQUEST BODY + HEADER
		HttpEntity<Object> request = new HttpEntity<Object>(updateUser, header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/update-user-password", HttpMethod.PUT, request,
				Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}
	
	// Get User By UserName
	@RequestMapping(value = "/find-user-by-user-hash/{user_hash}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findUserByUserHash(@PathVariable String user_hash) {
//		UserLogin login = new UserLogin();
//		login.setUser_name(user_name);
		
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-user-by-user-hash/" + user_hash, HttpMethod.GET, request,
				Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}
}
