package com.spring.jwt.db.maria.dao.authentication;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.jwt.db.maria.model.authentication.Authority;

public interface AuthorityRepository extends JpaRepository<Authority, Long> {

}
