package com.spring.jwt;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import com.spring.jwt.authentication.security.JwtUser;
import com.spring.jwt.authentication.security.JwtUserFactory;
import com.spring.jwt.db.maria.dao.authentication.UserRepository;
import com.spring.jwt.db.maria.dao.hr.UserDetailsRepository;
import com.spring.jwt.db.maria.model.authentication.User;
import com.spring.jwt.service.UserService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;


@RunWith(SpringRunner.class)
@SpringBootTest
public class JwtUserTest {
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	

	@Autowired
    private UserRepository userRepository;
	@Autowired
	UserDetailsRepository userDetailsRepo;
	@Autowired
	UserService userService;
	
	
	@Test
	@Transactional
    public void testUserAuthority() {
        User user = userRepository.findById(1L).get();
        JwtUser jwtUser = JwtUserFactory.create(user);
        logger.info(jwtUser.getUsername());

    }
	
	@Test
	public void testQueryNative() {
		List<Map<String, Object>> userDetail = userDetailsRepo.findAllUsersByCompanyNativeQuery(100L);
		
		for (Map<String, Object> ud : userDetail) {
			System.out.println(ud.get("username").toString());
		}
	}
	
	@Test
	public void testQueryNativeInService() {
		List<Map<String, Object>> userDetail = userService.findAllUsersByCompanyNativeQuery(100L);
		for (Map<String, Object> ud : userDetail) {
			System.out.println(ud.get("username").toString());
		}
	}
	
}
