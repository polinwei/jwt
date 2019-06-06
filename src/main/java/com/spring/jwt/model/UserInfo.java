package com.spring.jwt.model;

import java.util.Date;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class UserInfo {

	private Long Uid;
	@Size(min=3, max=50 , message = "{Size}")
	private String username;
	private Long userDetailId;
	private String empNo;
	@NotEmpty
	@Size(min=4, max=100 , message = "{Size}")
	@JsonProperty(access = JsonProperty.Access.WRITE_ONLY) // 在 json回傳時, 不要顯示密碼資訊
	private String password;
	private String avatar;
	private String firstname;
	private String lastname;
	private String email;
	private Boolean enabled;
	private Date activeDate;
	private Date inactiveDate;
	private Long companyId;
	private String companyCode;
	private String companyName;
	private Long departmentId;
	private String departmentName;
	private Long deptManagerId;
	private String deptManagerName;
	private Long userManagerId;
	private String userManagerName;
	private Date hireDate;
	private Date resignationDate;
	private String jobTitle;
	private String workAddress;
	
}
