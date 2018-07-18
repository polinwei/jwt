package com.spring.jwt.db.maria.dao.authentication;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.jwt.db.maria.model.authentication.UserAuthority;
import com.spring.jwt.db.maria.model.authentication.UserAuthorityId;

public interface UserAuthorityRepository extends JpaRepository<UserAuthority, UserAuthorityId> {

}
