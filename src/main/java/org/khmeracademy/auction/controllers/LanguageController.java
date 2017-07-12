package org.khmeracademy.auction.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class LanguageController {

	@RequestMapping(value = "/language", method = RequestMethod.GET)
	public String rateHandler(@RequestParam("language") String language, HttpServletRequest request) {
	    //your controller code
	    String referer = request.getHeader("Referer");
	    return "redirect:"+ referer;
	}
}
