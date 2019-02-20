package com.spring.jwt.db.maria.dao.hr;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.spring.jwt.db.maria.model.hr.Company;
import com.spring.jwt.db.maria.model.hr.Department;

public interface DepartmentRepository extends JpaRepository<Department, Long> {

	@Query("select d from Department d where d.company.id = :#{#company.id}")
	List<Department> findAllDepartmentsByCompany(@Param("company") Company company );
}
