package org.khmeracademy.auction.controllers;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class LoginController {
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String loginPage(HttpServletRequest request){
		
		System.out.println("REFERER==>"+ request.getHeader("referer"));
		
		//TODO: TO GET THE REFERER AND PUT IT IN THE SESSIOn
		request.getSession().setAttribute("REDIRECT_URL", request.getHeader("referer"));
		return "/login";
	}

}
