package com.spring.jwt.db.maria.dao.hr;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.jwt.db.maria.model.authentication.User;
import com.spring.jwt.db.maria.model.hr.Company;
import com.spring.jwt.db.maria.model.hr.Department;
import com.spring.jwt.db.maria.model.hr.UserDetails;

public interface UserDetailsRepository extends JpaRepository<UserDetails, Long> {

	List<UserDetails> findAllUsersByCompany(Company company);

	
}
