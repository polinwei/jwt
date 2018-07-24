package com.spring.jwt.rest;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;
import static org.springframework.security.test.web.servlet.setup.SecurityMockMvcConfigurers.springSecurity;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.spring.jwt.authentication.security.JwtTokenUtil;
import com.spring.jwt.authentication.security.JwtUser;
import com.spring.jwt.authentication.security.JwtUserFactory;
import com.spring.jwt.db.maria.dao.authentication.AuthorityRepository;
import com.spring.jwt.db.maria.model.authentication.Authority;
import com.spring.jwt.db.maria.model.authentication.User;
import com.spring.jwt.db.maria.model.authentication.UserAuthority;
import com.spring.jwt.db.maria.service.authentication.JwtUserDetailsService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class UserRestControllerTest {

    private MockMvc mvc;
    @Autowired
    private WebApplicationContext context;
    @MockBean
    private JwtTokenUtil jwtTokenUtil;
    @MockBean
    private JwtUserDetailsService jwtUserDetailsService;
    @Autowired
	private AuthorityRepository authorityRepository;
    
    @Before
    public void setup() {
        mvc = MockMvcBuilders
                .webAppContextSetup(context)
                .apply(springSecurity())
                .build();
    }
    
    @Test
    public void shouldGetUnauthorizedWithoutRole() throws Exception {
        mvc.perform(get("/user"))
                .andExpect(status().isUnauthorized());
    }
    
    @Test
    @WithMockUser(roles = "USER")
    public void getPersonsSuccessfullyWithUserRole() throws Exception {

    	Authority authority = authorityRepository.findById(1L).get();
    	Set<Authority> authorities = new HashSet<Authority>(0);
    	authorities.add(authority);

        User user = new User();
        user.setUsername("username");
        user.setAuthorities(authorities);
        user.setEnabled(Boolean.TRUE);
        user.setLastpasswordresetdate(new Date(System.currentTimeMillis() + 1000 * 1000));

        JwtUser jwtUser = JwtUserFactory.create(user);

        when(jwtTokenUtil.getUsernameFromToken(any())).thenReturn(user.getUsername());

        when(jwtUserDetailsService.loadUserByUsername(eq(user.getUsername()))).thenReturn(jwtUser);

        mvc.perform(get("/user").header("Authorization", "Bearer nsodunsodiuv"))
                .andExpect(status().is2xxSuccessful());
    }
    
}
