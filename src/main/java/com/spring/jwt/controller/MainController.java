package com.spring.jwt.controller;


import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;

import com.spring.jwt.controller.authentication.AuthenticationRestController;

@Controller
public class MainController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());	
	@Autowired
	HttpSession session;
	@Autowired
	AuthenticationRestController authenticationRC;
	
	private Authentication authentication;
			
	@RequestMapping(value = { "/","/home" })
    public String staticResource(Model model,HttpServletRequest request) {		
		SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
		if ( !Objects.isNull(sci) ) {
			authentication = sci.getAuthentication();
			model.addAttribute("isAuthenticated", authentication.isAuthenticated());
			model.addAttribute("principal", authentication.getPrincipal());
		}

		return "home";
    }
	
	@RequestMapping("/login")
    public String login(Model model){
		authentication=null;
		authentication = SecurityContextHolder.getContext().getAuthentication();
		
		if (!authentication.getPrincipal().equals("anonymousUser")) {
			return "home-auth";
		}
		return "login";		
    }
	
	@RequestMapping("/auth/home")
	public String authHome(Model model) {
		authentication = SecurityContextHolder.getContext().getAuthentication();
		return "home-auth";
	}

}
