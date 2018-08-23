package com.spring.jwt.authentication.security;

import java.io.Serializable;

import lombok.Data;

@Data
public class SessionDetails implements Serializable {
	private String location;

	private String accessType;

	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getAccessType() {
		return this.accessType;
	}

	public void setAccessType(String accessType) {
		this.accessType = accessType;
	}
}
