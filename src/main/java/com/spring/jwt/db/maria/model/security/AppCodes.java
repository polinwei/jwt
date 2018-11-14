package com.spring.jwt.db.maria.model.security;
// Generated Oct 15, 2018 5:19:34 PM by Hibernate Tools 5.2.11.Final

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

import com.spring.jwt.db.maria.model.authentication.User;

/**
 * AppCodes generated by hbm2java
 */
@Entity
@Table(name = "app_codes", uniqueConstraints = @UniqueConstraint(columnNames = { "app_name",
		"code_type", "code_value" }))
public class AppCodes implements java.io.Serializable {

	private Long id;
	private User userByCreateUser;
	private User userByUpdateUser;
	private String appName;
	private String codeType;
	private String codeValue;
	private String codeDesc;
	private String codeDescEng;
	private Date createDate;
	private Date updateDate;

	public AppCodes() {
	}

	public AppCodes(String appName, String codeType, String codeValue) {
		this.appName = appName;
		this.codeType = codeType;
		this.codeValue = codeValue;
	}

	public AppCodes(User userByCreateUser, User userByUpdateUser, String appName, String codeType, String codeValue,
			String codeDesc, String codeDescEng, Date createDate, Date updateDate) {
		this.userByCreateUser = userByCreateUser;
		this.userByUpdateUser = userByUpdateUser;
		this.appName = appName;
		this.codeType = codeType;
		this.codeValue = codeValue;
		this.codeDesc = codeDesc;
		this.codeDescEng = codeDescEng;
		this.createDate = createDate;
		this.updateDate = updateDate;
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
	@JoinColumn(name = "create_user")
	public User getUserByCreateUser() {
		return this.userByCreateUser;
	}

	public void setUserByCreateUser(User userByCreateUser) {
		this.userByCreateUser = userByCreateUser;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "update_user")
	public User getUserByUpdateUser() {
		return this.userByUpdateUser;
	}

	public void setUserByUpdateUser(User userByUpdateUser) {
		this.userByUpdateUser = userByUpdateUser;
	}

	@Column(name = "app_name", nullable = false, length = 100)
	public String getAppName() {
		return this.appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	@Column(name = "code_type", nullable = false, length = 50)
	public String getCodeType() {
		return this.codeType;
	}

	public void setCodeType(String codeType) {
		this.codeType = codeType;
	}

	@Column(name = "code_value", nullable = false, length = 100)
	public String getCodeValue() {
		return this.codeValue;
	}

	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}

	@Column(name = "code_desc", length = 65535)
	public String getCodeDesc() {
		return this.codeDesc;
	}

	public void setCodeDesc(String codeDesc) {
		this.codeDesc = codeDesc;
	}

	@Column(name = "code_desc_eng", length = 65535)
	public String getCodeDescEng() {
		return this.codeDescEng;
	}

	public void setCodeDescEng(String codeDescEng) {
		this.codeDescEng = codeDescEng;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_date", length = 19)
	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "update_date", length = 19)
	public Date getUpdateDate() {
		return this.updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

}