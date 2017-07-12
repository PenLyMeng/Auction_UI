package org.khmeracademy.auction.controllers;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import org.khmeracademy.auction.entities.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@RestController
@RequestMapping("rest/uploading")
public class UploadImgController {

	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL ;
	
//	String path = "file:/opt/images/e861adea-fd7a-4bfc-87d5-e6d2550d4901.jpg";
	
	
//	@RequestMapping(method = RequestMethod.GET, value = "/getVideoIcon")
//	@ResponseBody
//	public FileSystemResource getVideoIcon(HttpServletRequest request) throws IOException {
//	    String path = request.getSession().getServletContext().getRealPath("file:/opt/images")+"/e861adea-fd7a-4bfc-87d5-e6d2550d4901.jpg";
//	    return new FileSystemResource(new File(path));
//	}
	
	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> addImage(@RequestParam("image") CommonsMultipartFile file){
		System.out.println("Hello");
		HttpEntity<Object> request= new HttpEntity<Object>(file,header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/api/v1/uploading", HttpMethod.POST , request , Map.class) ;
	return new ResponseEntity<Map<String,Object>>(response.getBody(), HttpStatus.OK);
	}
	
}
