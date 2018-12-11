package com.spring.jwt.config;

import java.util.Objects;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;

import com.ckfinder.connector.configuration.ConfigurationFactory;
import com.ckfinder.connector.configuration.DefaultPathBuilder;
import com.ckfinder.connector.configuration.IConfiguration;
import com.ckfinder.connector.utils.PathUtils;

public class CKFinderConfigurationPathBuilder extends DefaultPathBuilder {	

	private Authentication authentication;
	/**
	 * Gets configuration value of baseUrl. When config value is not set, then return default value.
	 *
	 * @param request request
	 * @return default baseDir value
	 */
	@Override
	public String getBaseUrl(final HttpServletRequest request) {
		SecurityContextImpl sci = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
		if ( !Objects.isNull(sci) ) {
			authentication = sci.getAuthentication();
		}
		String baseURL;
		try {
			IConfiguration conf = ConfigurationFactory.getInstace().getConfiguration();
			baseURL = conf.getBaseURL();
		} catch (Exception e) {
			baseURL = null;
		}
		if (baseURL == null || baseURL.equals("")) {
			baseURL = super.getBaseUrl(request);
		}
		baseURL += authentication.getName() + "/";
		return PathUtils.addSlashToBeginning(PathUtils.addSlashToEnd(baseURL));
	}

	/**
	 * Gets configuration value of baseDir. When config value is not set, then return default value.
	 *
	 * @param request request
	 * @return default baseDir value
	 */
	@Override
	public String getBaseDir(final HttpServletRequest request) {
		String baseDir;
		SecurityContextImpl sci = (SecurityContextImpl) request.getSession().getAttribute("SPRING_SECURITY_CONTEXT");
		if ( !Objects.isNull(sci) ) {
			authentication = sci.getAuthentication();
		}
		try {
			IConfiguration conf = ConfigurationFactory.getInstace().getConfiguration();
			baseDir = conf.getBaseDir();
		} catch (Exception e) {
			baseDir = null;
		}
		baseDir += authentication.getName() + "/";
		
		if (baseDir == null || baseDir.equals("")) {
			return super.getBaseDir(request);
		} else {
			return baseDir;
		}
	}

}
