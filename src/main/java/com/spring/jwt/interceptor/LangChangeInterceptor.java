package com.spring.jwt.interceptor;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;
import org.springframework.web.util.WebUtils;

public class LangChangeInterceptor extends LocaleChangeInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws ServletException {
		// TODO Auto-generated method stub
		String newLocale = request.getParameter(getParamName());
		Cookie myLocaleCookie = WebUtils.getCookie(request, "myLocaleCookie");
		
		if (newLocale != null) {
			request.setAttribute("lang", newLocale);			
		} else if (myLocaleCookie != null) {
			request.setAttribute("lang", myLocaleCookie.getValue());
		}				
		// Proceed in any case.
		return true;
	}

}
