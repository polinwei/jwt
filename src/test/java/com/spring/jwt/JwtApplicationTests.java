package com.spring.jwt;

import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import com.spring.jwt.authentication.security.JwtUser;
import com.spring.jwt.authentication.security.JwtUserFactory;
import com.spring.jwt.db.maria.dao.authentication.AuthorityRepository;
import com.spring.jwt.db.maria.dao.authentication.UserAuthorityRepository;
import com.spring.jwt.db.maria.dao.authentication.UserRepository;
import com.spring.jwt.db.maria.dao.demo.BankAccountDao;
import com.spring.jwt.db.maria.model.authentication.Authority;
import com.spring.jwt.db.maria.model.authentication.User;
import com.spring.jwt.db.maria.model.authentication.UserAuthority;
import com.spring.jwt.db.maria.model.authentication.UserAuthorityId;
import com.spring.jwt.db.maria.model.demo.BankAccount;
import com.spring.jwt.db.maria.service.demo.BankAccountService;


@RunWith(SpringRunner.class)
@SpringBootTest
@Rollback(value=false) //在測試環境, 資料庫的測試, 預設為自動 Rollback , 若要能塞入資料庫, 則需設為 false 
public class JwtApplicationTests {
	
	private final static Logger logger = LoggerFactory.getLogger(JwtApplicationTests.class);

	@Autowired
	private BankAccountService bankAccountService;
	@Autowired
	private BankAccountDao bankAccountDao;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private AuthorityRepository authorityRepository;
	@Autowired
	private UserAuthorityRepository userAuthorityRepository;
	
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
	
	@Test
	@Transactional	
	public void testTransactional() {
		
		try {
			UserAuthority userAuthority = new UserAuthority();
			UserAuthorityId userAuthorityId = new UserAuthorityId();
			Authority authority = authorityRepository.findById(1L).get();
			
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();			
			User user = new User("polin", encoder.encode("password"), "admin", "admin", "admin@admin.com", new Date());
			user.setEnabled(true);
			// 要先存檔, 不然 userAuthority 找不到新建的 userid 時則會 rollback
			userRepository.save(user);
			
			userAuthority.setUser(user);
			userAuthority.setAuthority(authority);
			
			userAuthorityId.setAuthorityId(1L);
			userAuthorityId.setUserId(user.getId());
			userAuthority.setId(userAuthorityId);
			Set<UserAuthority> userAuthorities =new HashSet<UserAuthority>(0);
			userAuthorityRepository.save(userAuthority);
						
		} catch (RuntimeException e) {
			// TODO Auto-generated catch block
			logger.error(e.getMessage());
		}
		
	}
	

}
