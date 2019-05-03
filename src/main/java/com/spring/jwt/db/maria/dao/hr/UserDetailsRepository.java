package com.spring.jwt.db.maria.dao.hr;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.spring.jwt.db.maria.model.authentication.User;
import com.spring.jwt.db.maria.model.hr.Company;
import com.spring.jwt.db.maria.model.hr.Department;
import com.spring.jwt.db.maria.model.hr.UserDetails;

public interface UserDetailsRepository extends JpaRepository<UserDetails, Long> {

	List<UserDetails> findAllUsersByCompany(Company company);

	@Query(value = "SELECT ud.*,u.username, u.avatar, u.firstname, u.lastname, u.enabled, "
			+ "c.company_name,c.company_code, d.department_name, m.manager_username, m.manager_avatar "
			+ "FROM user_details ud "
			+ "JOIN ( select * from user ) u ON ud.user_id = u.id "
			+ "JOIN ( select id,name as company_name, code as company_code from company) c ON ud.company_id = c.id "
			+ "JOIN ( select id,name as department_name from department) d ON ud.department_id = d.id "
			+ "LEFT JOIN (select id , username as manager_username, avatar as manager_avatar from user ) m ON ud.manager_id = m.id "
			+ "WHERE 1=1 "			
			+ "AND ud.company_id = :CompanyId ", 
			nativeQuery = true)
	List<Map<String, Object>> findAllUsersByCompanyNativeQuery(@Param("CompanyId") Long CompanyId);
	
}
