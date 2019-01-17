package com.spring.jwt.db.maria.model.authentication;
// Generated Oct 5, 2018 3:15:23 PM by Hibernate Tools 5.2.11.Final

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.spring.jwt.db.maria.model.security.UserProfile;

/**
 * User generated by hbm2java
 */
@Entity
@Table(name = "user", uniqueConstraints = @UniqueConstraint(columnNames = "username"))
public class User implements java.io.Serializable {

	private Long id;
	private User userByCreateUser;
	private User userByUpdateUser;
	@Size(min=3, max=50 , message = "{Size}")
	private String username;
	@NotEmpty
	@Size(min=4, max=100 , message = "{Size}")
	private String password;
	private String avatar;
	private String firstname;
	private String lastname;
	private String email;
	private Boolean enabled;
	private Date lastpasswordresetdate;
	private Date activeDate;
	private Date inactiveDate;
	private Date createDate;
	private Date updateDate;	
	private Set<Authority> authorities = new HashSet<Authority>(0);
	private Set<User> usersForCreateUser = new HashSet<User>(0);
	private Set<User> usersForUpdateUser = new HashSet<User>(0);

	public User() {
	}

	public User(String username, String password, String avatar, String firstname, String lastname, String email,
			Date lastpasswordresetdate) {
		this.username = username;
		this.password = password;
		this.avatar = avatar;
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.lastpasswordresetdate = lastpasswordresetdate;
	}

	public User(User userByCreateUser, User userByUpdateUser, String username, String password, String avatar,
			String firstname, String lastname, String email, Boolean enabled, Date lastpasswordresetdate,
			Date activeDate, Date inactiveDate, Date createDate, Date updateDate, Set<Authority> authorities,
			Set<User> usersForCreateUser, Set<User> usersForUpdateUser) {
		this.userByCreateUser = userByCreateUser;
		this.userByUpdateUser = userByUpdateUser;
		this.username = username;
		this.password = password;
		this.avatar = avatar;
		this.firstname = firstname;
		this.lastname = lastname;
		this.email = email;
		this.enabled = enabled;
		this.lastpasswordresetdate = lastpasswordresetdate;
		this.activeDate = activeDate;
		this.inactiveDate = inactiveDate;
		this.createDate = createDate;
		this.updateDate = updateDate;		
		this.authorities = authorities;
		this.usersForCreateUser = usersForCreateUser;
		this.usersForUpdateUser = usersForUpdateUser;
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
	@JsonIgnore
	public User getUserByCreateUser() {
		return this.userByCreateUser;
	}

	public void setUserByCreateUser(User userByCreateUser) {
		this.userByCreateUser = userByCreateUser;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "update_user")
	@JsonIgnore
	public User getUserByUpdateUser() {
		return this.userByUpdateUser;
	}

	public void setUserByUpdateUser(User userByUpdateUser) {
		this.userByUpdateUser = userByUpdateUser;
	}

	@Column(name = "username", unique = true, nullable = false, length = 50)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "password", nullable = false, length = 100)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "avatar", nullable = false, length = 100)
	public String getAvatar() {
		return this.avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	@Column(name = "firstname", nullable = false, length = 50)
	public String getFirstname() {
		return this.firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	@Column(name = "lastname", nullable = false, length = 50)
	public String getLastname() {
		return this.lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	@Column(name = "email", nullable = false, length = 50)
	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "enabled")
	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "lastpasswordresetdate", nullable = false, length = 19)
	public Date getLastpasswordresetdate() {
		return this.lastpasswordresetdate;
	}

	public void setLastpasswordresetdate(Date lastpasswordresetdate) {
		this.lastpasswordresetdate = lastpasswordresetdate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "active_date", length = 19)
	public Date getActiveDate() {
		return this.activeDate;
	}

	public void setActiveDate(Date activeDate) {
		this.activeDate = activeDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "inactive_date", length = 19)
	public Date getInactiveDate() {
		return this.inactiveDate;
	}

	public void setInactiveDate(Date inactiveDate) {
		this.inactiveDate = inactiveDate;
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

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "user_authority", catalog = "my_spring", joinColumns = {
			@JoinColumn(name = "user_id", nullable = false, updatable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "authority_id", nullable = false, updatable = false) })
	@JsonManagedReference
	public Set<Authority> getAuthorities() {
		return this.authorities;
	}

	public void setAuthorities(Set<Authority> authorities) {
		this.authorities = authorities;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userByCreateUser")
	@JsonIgnore
	public Set<User> getUsersForCreateUser() {
		return this.usersForCreateUser;
	}

	public void setUsersForCreateUser(Set<User> usersForCreateUser) {
		this.usersForCreateUser = usersForCreateUser;
	}

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userByUpdateUser")
	@JsonIgnore
	public Set<User> getUsersForUpdateUser() {
		return this.usersForUpdateUser;
	}

	public void setUsersForUpdateUser(Set<User> usersForUpdateUser) {
		this.usersForUpdateUser = usersForUpdateUser;
	}

}
