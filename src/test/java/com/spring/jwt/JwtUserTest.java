package com.spring.jwt;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import com.spring.jwt.authentication.security.JwtUser;
import com.spring.jwt.authentication.security.JwtUserFactory;
import com.spring.jwt.db.maria.dao.authentication.UserRepository;
import com.spring.jwt.db.maria.model.authentication.User;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;


@RunWith(SpringRunner.class)
@SpringBootTest
public class JwtUserTest {
	private final static Logger logger = LoggerFactory.getLogger(JwtUserTest.class);
	

	@Autowired
    private UserRepository userRepository;
	
	@Test
	@Transactional
    public void testUserAuthority() {
        User user = userRepository.findById(1L).get();
        JwtUser jwtUser = JwtUserFactory.create(user);
        logger.info(jwtUser.getUsername());

    }
}
