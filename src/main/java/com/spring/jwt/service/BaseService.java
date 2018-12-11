package com.spring.jwt.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.jwt.db.maria.dao.security.AppCodesRepository;
import com.spring.jwt.db.maria.dao.security.SystemConfigRepository;

@Service
public class BaseService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());	
	
	@Autowired
	SystemConfigRepository scRepository;
	@Autowired
	AppCodesRepository acRepository;
	
	public String getAvatarFolder() {
		return scRepository.findByParamName("avatar_folder").getParamValue();
	}
	
	public String getImagePathByType(String uploadType) {
		if (scRepository.findByParamName(uploadType)!=null) {
			return scRepository.findByParamName(uploadType).getParamValue();
		} else {
			return "";
		}
		
	}
}
