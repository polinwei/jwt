package com.spring.jwt.controller.security;

import java.util.Locale;
import java.util.Objects;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.jwt.authentication.security.JwtUser;
import com.spring.jwt.db.maria.dao.authentication.AuthorityRepository;
import com.spring.jwt.db.maria.model.authentication.Authority;
import com.spring.jwt.service.UserService;

@Controller
@RequestMapping(path = "/auth/security")
public class AuthorityController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
    private MessageSource messageSource;

	@Autowired
	private AuthorityRepository authorityRepository;
	@Autowired 
	UserService userService;
	
	@RequestMapping("authority")
	public String crudAuthority(Model model) {
		
		model.addAttribute("authority", new Authority());
		model.addAttribute("authorityList",authorityRepository.findAll());		
		return "/auth/security/authority";
	}
	
	/**
	 * Get Authority Role from id
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value= {"authorityEdit","authorityEdit/{id}"} , method = RequestMethod.GET)
	public String crudAuthority(Model model, @PathVariable( required = false , name="id") Long id) {
		
		if (Objects.isNull(id)) {
			model.addAttribute("authority", new Authority());
		} else {
			model.addAttribute("authority", authorityRepository.findById(id).get());
		}		
		return "/auth/security/authority";
	}
	
	/**
	 * Save Authority Role
	 * @param model
	 * @param authority
	 * @return
	 */
	@RequestMapping(value="authorityEdit" , method = RequestMethod.POST)
	public String crudAuthority(Model model, @Valid Authority authority, BindingResult bindingResult) {
		
		if (bindingResult.hasErrors()) {
			return "/auth/security/authority";
		}
		
		try {
			authorityRepository.save(authority);
			model.addAttribute("authority", new Authority());
		} catch ( DataIntegrityViolationException e) {
			// e.printStackTrace();
			bindingResult.rejectValue("name", "validation.db.duplicate");
			return "/auth/security/authority";
		}
		
		
		return "/auth/security/authority";
	}
	
	/**
	 * Delete Authority Role
	 * @param model
	 * @param id
	 * @return
	 */
	@RequestMapping(value="authorityDelete/{id}" , method = RequestMethod.GET)
	public String authorityDelete(Model model, @PathVariable( required = true, name = "id") Long id) {
		
		authorityRepository.deleteById(id);
		model.addAttribute("authority", new Authority());
		return "/auth/security/authority";
	}
	
}
