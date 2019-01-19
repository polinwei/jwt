package com.spring.jwt.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

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
	/**
	 * 取得上載圖片的路徑
	 * @param uploadType
	 * @return
	 */
	public String getImagePathByType(String uploadType) {
		if (scRepository.findByParamName(uploadType)!=null) {
			return scRepository.findByParamName(uploadType).getParamValue();
		} else {
			return "";
		}
		
	}
	/**
	 * 將前端傳來的 ISO日期字串轉成日期
	 * @param isoDate
	 * @return
	 * @throws ParseException
	 */
	public Date ConvertStringToDate(Object isoDate) throws ParseException{
		if ( StringUtils.isEmpty(isoDate))
			return null;
		
		SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
		Date date = inputFormat.parse(isoDate.toString());
		return date;
	}
}
