package com.spring.jwt.db.maria.dao.security;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.spring.jwt.db.maria.model.security.UserProfile;

public interface UserProfileRepository extends JpaRepository<UserProfile, Long> {

	@Query("select new map "
			+ "(up.id as id, up.userId as userId, up.paramName as paramName, up.paramValue as paramValue, up.paramDesc as paramDesc,"
			+ " up.note as note, u.username as username, u.firstname as firstname, u.lastname as lastname) "
			+ "from UserProfile up, User u WHERE up.userId = u.id")
	List<Map<String, Object>> findAllToList();
	
	default Map<Long, UserProfile> findAllToMap() {
        return findAll().stream().collect(Collectors.toMap(UserProfile::getId, v -> v));
    }

	List<UserProfile> findByUserId(Long id);	
	
}
