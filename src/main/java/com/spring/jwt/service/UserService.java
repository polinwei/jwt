package com.spring.jwt.service;

import java.util.Objects;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Service;

import com.spring.jwt.authentication.security.JwtUser;
import com.spring.jwt.db.maria.dao.authentication.UserRepository;
import com.spring.jwt.db.maria.model.authentication.User;

@Service
public class UserService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());	
	@Autowired
	HttpSession session;
	@Autowired
	UserRepository userRepository;
	
	private Authentication authentication;
	
	public JwtUser getCurrentJwtUser() {
		JwtUser jwtUser = null;
		SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
		if ( !Objects.isNull(sci) ) {
			authentication = sci.getAuthentication();
			return (JwtUser)authentication.getPrincipal();
		}
		return jwtUser;
	}
	
	public User getCurrentUser() {
		Optional<User> user = userRepository.findById(getCurrentJwtUser().getId());
		return user.get();
		
	}
	
	public User getUserById(Long id) {
		Optional<User> user = userRepository.findById(id);
		return user.get();
	}
}
