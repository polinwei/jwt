package com.spring.jwt.config;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.spring.jwt.interceptor.LangChangeInterceptor;
import com.spring.jwt.interceptor.SecurityInterceptor;

import freemarker.ext.jsp.TaglibFactory;

@Configuration
public class MvcConfig implements WebMvcConfigurer {
	 @Autowired
	 FreeMarkerConfigurer freeMarkerConfigurer;

    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/demo/bank").setViewName("demo/accountsPage");
        registry.addViewController("/demo/vue").setViewName("demo/vueDemo");
        registry.addViewController("/home").setViewName("home");
        registry.addViewController("/").setViewName("home");        
        registry.addViewController("/hello").setViewName("hello");
        registry.addViewController("/login").setViewName("login");
    }
    
    @Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {		
		WebMvcConfigurer.super.addResourceHandlers(registry);
		registry.addResourceHandler("/fileUpload/userfiles/").addResourceLocations("file:\\fileUpload\\CKFinderJava\\userfiles");
	}

	//多語系設定   
    @Bean(name = "localeResolver")
    public LocaleResolver getLocaleResolver()  {
        CookieLocaleResolver resolver= new CookieLocaleResolver();   
        resolver.setDefaultLocale(Locale.US);
        resolver.setCookieName("myLocaleCookie");
        resolver.setCookieMaxAge(60*60); 
        return resolver;
    }
     
    //加入 Interceptors
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
    	//多語系設定 語系切換偵測
        LocaleChangeInterceptor localeInterceptor = new LocaleChangeInterceptor();
        LangChangeInterceptor langChangeInterceptor = new LangChangeInterceptor();
        localeInterceptor.setParamName("lang");       
        registry.addInterceptor(localeInterceptor).addPathPatterns("/**");
        langChangeInterceptor.setParamName("lang");
        registry.addInterceptor(langChangeInterceptor).addPathPatterns("/**");
        
        // 程式權限偵測
        SecurityInterceptor securityInterceptor = new SecurityInterceptor();
        registry.addInterceptor(securityInterceptor).addPathPatterns("/auth/**").excludePathPatterns("/auth/home");
        
    }
    
    /**
     *  
     *	  加入 spring-security-taglibs 對 FreeMarker 的支援
     */
    @PostConstruct    
    public void freeMarkerConfigurer() {
        List<String> tlds = new ArrayList<String>();
        tlds.add("/static/tags/security.tld");
        tlds.add("/static/tags/polinwei.tld");
        TaglibFactory taglibFactory = freeMarkerConfigurer.getTaglibFactory();
        taglibFactory.setClasspathTlds(tlds);
        if(taglibFactory.getObjectWrapper() == null) {
            taglibFactory.setObjectWrapper(freeMarkerConfigurer.getConfiguration().getObjectWrapper());
        }
    }

}
