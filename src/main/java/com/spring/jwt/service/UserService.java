package com.spring.jwt.service;

import java.util.Objects;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Service;

import com.spring.jwt.authentication.security.JwtUser;

@Service
public class UserService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());	
	@Autowired
	HttpSession session;
	private Authentication authentication;
	
	public JwtUser getCurrentUser() {
		JwtUser jwtUser = null;
		SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
		if ( !Objects.isNull(sci) ) {
			authentication = sci.getAuthentication();
			return (JwtUser)authentication.getPrincipal();
		}
		return jwtUser;
	}
}
