package com.spring.jwt.controller.hr;

import java.net.URI;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.spring.jwt.db.maria.dao.hr.CompanyRepository;
import com.spring.jwt.db.maria.dao.hr.DepartmentRepository;
import com.spring.jwt.db.maria.model.hr.Company;
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
	
	/**
	 *  查詢所有資料
	 * @return
	 */
	@GetMapping("companies")
	public List<Company> getAllCompany(){		
		return companyRepo.findAll();
	}
	
	/**
	 * 取得一筆資料
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
	 * 新增
	 * @param company
	 * @param BindingResult
	 * @return
	 */
	@PostMapping("company")
	public ResponseEntity<?> addCompany(@RequestBody @Valid Company company, BindingResult br){
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
	 * 更新
	 * @param company
	 * @param id
	 * @param BindingResult
	 * @return
	 */
	@PutMapping("company/{id}")
	public ResponseEntity<?> updateCompany(@RequestBody @Valid Company company, @PathVariable long id, BindingResult br) {
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
	@DeleteMapping("company/{id}")
	public void deleteCompany(@PathVariable long id) {
		companyRepo.deleteById(id);
	}
	
	
}
