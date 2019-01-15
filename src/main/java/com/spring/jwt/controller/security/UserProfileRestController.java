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

import com.spring.jwt.db.maria.dao.security.UserProfileRepository;
import com.spring.jwt.db.maria.model.security.UserProfile;
import com.spring.jwt.service.UserService;

@RestController
@RequestMapping(path = "/auth/security")
public class UserProfileRestController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	UserProfileRepository userProfileRepository;
	@Autowired
	UserService userService;
	
	/**
	 * 查詢所有資料
	 * @return List<UserProfile>
	 */
	@GetMapping("userProfiles")
	public List<Map<String, Object>> getAllDatas(){		
		return userProfileRepository.findAllToList();
	}
	
	/**
	 * 取得某一筆資料
	 * @param id
	 * @return
	 */
	@GetMapping("userProfile/{id}")
	public ResponseEntity<?> getData(@PathVariable Long id){
		Optional<UserProfile> userProfile = userProfileRepository.findById(id);
		if (userProfile.isPresent()) {
			return new ResponseEntity<UserProfile>(userProfile.get(), HttpStatus.OK);
		} else {
			return new ResponseEntity(ResponseEntity.notFound().build(), HttpStatus.NOT_FOUND);
		}
		
	}
	
	/**
	 * 新增
	 * @param userProfile  可以用 @RequestBody Map<String,Object> params 取得所有 Form 裡的輸入值
	 * @param bindingResult
	 * @return
	 */
	@PostMapping("userProfile")	
	public ResponseEntity<?> addData(@RequestBody @Valid UserProfile userProfile, BindingResult bindingResult){
		
		UserProfile newEntity = new UserProfile();
		URI location = null;
		
		if ( bindingResult.hasErrors()) {
			return new ResponseEntity(bindingResult.getFieldErrors(),HttpStatus.METHOD_NOT_ALLOWED);
		}
		
		try {	
			userProfile.setCreateDate(new Date());
			userProfile.setCreateUser(userService.getCurrentUser().getId());
			newEntity = userProfileRepository.save(userProfile);
			location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}")
						.buildAndExpand(newEntity.getId()).toUri();
		} catch (DataIntegrityViolationException e) {			
			return new ResponseEntity(bindingResult.getFieldErrors(),HttpStatus.CONFLICT);
		} catch (Exception e) {
			return new ResponseEntity(bindingResult.getAllErrors(), HttpStatus.BAD_REQUEST);
		}
		
		return new ResponseEntity(ResponseEntity.created(location).build(),HttpStatus.CREATED);
		
	}
	
	/**
	 * 更新
	 * @param userProfile
	 * @param id
	 * @param bindingResult
	 * @return
	 */
	@PutMapping("userProfile/{id}")
	public ResponseEntity<?> updateData(@RequestBody @Valid UserProfile userProfile, @PathVariable long id, BindingResult bindingResult){
		Optional<UserProfile> currentEntity = userProfileRepository.findById(id);
		
		if (currentEntity.isPresent()) {
			try {
				userProfile.setId(id);
				userProfile.setUpdateDate(new Date());
				userProfile.setUpdateUser(userService.getCurrentUser().getId());
				userProfile.setCreateDate(currentEntity.get().getCreateDate());
				userProfile.setCreateUser(currentEntity.get().getCreateUser());
				userProfileRepository.save(userProfile);
				return new ResponseEntity( ResponseEntity.noContent().build(), HttpStatus.OK);
			} catch (DataIntegrityViolationException e) {			
				return new ResponseEntity(bindingResult.getFieldErrors(),HttpStatus.CONFLICT);
			} catch (Exception e) {
				return new ResponseEntity(bindingResult.getAllErrors(), HttpStatus.BAD_REQUEST);
			}
		} else {
			return new ResponseEntity( ResponseEntity.notFound().build(), HttpStatus.NOT_FOUND);
		}
		
	}
	
	/**
	 * 刪除
	 * @param id
	 */
	@DeleteMapping("userProfile/{id}")
	public void delData(@PathVariable Long id){
		userProfileRepository.deleteById(id);
	}
}
