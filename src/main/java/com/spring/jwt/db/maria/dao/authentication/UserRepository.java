package com.spring.jwt.db.maria.dao.authentication;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.jwt.db.maria.model.authentication.User;

public interface UserRepository extends JpaRepository<User, Long> {

	User findByUsername(String username);
}
