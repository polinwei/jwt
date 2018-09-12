package com.spring.jwt.controller.authentication;

import java.net.URI;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.spring.jwt.db.maria.dao.authentication.AuthorityRepository;
import com.spring.jwt.db.maria.model.authentication.Authority;

@RestController
@RequestMapping(path = "/authentication")
public class AuthorityRestController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private AuthorityRepository authorityRepository;
	
	@GetMapping(path = "authorities")
	public List<Authority> retrieveAllAuthorities(){
		return authorityRepository.findAll();
	}
	
	@GetMapping("authority/{id}")
	public Authority retreveAuthority(@PathVariable long id) {
		Optional<Authority> authority = authorityRepository.findById(id);
		return authority.get();
	}
	
	@PostMapping("authority")
	@PreAuthorize("hasRole('ADMIN')")
	public ResponseEntity<?> createAuthority(@RequestBody Authority authority){
		Authority newAuthority = authorityRepository.save(authority);
		
		URI location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
				.buildAndExpand(newAuthority.getId()).toUri();
		
		return ResponseEntity.created(location).build();
	}
	
}
