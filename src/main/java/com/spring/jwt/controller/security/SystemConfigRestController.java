package com.spring.jwt.controller.security;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.jwt.db.maria.dao.security.SystemConfigRepository;
import com.spring.jwt.db.maria.model.security.SystemConfig;

@RestController
@RequestMapping(path = "/auth/security")
public class SystemConfigRestController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	SystemConfigRepository scRepository;
	
	/**
	 * 查詢所有資料
	 * @return List<UserProfile>
	 */
	@GetMapping("systemConfigs")
	public List<SystemConfig> getAllDatas(){	
		return scRepository.findAll();
	}
}
