package com.spring.jwt.authentication.security;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.assertj.core.util.Lists;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.jwt.db.maria.model.authentication.Authority;
import com.spring.jwt.db.maria.model.authentication.User;
import com.spring.jwt.db.maria.model.authentication.UserAuthority;
import com.spring.jwt.exception.CommonTransactionException;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

public final class JwtUserFactory {

    private JwtUserFactory() {
    }
   
    public static JwtUser create(User user) {
        return new JwtUser(
                user.getId(),
                user.getUsername(),
                user.getFirstname(),
                user.getLastname(),
                user.getEmail(),
                user.getPassword(),
                mapToGrantedAuthorities(user.getAuthorities()),
                user.getEnabled(),
                user.getLastpasswordresetdate()
        );
    }

    private static List<GrantedAuthority> mapToGrantedAuthorities(Set<Authority> authorities) {  	
        return authorities.stream()
                .map(Authority -> new SimpleGrantedAuthority(Authority.getName()))
                .collect(Collectors.toList());
    }
}
