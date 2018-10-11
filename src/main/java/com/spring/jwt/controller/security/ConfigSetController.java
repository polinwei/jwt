package com.spring.jwt.controller.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.jwt.db.maria.model.security.UserProfile;
import com.spring.jwt.service.UserService;

@Controller
@RequestMapping(path = "/auth/security")
public class ConfigSetController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired 
	UserService userService;
	
	@RequestMapping("configSet")
	public String crudConfigSet(Model model) {
		
		model.addAttribute("userProfile", new UserProfile());
		
		return "/security/configSet";
	}
}
