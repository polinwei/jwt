package com.spring.jwt.db.maria.model.security;
// Generated Oct 24, 2018 11:31:11 AM by Hibernate Tools 5.2.11.Final

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

/**
 * UserProfile generated by hbm2java
 */
@Entity
@Table(name = "user_profile", uniqueConstraints = @UniqueConstraint(columnNames = { "user_id","param_name" }))
public class UserProfile implements java.io.Serializable {

	private Long id;
	private long userId;
	private String paramName;
	private String paramValue;
	private String paramDesc;
	private String note;
	private Date createDate;
	private Date updateDate;
	private Long createUser;
	private Long updateUser;

	public UserProfile() {
	}

	public UserProfile(long userId, String paramName, String paramValue) {
		this.userId = userId;
		this.paramName = paramName;
		this.paramValue = paramValue;
	}

	public UserProfile(long userId, String paramName, String paramValue, String paramDesc, String note, Date createDate,
			Date updateDate, Long createUser, Long updateUser) {
		this.userId = userId;
		this.paramName = paramName;
		this.paramValue = paramValue;
		this.paramDesc = paramDesc;
		this.note = note;
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

	@Column(name = "user_id", nullable = false)
	public long getUserId() {
		return this.userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	@Column(name = "param_name", nullable = false, length = 100)
	public String getParamName() {
		return this.paramName;
	}

	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	@Column(name = "param_value", nullable = false, length = 100)
	public String getParamValue() {
		return this.paramValue;
	}

	public void setParamValue(String paramValue) {
		this.paramValue = paramValue;
	}

	@Column(name = "param_desc", length = 100)
	public String getParamDesc() {
		return this.paramDesc;
	}

	public void setParamDesc(String paramDesc) {
		this.paramDesc = paramDesc;
	}

	@Column(name = "note", length = 65535)
	public String getNote() {
		return this.note;
	}

	public void setNote(String note) {
		this.note = note;
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
