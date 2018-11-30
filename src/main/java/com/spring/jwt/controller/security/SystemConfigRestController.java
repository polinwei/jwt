package com.spring.jwt.controller.security;

import java.net.URI;
import java.util.Date;
import java.util.List;
import java.util.Map;
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

import com.spring.jwt.db.maria.dao.security.SystemConfigRepository;
import com.spring.jwt.db.maria.model.security.SystemConfig;
import com.spring.jwt.service.UserService;


@RestController
@RequestMapping(path = "/auth/security")
public class SystemConfigRestController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	SystemConfigRepository scRepository;
	@Autowired
	UserService userService;
	
	/**
	 * 查詢所有資料
	 * @return List<UserProfile>
	 */
	@GetMapping("systemConfigs")
	public List<SystemConfig> getAllDatas(){	
		return scRepository.findAll();
	}
	
	/**
	 * 取得某一筆資料
	 * @param id
	 * @return
	 */
	@GetMapping("systemConfig/{id}")
	public ResponseEntity<?> getData(@PathVariable Long id){
		Optional<SystemConfig> systemConfig = scRepository.findById(id);
		if (systemConfig.isPresent()) {
			return new ResponseEntity<SystemConfig>(systemConfig.get(), HttpStatus.OK);
		} else {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
	}
	
	/**
	 * 新增
	 * @param userProfile  可以用 @RequestBody Map<String,Object> params 取得所有 Form 裡的輸入值
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("systemConfig")	
	public ResponseEntity<?> addData(@RequestBody @Valid SystemConfig systemConfig, BindingResult bindingResult){
		
		SystemConfig newEntity = new SystemConfig();
		URI location = null;
		
		if ( bindingResult.hasErrors()) {
			return new ResponseEntity(bindingResult.getFieldErrors(),HttpStatus.METHOD_NOT_ALLOWED);
		}
		
		try {
			systemConfig.setCreateDate(new Date());
			systemConfig.setCreateUser(userService.getCurrentUser().getId());
			newEntity = scRepository.save(systemConfig);
			location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(newEntity.getId()).toUri();
			
		} catch (DataIntegrityViolationException e) {			
			return new ResponseEntity(bindingResult.getFieldErrors(),HttpStatus.CONFLICT);
		} catch (Exception e) {
			return new ResponseEntity(bindingResult.getAllErrors(), HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity(ResponseEntity.created(location).build(),HttpStatus.CREATED);
	}
		
	/**
	 * 更新
	 * @param systemConfig
	 * @param id
	 * @param bindingResult
	 * @return
	 */
	@PutMapping("systemConfig/{id}")
	public ResponseEntity<?> updateData(@RequestBody @Valid SystemConfig systemConfig , @PathVariable long id, BindingResult bindingResult){
		
		Optional <SystemConfig> currentEntity = scRepository.findById(id);
		if (currentEntity.isPresent()) {
			try {
				systemConfig.setUpdateDate(new Date());
				systemConfig.setUpdateUser(userService.getCurrentJwtUser().getId());
				scRepository.save(systemConfig);
				return new ResponseEntity(HttpStatus.OK);
			} catch (DataIntegrityViolationException e) {			
				return new ResponseEntity(bindingResult.getFieldErrors(),HttpStatus.CONFLICT);
			} catch (Exception e) {
				return new ResponseEntity(bindingResult.getAllErrors(), HttpStatus.BAD_REQUEST);
			}
		} else {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
	}
	
	/**
	 * 刪除
	 * @param id
	 */
	@DeleteMapping("systemConfig/{id}")
	public void delData(@PathVariable Long id){
		scRepository.deleteById(id);
	}
}
