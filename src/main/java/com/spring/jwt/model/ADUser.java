package com.spring.jwt.model;

import java.util.List;

import lombok.Data;

@Data
public class ADUser {
	
	private String name;
	// cn
	private String sAMAccountName;
	private String department;
	private String title;
	private List<String> role;
	private String mail;
	private String manager;	
	private String ipPhone;

	@Override
	public String toString() {

		StringBuffer stringBuffer = new StringBuffer();
		stringBuffer.append("name:" + name + ",");
		stringBuffer.append("sAMAccountName:" + sAMAccountName);
		if (role != null && role.size() > 0) {
			stringBuffer.append(",role:" + String.join(",", role));
		}

		return stringBuffer.toString();
	}
}
