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
	
	
	@Query(value = "SELECT u.id as uid, u.username, u.password, u.avatar, u.firstname, u.lastname, u.email, u.enabled, "
			+ "u.active_date as activeDate, u.inactive_date as inactiveDate, "
			+ "ud.id as userDetailId, ud.emp_no as empNo, ud.company_id as companyId, ud.department_id as departmentId, "
			+ "ud.manager_id as userManagerId, ud.hire_date as hireDate, "
			+ "ud.resignation_date as resignationDate, ud.job_title as jobTitle, ud.work_address as workAddress, "
			+ "c.code as companyCode, c.name as companyName, d.name as departmentName, d.manager_id as deptManagerId "
			+ "FROM user u , user_details ud, company c, department d "
			+ "WHERE 1=1 "
			+ "AND u.id = ud.user_id "
			+ "AND ud.company_id = c.id "
			+ "AND ud.department_id =d.id "
			+ "AND u.id = :userId "
			+ "AND ud.id = :userDetailId", 
			nativeQuery = true)
	Map<String, Object> findUserInfoByUserIdAndUserDetailId(@Param("userId") Long userId, @Param("userDetailId") Long userDetailId);
	
	@Query(value = "SELECT u.id as uid, u.username, u.password, u.avatar, u.firstname, u.lastname, u.email, u.enabled, "
			+ "u.active_date as activeDate, u.inactive_date as inactiveDate, "
			+ "ud.id as userDetailId, ud.emp_no as empNo, ud.company_id as companyId, ud.department_id as departmentId, "
			+ "ud.manager_id as userManagerId, ud.hire_date as hireDate, "
			+ "ud.resignation_date as resignationDate, ud.job_title as jobTitle, ud.work_address as workAddress, "
			+ "c.code as companyCode, c.name as companyName, d.name as departmentName, d.manager_id as deptManagerId "
			+ "FROM user u , user_details ud, company c, department d "
			+ "WHERE 1=1 "
			+ "AND u.id = ud.user_id "
			+ "AND ud.company_id = c.id "
			+ "AND ud.department_id =d.id ", 
			nativeQuery = true)
	List<Map<String, Object>> findAllUserInfo();
	
	
}
