package org.khmeracademy.auction;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class GreetingController {

	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private RestTemplate rest;
	
	@Autowired
	private String WS_URL;

    @MessageMapping("/hello")
    @SendTo("/topic/greetings")
    public Greeting greeting(HelloMessage message) throws Exception {
        Thread.sleep(1000); // simulated delay
        
        
        
//        HttpEntity<Object> request = new HttpEntity<Object>(header);
//		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-auction-by-id/" + 1, HttpMethod.GET , request , Map.class) ;
		//return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
		
		//return new Greeting("Hello, " + message.getName() + response.getBody().toString() + "!");
        return new Greeting("Hello, " + message.getName()  + "!");
    }
    
    /*@RequestMapping(value="/{auction_id}", method = RequestMethod.GET)
	public ResponseEntity<Map<String , Object>> findAuctionByID(@PathVariable int auction_id){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = rest.exchange(WS_URL + "/find-auction-by-id/" + auction_id, HttpMethod.GET , request , Map.class) ;
		return new ResponseEntity<Map<String , Object>>(response.getBody() , HttpStatus.OK);
	}*/

}
