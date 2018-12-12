package com.spring.jwt.controller.security;

import java.net.URI;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.spring.jwt.db.maria.dao.security.AppCodesRepository;
import com.spring.jwt.db.maria.model.security.AppCodes;
import com.spring.jwt.service.UserService;

@RestController
@RequestMapping(path = "/auth/security")
public class AppCodesRestController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	AppCodesRepository acRepo;
	@Autowired
	UserService userService;
	
	/**
	 *  查詢所有資料
	 * @return
	 */
	@GetMapping("appCodes")
	public List<AppCodes> getAllDatas(){
		return acRepo.findAll();
	}
	
	/**
	 * 取得一筆資料
	 * @param id
	 * @return
	 */
	@GetMapping("appCode/{id}")
	public ResponseEntity<?> getData(@PathVariable Long id){
		Optional<AppCodes> appCodes = acRepo.findById(id);
		if (appCodes.isPresent()) {
			return new ResponseEntity<AppCodes>(appCodes.get(), HttpStatus.OK);
		} else {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
	}
	
	/**
	 * 新增
	 * @param appCodes
	 * @param br
	 * @return
	 */
	@PostMapping("appCode")
	public ResponseEntity<?> addData(@RequestBody @Valid AppCodes appCodes, BindingResult br){
		
		AppCodes newEntity = new AppCodes();
		URI location = null;
		
		if ( br.hasErrors()) {
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.METHOD_NOT_ALLOWED);
		}
		
		try {
			appCodes.setCreateUser(userService.getCurrentUser().getId());
			appCodes.setCreateDate(new Date());
			newEntity = acRepo.save(appCodes);
			location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(newEntity.getId()).toUri();
			
		} catch (DataIntegrityViolationException e) {			
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.CONFLICT);
		} catch (Exception e) {
			return new ResponseEntity(br.getAllErrors(), HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity(ResponseEntity.created(location).build(),HttpStatus.CREATED);
		
	}
	
	/**
	 * 更新
	 * @param appCodes
	 * @param id
	 * @param br
	 * @return
	 */
	@PutMapping("appCode/{id}")
	public ResponseEntity<?> updateData(@RequestBody @Valid AppCodes appCodes , @PathVariable long id, BindingResult br){
		Optional<AppCodes> currentEntity = acRepo.findById(id);
		if (currentEntity.isPresent()) {
			try {
				appCodes.setUpdateDate(new Date());
				appCodes.setUpdateUser(userService.getCurrentUser().getId());
				acRepo.save(appCodes);
				return new ResponseEntity(HttpStatus.OK);
			} catch (DataIntegrityViolationException e) {			
				return new ResponseEntity(br.getFieldErrors(),HttpStatus.CONFLICT);
			} catch (Exception e) {
				return new ResponseEntity(br.getAllErrors(), HttpStatus.BAD_REQUEST);
			}
		} else {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
	}
	
	@DeleteMapping("appCode/{id}")
	public void delData(@PathVariable Long id){
		acRepo.deleteById(id);
	}
}
