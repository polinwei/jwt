package com.spring.jwt.controller.authentication;

import java.net.URI;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	
	/**
	 * 查詢所有資料
	 * @return
	 */
	@GetMapping(path = "authorities")
	public List<Authority> retrieveAllAuthorities(){
		return authorityRepository.findAll();
	}
	
	/**
	 * 取得某一筆資料
	 * @param id
	 * @return
	 */
	@GetMapping("authority/{id}")
	public Authority retreveAuthority(@PathVariable long id) {
		Optional<Authority> authority = authorityRepository.findById(id);
		return authority.get();
	}
	
	@PutMapping("/authority/{id}")
	public ResponseEntity<?> updateAuthority(@RequestBody @Valid Authority authority, @PathVariable long id, BindingResult bindingResult){
		Optional<Authority> editAuthority = authorityRepository.findById(id);
		
		if (!editAuthority.isPresent()) {
			return new ResponseEntity( ResponseEntity.notFound().build(), HttpStatus.NOT_MODIFIED);
		}
		authority.setId(id);
		authorityRepository.save(authority);
		return new ResponseEntity( ResponseEntity.noContent().build(), HttpStatus.ACCEPTED);
		
	}
	
	/**
	 * 共有 ADMIN 的角色可以新增
	 * @param authority
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("authority")
	@PreAuthorize("hasRole('ADMIN')")
	public ResponseEntity<?> createAuthority(@RequestBody @Valid Authority authority, BindingResult bindingResult){
		Authority newAuthority = new Authority();
		URI location = null;
		if (bindingResult.hasErrors()) {
			return new ResponseEntity(bindingResult.getFieldErrors(),HttpStatus.METHOD_NOT_ALLOWED);
		}
		
		
		try {
			newAuthority = authorityRepository.save(authority);
			location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
					.buildAndExpand(newAuthority.getId()).toUri();
		} catch (DataIntegrityViolationException e) {
			// TODO Auto-generated catch block
			return new ResponseEntity(bindingResult.getFieldErrors(),HttpStatus.METHOD_NOT_ALLOWED);
		}

		//return new ResponseEntity<Authority>(authority, HttpStatus.OK);
		return new ResponseEntity(ResponseEntity.created(location).build(),HttpStatus.CREATED);
	}
	
}
