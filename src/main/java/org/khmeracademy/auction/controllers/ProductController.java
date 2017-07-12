package org.khmeracademy.auction.controllers;

import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.khmeracademy.auction.entities.input.AddProduct;
import org.khmeracademy.auction.utils.FileMessageResource;
import org.khmeracademy.auction.utils.HrdGeneratorUI;
import org.khmeracademy.auction.utils.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import ch.qos.logback.core.net.SyslogOutputStream;

@RestController
@RequestMapping("/rest/product")
public class ProductController {

	@Autowired
	private HttpHeaders header;

	@Autowired
	private RestTemplate rest;

	@Autowired
	private String WS_URL;

	@RequestMapping(method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllProducts(@ModelAttribute Pagination pagination) {
		// System.out.println("Hello");
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-all-products?limit="+ pagination.getLimit()+"&page="+pagination.getPage(), HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}

	@RequestMapping(method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addProduct(AddProduct addproduct, HttpServletRequest request) {
		System.out.println("UI => " + addproduct);
		
		
		// Header must not be JSON Content Type
		HttpHeaders header = new HttpHeaders();
		RestTemplate restTemplate = new RestTemplate();
		// Build Form Data
		MultiValueMap<String, Object> formData = null;
		try {
			formData = HrdGeneratorUI.createFormData(addproduct);

		} catch (Exception e) {
			e.printStackTrace();
		}

		final HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<MultiValueMap<String, Object>>(
				formData, header);

		ResponseEntity<Map> response = null;

		try {
			response = restTemplate.exchange(WS_URL + "/add-product", HttpMethod.POST, requestEntity,
					new ParameterizedTypeReference<Map>() {
					});
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);

	}
	
	
//	@RequestMapping(method = RequestMethod.PUT)
//	public ResponseEntity<Map<String , Object>> updateBrand(@RequestBody AddBrand updateBrand){
//		HttpEntity<Object> request = new HttpEntity<Object>(updateBrand,header);
//		ResponseEntity<Map> response = rest.exchange(WS_URL + "/update-brand", HttpMethod.PUT , request , Map.class) ;
//		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
//	}

	// -----------------update controller
		//	@RequestMapping(method = RequestMethod.PUT)
		//	public ResponseEntity<Map<String, Object>> updateProduct(@RequestBody AddProduct updateproduct) {
		//	 System.out.println("Hello >>>>>>>>>>>>>>>>>>>>>>>>>>>> put"+ updateproduct);
		//		
		//		HttpEntity<Object> request = new HttpEntity<Object>(updateproduct,header);
		//		ResponseEntity<Map> response = rest.exchange(WS_URL + "/update-product",
		//				HttpMethod.PUT, request, Map.class);
		//		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
		//	
	
		//	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/updateproduct", method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> updateProduct(
				@RequestParam("json_string") String jsonString, 
				@RequestParam("imageAdd") List<MultipartFile> galleryFiles,
				@RequestParam("imageDelete") List<Integer> deletedImageId,
				HttpServletRequest servletRequest) {
			
			System.out.println("Gallery" + galleryFiles.size());
			System.out.println("Deleted" + deletedImageId.size());
			
			// Header must not be JSON Content Type
			HttpHeaders header = new HttpHeaders();
			RestTemplate restTemplate = new RestTemplate();
			// Build Form Data
			MultiValueMap<String, Object> formData = new LinkedMultiValueMap<>();
			
			try {
				if (!galleryFiles.isEmpty()){
					for (MultipartFile file : galleryFiles) {
						formData.add("imageAdd", new FileMessageResource(file.getBytes(), file.getOriginalFilename()));					
					}
				}
				
				if (!deletedImageId.isEmpty()){
					for (Integer i : deletedImageId){
						formData.add("imageDelete", i);						
					}
				}else{
					formData.add("imageDelete", 0);
				}
				
				formData.add("json_string", URLEncoder.encode(jsonString, "UTF-8"));
			} catch (Exception e) {
				e.printStackTrace();
			}

			final HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<MultiValueMap<String, Object>>(
					formData, header);

			ResponseEntity<Map> response = null;

			try {
				response = restTemplate.exchange(WS_URL + "/update-product", HttpMethod.POST, requestEntity,
						new ParameterizedTypeReference<Map>() {
						});
			} catch (Exception e) {
				e.printStackTrace();
			}

			return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
		//return null;
		
		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping(value = "/product-of-supplier/{supplier_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findProductsHasSupplier(@PathVariable int supplier_id) {
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-products-has-supplier/" + supplier_id,
				HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
	}
	
	//Delete product by id	
		@RequestMapping(value="/delete-product/{product_id}", method = RequestMethod.DELETE)
		public ResponseEntity<Map<String , Object>> deleteUsers(@PathVariable("product_id") int productId){
			System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Deleted");
			HttpEntity<Object> request = new HttpEntity<Object>(header);
			ResponseEntity<Map> response = rest.exchange(WS_URL + "/delete-product/" + productId, HttpMethod.DELETE , request , Map.class) ;
			return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
		}
		
		
		@RequestMapping(value = "/product-of-supplier-for-update/{supplier_id}", method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> findProductsHasSupplierForUpdate(@PathVariable int supplier_id) {
			HttpEntity<Object> request = new HttpEntity<Object>(header);
			ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-products-has-supplier-for-update/" + supplier_id,
					HttpMethod.GET, request, Map.class);
			return new ResponseEntity<Map<String, Object>>(response.getBody(), HttpStatus.OK);
		}

}
