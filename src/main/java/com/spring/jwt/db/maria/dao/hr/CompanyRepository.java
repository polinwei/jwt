package com.spring.jwt.db.maria.dao.hr;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.jwt.db.maria.model.hr.Company;

public interface CompanyRepository extends JpaRepository<Company, Long> {

}
