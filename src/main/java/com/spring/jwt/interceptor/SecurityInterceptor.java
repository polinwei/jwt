package com.spring.jwt.interceptor;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.LocaleUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.spring.jwt.authentication.security.JwtUser;

public class SecurityInterceptor extends HandlerInterceptorAdapter {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	private Authentication authentication;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {		
		
		String controllerName = ((HandlerMethod)handler).getResolvedFromHandlerMethod().getBean().toString();
		authentication = SecurityContextHolder.getContext().getAuthentication();
		JwtUser jwtUser = (JwtUser)authentication.getPrincipal();
		System.out.println("preHandle Control: " + controllerName);
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		String controllerName = ((HandlerMethod)handler).getResolvedFromHandlerMethod().getBean().toString();
		authentication = SecurityContextHolder.getContext().getAuthentication();
		JwtUser jwtUser = (JwtUser)authentication.getPrincipal();
		ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setBasenames("i18n/messages");
		Locale currentLocale = null;
		Cookie myLocaleCookie = WebUtils.getCookie(request, "myLocaleCookie");
		
		if (request.getAttribute("lang")!=null) {
			currentLocale = LocaleUtils.toLocale(request.getAttribute("lang").toString());
		} else if ( myLocaleCookie!=null && myLocaleCookie.getValue()!=null ) {
			currentLocale = LocaleUtils.toLocale(myLocaleCookie.getValue());
		} else {
			currentLocale = request.getLocale();
		}
		
		Map<String,Object> progPermits = new HashMap<>();
		progPermits.put("programName", messageSource.getMessage("program."+controllerName+".programName", null, "PROGNAME_NOT_DEFINE", currentLocale) );
		progPermits.put("isAdd", true);
		progPermits.put("isEdit", true);
		progPermits.put("isDel", false);
		progPermits.put("isQuery", true);
		progPermits.put("isPrint", true);
		request.setAttribute("progPermits", progPermits);
		
		System.out.println("postHandle Control: " + controllerName);
		
	}	
	
}
