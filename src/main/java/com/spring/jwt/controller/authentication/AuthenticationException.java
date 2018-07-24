package com.spring.jwt.controller.authentication;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class AuthenticationException extends RuntimeException {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public AuthenticationException(String message, Throwable cause) {
        super(message, cause);
    }
}
