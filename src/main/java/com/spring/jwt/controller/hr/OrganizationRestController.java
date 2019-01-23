package com.spring.jwt.controller.hr;

import java.net.URI;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.jwt.db.maria.dao.hr.CompanyRepository;
import com.spring.jwt.db.maria.dao.hr.DepartmentRepository;
import com.spring.jwt.db.maria.model.hr.Company;
import com.spring.jwt.db.maria.model.hr.Department;
import com.spring.jwt.service.BaseService;
import com.spring.jwt.service.UserService;

@RestController
@RequestMapping(path = "/auth/org")
public class OrganizationRestController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	CompanyRepository companyRepo;
	@Autowired
	DepartmentRepository departmentRepo;
	@Autowired
	UserService userService;
	@Autowired
	BaseService baseService;
	@Autowired
    private ModelMapper modelMapper;
	/**
	 *  查詢所有公司資料
	 * @return
	 */
	@GetMapping("companies")
	public List<Company> getAllCompany(){		
		return companyRepo.findAll();
	}
	
	/**
	 * 取得一筆公司資料
	 * @param id
	 * @return
	 */
	@GetMapping("company/{id}")
	public ResponseEntity<?> getCompany(@PathVariable Long id){
		Optional<Company> company = companyRepo.findById(id);
		if (company.isPresent()) {
			return new ResponseEntity<Company>(company.get(),HttpStatus.OK);
		} else {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
	}
	/**
	 * 新增公司
	 * @param company
	 * @param BindingResult
	 * @return
	 * @throws ParseException 
	 */
	@PostMapping("company")
	public ResponseEntity<?> addCompany(@RequestBody Map<String,Object> params , BindingResult br) throws ParseException{	

		//轉換日期
		params.put("startDate", baseService.IsoStringToDate(params.get("startDate")));
		params.put("endDate", baseService.IsoStringToDate(params.get("endDate")));
		Company company = modelMapper.map(params, Company.class);
		Company newEntity = new Company();
		URI location = null;
		
		if ( br.hasErrors()) {
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.METHOD_NOT_ALLOWED);
		}
		
		try {
			company.setCreateDate(new Date());
			company.setCreateUser(userService.getCurrentUser().getId());
			newEntity = companyRepo.save(company);
			location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(newEntity.getId()).toUri();
			
		} catch (DataIntegrityViolationException e) {			
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.CONFLICT);
		} catch (Exception e) {
			return new ResponseEntity(br.getAllErrors(), HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity(ResponseEntity.created(location).build(),HttpStatus.CREATED);
		
	}
	/**
	 * 更新公司
	 * @param company
	 * @param id
	 * @param BindingResult
	 * @return
	 */
	@PutMapping("company/{id}")
	public ResponseEntity<?> updateCompany(@RequestBody Map<String,Object> params, @PathVariable long id, BindingResult br) throws ParseException{
		//轉換日期
		//params.put("startDate", baseService.IsoStringToDate(params.get("startDate")));
		//params.put("endDate", baseService.IsoStringToDate(params.get("endDate")));
		Company company = modelMapper.map(params, Company.class);
		Optional<Company> currentEntity = companyRepo.findById(id);
		if (currentEntity.isPresent()) {
			try {
				company.setUpdateDate(new Date());
				company.setUpdateUser(userService.getCurrentUser().getId());
				company.setCreateUser(currentEntity.get().getCreateUser());
				company.setCreateDate(currentEntity.get().getCreateDate());
				companyRepo.save(company);
				
				return new ResponseEntity(HttpStatus.OK);
			} catch (DataIntegrityViolationException e) {			
				return new ResponseEntity(br.getFieldErrors(),HttpStatus.CONFLICT);
			} catch (Exception e) {
				return new ResponseEntity(br.getAllErrors(), HttpStatus.BAD_REQUEST);
			}
		} else {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
	}
	/**
	 * 刪除公司
	 * @param id
	 */
	@DeleteMapping("company/{id}")
	public void deleteCompany(@PathVariable long id) {
		companyRepo.deleteById(id);
	}
	
	/**
	 *  查詢所有部門資料
	 * @return
	 */
	@GetMapping("departments")
	public List<Department> getAllDepartment(){		
		return departmentRepo.findAll();
	}
	
	/**
	 * 取得一筆部門資料
	 * @param id
	 * @return
	 */
	@GetMapping("department/{id}")
	public ResponseEntity<?> getDepartment(@PathVariable Long id){
		Optional<Department> department = departmentRepo.findById(id);
		if (department.isPresent()) {
			return new ResponseEntity<Department>(department.get(),HttpStatus.OK);
		} else {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
	}
	
	/**
	 * 新增部門
	 * @param department
	 * @param BindingResult
	 * @return
	 */
	@PostMapping("department")
	public ResponseEntity<?> addDepartment(@RequestBody @Valid Department department, BindingResult br){
		Department newEntity = new Department();
		URI location = null;
		
		if ( br.hasErrors()) {
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.METHOD_NOT_ALLOWED);
		}
		
		try {
			department.setCreateDate(new Date());
			department.setCreateUser(userService.getCurrentUser().getId());
			newEntity = departmentRepo.save(department);
			location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(newEntity.getId()).toUri();
			
		} catch (DataIntegrityViolationException e) {			
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.CONFLICT);
		} catch (Exception e) {
			return new ResponseEntity(br.getAllErrors(), HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity(ResponseEntity.created(location).build(),HttpStatus.CREATED);
		
	}	
	
	/**
	 * 更新部門
	 * @param department
	 * @param id
	 * @param BindingResult
	 * @return
	 */
	@PutMapping("department/{id}")
	public ResponseEntity<?> updateDepartment(@RequestBody @Valid Department department, @PathVariable long id, BindingResult br) {
		Optional<Department> currentEntity = departmentRepo.findById(id);
		if (currentEntity.isPresent()) {
			try {
				department.setUpdateDate(new Date());
				department.setUpdateUser(userService.getCurrentUser().getId());
				department.setCreateUser(currentEntity.get().getCreateUser());
				department.setCreateDate(currentEntity.get().getCreateDate());
				departmentRepo.save(department);
				
				return new ResponseEntity(HttpStatus.OK);
			} catch (DataIntegrityViolationException e) {			
				return new ResponseEntity(br.getFieldErrors(),HttpStatus.CONFLICT);
			} catch (Exception e) {
				return new ResponseEntity(br.getAllErrors(), HttpStatus.BAD_REQUEST);
			}
		} else {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
	}
	/**
	 * 刪除部門
	 * @param id
	 */
	@DeleteMapping("department/{id}")
	public void deleteDepartment(@PathVariable long id) {
		departmentRepo.deleteById(id);
	}
	
}
