package com.spring.jwt;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.web.servlet.request.SecurityMockMvcRequestPostProcessors.UserRequestPostProcessor;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import com.spring.jwt.authentication.security.JwtUser;
import com.spring.jwt.authentication.security.JwtUserFactory;
import com.spring.jwt.db.maria.dao.authentication.UserRepository;
import com.spring.jwt.db.maria.dao.demo.BankAccountDao;
import com.spring.jwt.db.maria.model.authentication.User;
import com.spring.jwt.db.maria.model.demo.BankAccount;
import com.spring.jwt.db.maria.service.demo.BankAccountService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class JwtApplicationTests {
	
	private final static Logger logger = LoggerFactory.getLogger(JwtApplicationTests.class);

	@Autowired
	private BankAccountService bankAccountService;
	@Autowired
	private BankAccountDao bankAccountDao;
	@Autowired
	private UserRepository userRepository;
	
	@Test
	public void contextLoads() {
	}
	
	
	/**
	 * Delete all myspring.bank_account
	 * @throws Exception
	 */
	@Before
	public void setUp() throws Exception {
		//bankAccountDao.deleteAll();
	}
	
	/**
	 * step 1: insert three records into myspring.bank_account
	 * step 2: verify whether has three records in table: bank_account
	 */
	@Test
	public void testInsertToBankAccount() {
		BankAccount bk = new BankAccount(1L, "Tom", 1000);
		bankAccountDao.save(bk);
		bk = new BankAccount(2L, "Jerry", 2000);
		bankAccountDao.save(bk);
		bk = new BankAccount(3L, "Donald", 3000);
		bankAccountDao.save(bk);

		for (BankAccount bankAccount: bankAccountDao.findAll() ) {
			logger.info(bankAccount.toString());
		}

		Assert.assertEquals(3,bankAccountDao.count());
	}
	
	@Test
	@Transactional
	public void testUserAuthority() {
		User user = userRepository.findById(1L).get();
		JwtUser jwtUser = JwtUserFactory.create(user);
		logger.info(jwtUser.getUsername());
		
	}
	
	

}
