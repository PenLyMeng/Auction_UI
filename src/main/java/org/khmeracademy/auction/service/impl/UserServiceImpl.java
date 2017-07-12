package org.khmeracademy.auction.service.impl;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.khmeracademy.auction.entities.Role;
import org.khmeracademy.auction.entities.User;
import org.khmeracademy.auction.entities.input.AddUser;
import org.khmeracademy.auction.entities.input.UserLogin;
import org.khmeracademy.auction.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
@PropertySource(
		value={"classpath:configuration.properties"}
)
public class UserServiceImpl implements UserService{
	
	@Autowired
	Environment environment;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;
	
	
	
	@Override
	public User getUserByName(String user_name) {
		
		UserLogin login = new UserLogin();
		login.setUser_name(user_name);
		
		HttpEntity<Object> request = new HttpEntity<Object>(login,header);
		ResponseEntity<Map> response = rest.exchange(WS_URL+"/get-user-by-name/" + user_name, HttpMethod.GET , request , Map.class) ;
		
		
		
		Map<String, Object> map = (HashMap<String, Object>)response.getBody();
		System.out.println(map);
		if(map.get("DATA") != null){
			
			Map<String , Object> data = (HashMap<String , Object>) map.get("DATA");
			User u = new User();
			u.setUser_id((Integer)data.get("user_id"));
			u.setEmail((String)data.get("email"));
			u.setUser_name((String)data.get("user_name"));
			u.setPassword((String) data.get("password"));
			
			
			List<Role> roles = new ArrayList<Role>();
			
			List<HashMap<String, Object>> dataRole = (List<HashMap<String, Object>>) data.get("roles");
			for (Map<String , Object> datas  : dataRole) {
				Role role = new Role();
				role.setRole_id((Integer)datas.get("role_id"));
				role.setRole_name((String) datas.get("role_name"));
				roles.add(role);
				
				System.out.println(role.getRole_id() + role.getRole_name());
				
			}
			System.out.println(dataRole);
			u.setRoles(roles);
			
			System.out.println(map);
			
			return u;
		}
		
		return null;
	}



	//TODO : Get User Object by user hash
	@Override
	public User findUserByUserHash(String userHash) {
		try{
			HttpEntity<Object> request = new HttpEntity<Object>(header);
			ResponseEntity<Map> response = rest.exchange("http://localhost:9999/api/find-user-by-user-hash/"+userHash, HttpMethod.GET , request , Map.class);
			//"http://localhost:9999/api/find-user-by-user-hash/"
			//System.out.println(WS_URL + "/rest/user/find-user-by-user-hash/"+userHash);
//			
			//System.out.println(response.getBody());
			
			Map<String, Object> map = (HashMap<String, Object>)response.getBody();
			if(map.get("DATA") != null){
				
				//System.out.println("USERT ======== >" + map.get("DATA"));
				
				Map<String , Object> data =  (Map<String, Object>) map.get("DATA");
				List<Role> roles = new ArrayList<>();
				User u = new User();
				u.setUser_id((Integer) data.get("user_id"));
				u.setUser_name((String)data.get("user_name"));
				u.setPassword((String) data.get("password"));
				//u.setDescription((String) data.get("DESCRIPTION"));
				//u.setUser_image((String) data.get("USER_IMAGE"));
				Role role = new Role();
				//System.out.println("====UUU: "+(String)data.get("email"));
				if(data.get("email").equals("chomrern@gmail.com")){
					
					role.setRole_id(1);
					role.setRole_name("ROLE_ADMIN");
				}else{
					role.setRole_id(2);
					role.setRole_name("ROLE_BIDDER");
				}
				
				//role.setRole_name((String)data.get("roles.role_name"));
				roles.add(role);
					
				u.setRoles(roles);
				return u;
			}
		}catch(Exception e){
			//e.printStackTrace();
		}
		return null;
	}



	//TODO : Register user 
	@Override
	public boolean registerUser(String userHash) {
		
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		String credentials = environment.getProperty("ACCOUNT.API.SECRET.HEADER");
		headers.set("Authorization", "Basic " + credentials);
		
		//TODO : Get user object by user hash from login.knongdai.com/knongdai/user/user-hash/{user-hash}
		HttpEntity<Object> request = new HttpEntity<Object>(headers);
		ResponseEntity<Map> response = rest.exchange(environment.getProperty("ACCOUNT.API.URL") + "/knongdai/user/user-hash/"+userHash, HttpMethod.POST , request , Map.class);
		Map<String, Object> map = (HashMap<String, Object>)response.getBody();
		System.out.println("=====> "  + map.get("DATA"));
		Map<String, Object> userMap = (Map<String, Object>) map.get("DATA");
		
		if(userMap != null){
			//TODO : If user object exists in KhmerAacademy Database, but user doesn't exist in Auction Database, so save user object in Auction Database
			AddUser user = new AddUser();
			user.setUser_name((String)userMap.get("USERNAME"));
			user.setPassword((String)userMap.get("PASSWORD"));
			user.setEmail((String)userMap.get("EMAIL"));
			user.setGender((String)userMap.get("GENDER"));
			
			user.setPhoto((String)userMap.get("USER_IAMGE_URL"));
			
			
			user.setUser_hash((String)userMap.get("USER_HASH"));
			user.setStatus((String)userMap.get("STATUS"));
			user.setVerified_code((String)userMap.get("VERIFICATION_CODE"));
			//user.setRoles("ROLE_USER");
			
			System.out.println("//TODO : If user exists in KhmerAacademy Database, but user doesn't exists in Auction Database, so save user in Auction Database");
			
			//TODO : Save user from KhmerAcademy into TinhEy Database 
			HttpEntity<Object> savedRequest = new HttpEntity<Object>(user,header);
			ResponseEntity<Map> savedResponse = rest.exchange(WS_URL + "/add-user", HttpMethod.POST , savedRequest , Map.class);
			Map<String, Object> savedMap = (HashMap<String, Object>)savedResponse.getBody();
			System.out.println("savedMap ====== > " + savedMap);
			return true;
		}else{
			System.out.println("//TODO : If user doesn't exists in KhmerAacademy.");
			return false;
			
		}	
	}

}
