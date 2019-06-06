package com.spring.jwt.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeFormatterBuilder;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.jwt.db.maria.dao.security.AppCodesRepository;
import com.spring.jwt.db.maria.dao.security.SystemConfigRepository;

@Service
public class BaseService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());	
	
	@Autowired
	HttpServletRequest request;
	@Autowired
	SystemConfigRepository scRepository;
	@Autowired
	AppCodesRepository acRepository;
	
	public String getAvatarFolder() {
		return scRepository.findByParamName("AVATAR_FOLDER").getParamValue();
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
	 * 將前端傳來的 ISO日期字串 轉成 日期
	 * @param isoDate
	 * @return
	 * @throws ParseException
	 */
	public Date IsoStringToDate(Object strDate) throws ParseException{
		if ( StringUtils.isEmpty(strDate))
			return null;
		
		SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");                
    	Date date = null;
		try {
			date = inputFormat.parse(strDate.toString());
		} catch (Exception e) {			
			try {
				inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
				date = inputFormat.parse(strDate.toString());
			} catch (Exception e1) {						
				try {
					inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
					date = inputFormat.parse(strDate.toString());
				} catch (Exception e2) {
					try {
						inputFormat = new SimpleDateFormat("yyyy-MM-dd");
						date = inputFormat.parse(strDate.toString());
					} catch (Exception e3) {
						// TODO Auto-generated catch block
						e3.printStackTrace();
					}
				}
			}
		}
        return date;
	}
	/**
	 * 資料庫table裡的 UTC 日期, 轉換到其它時區時間
	 * @param utcDate
	 * @param to_tz
	 * @return
	 */
	public Date utcDateConvert(Date utcDate, String to_tz) {
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
		sdf.setTimeZone(TimeZone.getTimeZone(to_tz));
		try {
			date = sdf.parse(utcDate.toString());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		return date;		
	}
	/**
	 * 將 BigInteger 的 Object 類型轉換成 Long
	 * @param o
	 * @return
	 */
	public Long ObjectConvertToLong(Object o){
        String stringToConvert = String.valueOf(o);
        Long convertedLong = Long.parseLong(stringToConvert);
        return convertedLong;

    }
	
}
