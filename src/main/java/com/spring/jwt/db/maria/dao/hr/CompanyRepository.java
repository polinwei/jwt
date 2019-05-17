package com.spring.jwt.db.maria.dao.hr;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.spring.jwt.db.maria.model.hr.Company;

public interface CompanyRepository extends JpaRepository<Company, Long> {

	/**
	 * CURRENT_DATE - is evaluated to the current date (a java.sql.Date instance).
	 * CURRENT_TIME - is evaluated to the current time (a java.sql.Time instance).
	 * CURRENT_TIMESTAMP - is evaluated to the current timestamp, i.e. date and time (a java.sql.Timestamp instance).
	 * @return
	 */
	@Query("SELECT c FROM Company c WHERE c.startDate < CURRENT_DATE AND c.endDate > CURRENT_DATE")
	List<Company> findAllValidCompanies();
	
}
