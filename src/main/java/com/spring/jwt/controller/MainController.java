package com.spring.jwt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping(value = { "/","/home" })
    public String staticResource(Model model) {

		return "home";
    }
	
	
	@RequestMapping("/auth/home")
	public String authHome(Model model) {
		
		return "home-auth";
	}

}
