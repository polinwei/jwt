package com.spring.jwt.controller;


import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());	
	@Autowired
	HttpSession session;
			
	@RequestMapping(value = { "/","/home" })
    public String staticResource(Model model) {
		return "home";
    }
	
	@RequestMapping("/login")
    public String login(Model model){
		Authentication authentication = null;
		authentication = SecurityContextHolder.getContext().getAuthentication();
		
		if (!authentication.getPrincipal().equals("anonymousUser")) {
			return "home-auth";
		}
		return "login";		
    }
	
	@RequestMapping("/auth/home")
	public String authHome(Model model) {
		
		return "home-auth";
	}

}
