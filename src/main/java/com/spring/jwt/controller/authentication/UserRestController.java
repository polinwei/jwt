package com.spring.jwt.controller.authentication;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.spring.jwt.authentication.security.JwtTokenUtil;
import com.spring.jwt.authentication.security.JwtUser;
import com.spring.jwt.db.maria.dao.authentication.UserRepository;
import com.spring.jwt.db.maria.model.authentication.User;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping(path = "/auth/security")
public class UserRestController {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Value("${jwt.header}")
    private String tokenHeader;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    UserRepository userRepository;

    @Autowired
    @Qualifier("jwtUserDetailsService")
    private UserDetailsService userDetailsService;

    @RequestMapping(value = "userToken", method = RequestMethod.GET)
    public JwtUser getAuthenticatedUser(HttpServletRequest request) {
    	if (request.getHeader(tokenHeader)!=null) {
    		String token = request.getHeader(tokenHeader).substring(7);
            String username = jwtTokenUtil.getUsernameFromToken(token);
            JwtUser user = (JwtUser) userDetailsService.loadUserByUsername(username);
            return user;
    	} else {
    		return null;
    	}
        
    }
    
    @GetMapping("/users")
    public List<User> getAllData(){
    	return userRepository.findAll();
    }
}
