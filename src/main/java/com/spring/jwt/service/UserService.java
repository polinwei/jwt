package com.spring.jwt.service;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.TimeZone;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;

import org.hibernate.query.NativeQuery;
import org.hibernate.query.internal.NativeQueryImpl;
import org.hibernate.transform.Transformers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
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
	@Autowired
	ObjectMapper jsonMapper;
	//在 service 層使用 @PersistenceContext 注解注入 EntityManager, 不需要操作完資料庫顯式的用 em.close() 關閉 entityManager
	@PersistenceContext(unitName = "puMaria") 
	EntityManager emMaria;
	
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
	/**
	 * 取得使用者的時區
	 * @param id
	 * @return
	 */
	public String getUserTimeZone(Long id) {
		String paramValue = getUserSpecificProfileByUid(id, "TIME_ZONE");
		if ( !StringUtils.isEmpty(paramValue)) {
			return paramValue;
		} else {
			return "UTC";
		}
	}
	
	/**
	 * 取得目前用戶的時區
	 * @return
	 */
	public String getCurrentUserTimeZone() {
		User user = getCurrentUser();
		return getUserTimeZone(user.getId());
	}
	/**
	 * json 產出時, 時區轉換成用戶在 userProfile 裡 paramName:TIME_ZONE 的時間
	 */
	public void changeToCurrentUserTimeZone() {		
		String userTZ = getCurrentUserTimeZone();
		jsonMapper.setTimeZone(TimeZone.getTimeZone(userTZ));		
	}
	
	public List<Map<String, Object>> findAllUsersByCompanyNativeQuery(Long CompanyId){
		Query q = (Query) emMaria.createNativeQuery("SELECT ud.*,u.username, u.avatar, u.firstname, u.lastname, u.enabled, "
				+ "c.company_name,c.company_code, d.department_name, m.manager_username, m.manager_avatar "
				+ "FROM user_details ud "
				+ "JOIN ( select * from user ) u ON ud.user_id = u.id "
				+ "JOIN ( select id,name as company_name, code as company_code from company) c ON ud.company_id = c.id "
				+ "JOIN ( select id,name as department_name from department) d ON ud.department_id = d.id "
				+ "LEFT JOIN (select id , username as manager_username, avatar as manager_avatar from user ) m ON ud.manager_id = m.id "
				+ "WHERE 1=1 "
				+ "AND c.id = :CompanyId ")
                .setParameter("CompanyId", CompanyId);
               
		//q.unwrap(SQLQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		q.unwrap(NativeQuery.class).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
		return q.getResultList();

	}
}
