package com.spring.jwt.rest.demo;

import lombok.Data;

@Data
public class PersonDemo {

    private String name;
    private String email;
    
	public PersonDemo() {		
	}

	public PersonDemo(String name, String email) {		
		this.name = name;
		this.email = email;
	}
	
	
        
}
