package com.spring.jwt.controller.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.jwt.db.maria.dao.authentication.AuthorityRepository;

@Controller
@RequestMapping(path = "/security")
public class AuthorityController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private AuthorityRepository authorityRepository;
	
	@RequestMapping("authority")
	public String crudAuthority(Model model) {
		model.addAttribute("programName", "Authority");
		
		return "/security/authority";
	}
	
}
