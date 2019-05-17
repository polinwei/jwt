package com.spring.jwt.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.jwt.db.maria.dao.hr.CompanyRepository;
import com.spring.jwt.db.maria.dao.hr.DepartmentRepository;
import com.spring.jwt.db.maria.model.hr.Company;
import com.spring.jwt.db.maria.model.hr.Department;

@Service
public class OrganizationService {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());	
	@Autowired 
	CompanyRepository companyRepo;
	@Autowired
	DepartmentRepository departmentRepo;
	
	/**
	 * 尋找生效中的公司
	 * @param isActive
	 * @return
	 */
	public List<Company> getAllCompanies(boolean isActive) {
		if (isActive) {
			return companyRepo.findAllValidCompanies();
		} else {
			return companyRepo.findAll();
		}
	}
	
	/**
	 * 以 company_id 尋找公司
	 * @param company_id
	 * @return
	 */
	public Company findCompanyById(Long company_id) {
		return companyRepo.findById(company_id).get();
	}
	
	public Department findDepartmentById(Long department_id) {
		return departmentRepo.findById(department_id).get();
	}
	
}
