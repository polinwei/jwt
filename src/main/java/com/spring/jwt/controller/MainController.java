package com.spring.jwt.controller;


import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());	
	
	@RequestMapping(value = { "/","/home" })
    public String staticResource(Model model) {
		return "home";
    }
	
	@RequestMapping("/login")
    public ModelAndView login(Model model,@RequestParam Optional<String> error){
		
		logger.debug("Getting login page, error={}", error);
		return new ModelAndView("login", "error", error);
    }
	
	@RequestMapping("/auth/home")
	public String authHome(Model model) {
		
		return "home-auth";
	}

}
