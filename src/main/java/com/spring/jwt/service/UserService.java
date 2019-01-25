package com.spring.jwt.service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;

import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.spring.jwt.authentication.security.JwtUser;
import com.spring.jwt.db.maria.dao.authentication.UserRepository;
import com.spring.jwt.db.maria.dao.security.UserProfileRepository;
import com.spring.jwt.db.maria.model.authentication.User;
import com.spring.jwt.db.maria.model.security.UserProfile;

@Service
public class UserService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());	
	@Autowired
	HttpSession session;
	@Autowired
	UserRepository userRepo;
	@Autowired
	UserProfileRepository userProfileRepo;
	
	private Authentication authentication;
	
	public JwtUser getCurrentJwtUser() {
		JwtUser jwtUser = null;
		SecurityContextImpl sci = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
		if ( !Objects.isNull(sci) ) {
			authentication = sci.getAuthentication();
			return (JwtUser)authentication.getPrincipal();
		}
		return jwtUser;
	}
	
	public User getCurrentUser() {
		Optional<User> user = userRepo.findById(getCurrentJwtUser().getId());
		return user.get();
		
	}
	
	public User getUserByUid(Long id) {
		Optional<User> user = userRepo.findById(id);
		return user.get();
	}
	/**
	 * 取得 user 的個人參數
	 * @param id
	 * @return
	 */
	public List<UserProfile> getUserProfileByUid(Long id) {
		User user = userRepo.findById(id).get();
		return userProfileRepo.findByUserId(user.getId());
	}
	/**
	 * 取得 user 特定的個人參數值
	 * @param id
	 * @param paramName
	 * @return
	 */
	public String getUserSpecificProfileByUid(Long id, String paramName) {
		String paramValue = "";
		List<UserProfile> userProfiles = getUserProfileByUid(id);
		for (UserProfile userProfile : userProfiles) {
			if (userProfile.getParamName().equals(paramName)) {
				paramValue = userProfile.getParamValue();
			}
		}
		return paramValue;
	}
	
	public String getUserTimeZone(Long id) {
		String paramValue = getUserSpecificProfileByUid(id, "TIME_ZONE");
		if ( !StringUtils.isEmpty(paramValue)) {
			return paramValue;
		} else {
			return "UTC";
		}
	}
	
}
