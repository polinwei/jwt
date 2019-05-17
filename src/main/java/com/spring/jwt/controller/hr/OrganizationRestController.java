package com.spring.jwt.controller.hr;

import java.net.URI;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.validation.Valid;
import org.modelmapper.ModelMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
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
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.jwt.db.maria.dao.hr.CompanyRepository;
import com.spring.jwt.db.maria.dao.hr.DepartmentRepository;
import com.spring.jwt.db.maria.dao.hr.UserDetailsRepository;
import com.spring.jwt.db.maria.model.authentication.User;
import com.spring.jwt.db.maria.model.hr.Company;
import com.spring.jwt.db.maria.model.hr.Department;
import com.spring.jwt.db.maria.model.hr.UserDetails;
import com.spring.jwt.service.BaseService;
import com.spring.jwt.service.OrganizationService;
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
    ModelMapper modelMapper;
	@Autowired
	UserDetailsRepository userDetailsRepo;
	@Autowired
	OrganizationService orgService;
	
	@Autowired
	ObjectMapper jsonMapper;
	@PersistenceContext(unitName = "puMaria") 
	EntityManager emMaria;
	
	
	/**
	 *  查詢所有公司資料
	 * @return
	 */
	@GetMapping("companies")
	public List<Company> getAllCompany(){		
		userService.changeToCurrentUserTimeZone();	
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
		userService.changeToCurrentUserTimeZone();
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
		//params.put("startDate", baseService.IsoStringToDate(params.get("startDate")));
		//params.put("endDate", baseService.IsoStringToDate(params.get("endDate")));
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
		userService.changeToCurrentUserTimeZone();
		return departmentRepo.findAll();
	}
	
	/**
	 *  查詢公司的所有部門資料
	 * @return
	 */
	@GetMapping("departmentsByCompany/{companyId}")
	public List<Department> getCompanyAllDepartment(@PathVariable long companyId){
		List<Department> departmentsByCompany = new ArrayList<>();
		userService.changeToCurrentUserTimeZone();
		Company company = companyRepo.findById(companyId).get();
		departmentsByCompany = departmentRepo.findAllDepartmentsByCompany(company);
		return 	departmentsByCompany;
	}
	/**
	 * 查公司的所有人員
	 * @param companyId
	 * @return
	 */
	@GetMapping("usersByCompany/{companyId}")
	public List<UserDetails> getCompanyAllUser(@PathVariable long companyId){
		List<UserDetails> usersByCompany = new ArrayList<>();		
		Company company = companyRepo.findById(companyId).get();
		usersByCompany = userDetailsRepo.findAllUsersByCompany(company);		
		return 	usersByCompany;
	}
	/**
	 * 查公司的所有人員-利用 Native Query
	 * @param companyId
	 * @return
	 */
	@GetMapping("usersByCompanyNativeQuery/{companyId}")
	public List<Map<String, Object>> getCompanyAllUserDetails(@PathVariable long companyId){
				
		return 	userService.findAllUsersByCompanyNativeQuery(companyId);
	}
	
	/**
	 *  查詢公司的所有資料回傳給前端 jqxTree 使用
	 * @return
	 */
	@GetMapping("companyTree/{companyId}")
	public List<Map<String, Object>> companyTree(@PathVariable long companyId){		
		
		userService.changeToCurrentUserTimeZone();
		Company company = companyRepo.findById(companyId).get();
		List<Department> departmentsByCompany = departmentRepo.findAllDepartmentsByCompany(company);		
		
		List<Map<String, Object>> orgHierarchy = new ArrayList<Map<String,Object>>();
		for (Department department : departmentsByCompany) {
			//取得最上階
			if (department.getUpperDepart()==null) {
				orgHierarchy.add(getDeptsAndUsersHierarchy(department));
				
			}
		}
		
		return 	orgHierarchy;
	}
	
	/**
	 * 取得一筆部門資料
	 * @param id
	 * @return
	 */
	@GetMapping("department/{id}")
	public ResponseEntity<?> getDepartment(@PathVariable Long id){
		userService.changeToCurrentUserTimeZone();
		Optional<Department> department = departmentRepo.findById(id);
		if (department.isPresent()) {
			return new ResponseEntity<Department>(department.get(),HttpStatus.OK);
		} else {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
	}
	
	/**
	 * 新增/更新部門
	 * @param department
	 * @param BindingResult
	 * @return
	 */
	@PostMapping("department")
	public ResponseEntity<?> saveDepartment(@RequestBody Map<String,Object> params, BindingResult br){
		Department department =  modelMapper.map(params, Department.class);
		Department newEntity = new Department();
		Department upperOrderDepartment = new Department();
		URI location = null;
		
		if ( br.hasErrors()) {
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.METHOD_NOT_ALLOWED);
		}
		
		try {
			String opName = (String) params.get("opName");
			Company company = companyRepo.findById(Long.parseLong((String) params.get("company_id")) ).get();
			if (! StringUtils.isEmpty(params.get("upper_dept_id"))) {
				upperOrderDepartment = departmentRepo.findById(Long.parseLong((String) params.get("upper_dept_id"))).get();
				
			} else {
				upperOrderDepartment = null;
			}
			department.setDepartment(upperOrderDepartment);
			
			Long managerId = null;
			User deptManager = null;
			if (! StringUtils.isEmpty(params.get("manager_id"))) {
				managerId = Long.parseLong((String) params.get("manager_id"));
				deptManager = userService.getUserByUid(managerId);
			}
			
			department.setCompany(company);			
			department.setUserByManagerId(deptManager);
			if (opName.equalsIgnoreCase("post")) { // 新增
				department.setCreateDate(new Date());
				department.setCreateUser(userService.getCurrentUser().getId());
			}
			if (opName.equalsIgnoreCase("put")) { // 更新
				department.setUpdateDate(new Date());
				department.setUpdateUser(userService.getCurrentUser().getId());
			}
			
			newEntity = departmentRepo.save(department);
			location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(newEntity.getId()).toUri();
			
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.CONFLICT);
		} catch (Exception e) {
			e.printStackTrace();
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
	
	/**
	 * 儲存 UserDetail 資料(新增)
	 * @param params
	 * @param br
	 * @return
	 */
	@PostMapping("userDetail")
	public ResponseEntity<?> saveUserDetail(@RequestBody Map<String,Object> params, BindingResult br){
		
		UserDetails userDetail = new UserDetails();
		
		if (! StringUtils.isEmpty(params.get("id"))) {
			userDetail = userDetailsRepo.findById(Long.parseLong((String) params.get("id"))).get();
		}
		
		Company company = orgService.findCompanyById(Long.parseLong((String) params.get("company_id")));		
		Department department = orgService.findDepartmentById(Long.parseLong((String) params.get("department_id")));
		User manager = userService.getUserByUid(Long.parseLong((String) params.get("manager_id")));
		User user = userService.getUserByUid(Long.parseLong((String) params.get("user_id")));

						
		URI location = null;
		
		if ( br.hasErrors()) {
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.METHOD_NOT_ALLOWED);
		}
		
		try {
			String opName = (String) params.get("opName");
			userDetail.setCompany(company);
			userDetail.setDepartment(department);
			userDetail.setUserByManagerId(manager);
			userDetail.setUserByUserId(user);
			userDetail.setEmpNo((String) params.get("empNo"));
			userDetail.setJobTitle((String) params.get("jobTitle"));
			userDetail.setWorkAddress((String) params.get("workAddress"));
			if (opName.equalsIgnoreCase("post")) { // 新增
				userDetail.setCreateDate(new Date());
				userDetail.setCreateUser(userService.getCurrentUser().getId());				
			}
			if (opName.equalsIgnoreCase("put")) { // 更新
				userDetail.setUpdateDate(new Date());
				userDetail.setUpdateUser(userService.getCurrentUser().getId());				
			}
			UserDetails newEntity = userDetailsRepo.save(userDetail);
			location = ServletUriComponentsBuilder.fromCurrentRequest().path("/{id}").buildAndExpand(newEntity.getId()).toUri();
			
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			return new ResponseEntity(br.getFieldErrors(),HttpStatus.CONFLICT);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity(br.getAllErrors(), HttpStatus.BAD_REQUEST);
		}
		return new ResponseEntity(ResponseEntity.created(location).build(),HttpStatus.OK);
	}
	
	public Map<String,Object> getDeptsAndUsersHierarchy(Department department){
		Map<String,Object> depts = new HashMap<String,Object>();
		String iconPath = "/auth/showphoto/AVATAR_FOLDER/folder.png";
		// 最上階部門資訊
		depts.put("id"   , "d"+department.getId().toString());
		depts.put("upperDepartId", department.getUpperDepart());
		depts.put("label", department.getName());
		depts.put("value", "departId:"+department.getId().toString());		
		depts.put("icon", iconPath);
		
		List<Map<String, Object>> items = new ArrayList<Map<String,Object>>();
		//同一階部的裡的員工
		for (UserDetails user : department.getUserDetailses()) {
			HashMap<String, Object> param = new HashMap<String,Object>();
			param.put("id"   , "u"+user.getId().toString());
			param.put("label", user.getUserByUserId().getUsername());
			param.put("value", "userId:"+user.getId().toString());
			
			iconPath = "/auth/showphoto/AVATAR_FOLDER/avatar.png";
			if (!StringUtils.isEmpty(user.getUserByUserId().getAvatar())) {				
				iconPath = "/auth/showphoto/AVATAR_FOLDER/" + user.getUserByUserId().getAvatar();
			}
			param.put("icon", iconPath);
			param.put("iconsize","24");
			items.add(param);
		}
		
		for (Department dept : department.getDepartments()) {
			HashMap<String, Object> param = new HashMap<String,Object>();
			param.put("id"   , "d"+dept.getId().toString());
			param.put("upperDepartId", dept.getUpperDepart());
			param.put("label", dept.getName());
			param.put("value","departId:"+dept.getId().toString());
			iconPath = "/auth/showphoto/AVATAR_FOLDER/folder.png";
			param.put("icon", iconPath);
			items.add(param);
			// 檢查是否有下階部門
			if (dept.getDepartments().size()>0) {
				List<Department> nextDept = new ArrayList<>();
				nextDept.addAll(dept.getDepartments());
				items.add( getDeptsAndUsersHierarchy( nextDept.get(0) ));
			}
		}		
		depts.put("items", items);
		return depts;
	}
}
