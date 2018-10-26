package com.spring.jwt.db.maria.dao.security;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.jwt.db.maria.model.security.AppCodes;

public interface AppCodesRepository extends JpaRepository<AppCodes, Long> {

}
