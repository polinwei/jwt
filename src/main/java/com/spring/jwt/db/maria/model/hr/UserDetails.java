package com.spring.jwt.db.maria.model.hr;
// Generated Mar 5, 2019 8:51:06 AM by Hibernate Tools 4.3.5.Final

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.spring.jwt.db.maria.model.authentication.User;

/**
 * UserDetails generated by hbm2java
 */
@Entity
@Table(name = "user_details", uniqueConstraints = @UniqueConstraint(columnNames = "emp_no"))
public class UserDetails implements java.io.Serializable {

	private Long id;
	private Company company;
	private Department department;	
	private User userByManagerId;	
	private User userByUserId;
	private String empNo;
	private Date hireDate;
	private Date resignationDate;
	private String jobTitle;
	private String workAddress;
	private Date createDate;
	private Date updateDate;
	private Long createUser;
	private Long updateUser;

	public UserDetails() {
	}

	public UserDetails(User userByUserId, String empNo) {
		this.userByUserId = userByUserId;
		this.empNo = empNo;
	}

	public UserDetails(Company company, Department department, Long createUser, User userByManagerId,
			Long updateUser, User userByUserId, String empNo, Date hireDate, Date resignationDate,
			String jobTitle, String workAddress, Date createDate, Date updateDate) {
		this.company = company;
		this.department = department;		
		this.userByManagerId = userByManagerId;		
		this.userByUserId = userByUserId;
		this.empNo = empNo;
		this.hireDate = hireDate;
		this.resignationDate = resignationDate;
		this.jobTitle = jobTitle;
		this.workAddress = workAddress;
		this.createDate = createDate;
		this.updateDate = updateDate;
		this.createUser = createUser;
		this.updateUser = updateUser;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "id", unique = true, nullable = false)
	public Long getId() {
		return this.id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "company_id")
	@JsonIgnore
	public Company getCompany() {
		return this.company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "department_id")
	@JsonIgnore
	public Department getDepartment() {
		return this.department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "manager_id")
	public User getUserByManagerId() {
		return this.userByManagerId;
	}

	public void setUserByManagerId(User userByManagerId) {
		this.userByManagerId = userByManagerId;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	public User getUserByUserId() {
		return this.userByUserId;
	}

	public void setUserByUserId(User userByUserId) {
		this.userByUserId = userByUserId;
	}

	@Column(name = "emp_no", unique = true, nullable = false, length = 30)
	public String getEmpNo() {
		return this.empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "hire_date", length = 26)
	public Date getHireDate() {
		return this.hireDate;
	}

	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "resignation_date", length = 26)
	public Date getResignationDate() {
		return this.resignationDate;
	}

	public void setResignationDate(Date resignationDate) {
		this.resignationDate = resignationDate;
	}

	@Column(name = "job_title", length = 50)
	public String getJobTitle() {
		return this.jobTitle;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	@Column(name = "work_address", length = 200)
	public String getWorkAddress() {
		return this.workAddress;
	}

	public void setWorkAddress(String workAddress) {
		this.workAddress = workAddress;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_date", length = 26)
	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "update_date", length = 26)
	public Date getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Column(name = "create_user")
	public Long getCreateUser() {
		return this.createUser;
	}

	public void setCreateUser(Long createUser) {
		this.createUser = createUser;
	}

	@Column(name = "update_user")
	public Long getUpdateUser() {
		return this.updateUser;
	}

	public void setUpdateUser(Long updateUser) {
		this.updateUser = updateUser;
	}
}
