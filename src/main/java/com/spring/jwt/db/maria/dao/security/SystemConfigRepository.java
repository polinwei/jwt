package com.spring.jwt.db.maria.dao.security;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.jwt.db.maria.model.security.SystemConfig;

public interface SystemConfigRepository extends JpaRepository<SystemConfig, Long>{

	SystemConfig findByParamName(String paramName);
}
