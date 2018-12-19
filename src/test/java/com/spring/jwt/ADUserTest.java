package com.spring.jwt;


import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.spring.jwt.model.ADUser;
import com.spring.jwt.service.ADService;



@RunWith(SpringRunner.class)
@SpringBootTest
public class ADUserTest {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	ADService adService;
	
	@Test
    public void testGetAllPersons() {
		List<String> Objects = adService.getAllObjectNames();
        for (String string : Objects) {
			//System.out.print(string);
		}
    }
	
	@Test
    public void findByUsernameTest() {
        try {
        	ADUser adUser = adService.findByUsername("username", "password");
            logger.info("adUser: " + adUser.toString());
            List<ADUser> adUsers = adService.findByAttribute("username", "password", "physicalDeliveryOfficeName", "IPPBX");
            for (ADUser user : adUsers) {
				logger.info("User:"+user.getName() + " extNum:"+user.getIpPhone());
			}
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	
}
