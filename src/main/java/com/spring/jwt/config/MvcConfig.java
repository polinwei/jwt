package com.spring.jwt.config;

import java.util.Date;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;

import org.modelmapper.AbstractConverter;
import org.modelmapper.AbstractProvider;
import org.modelmapper.Converter;
import org.modelmapper.ModelMapper;
import org.modelmapper.Provider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.Formatter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
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
	}

	//多語系設定   
    @Bean(name = "localeResolver")
    public LocaleResolver getLocaleResolver()  {
        CookieLocaleResolver resolver= new CookieLocaleResolver();   
        //resolver.setDefaultLocale(Locale.US);
        resolver.setCookieHttpOnly(true);
        resolver.setCookieName("myLocaleCookie");
        resolver.setCookieMaxAge(60*60); 
        //resolver.setCookieSecure(true);
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
    
    /**
     * Mapping @RequestBody Map<String,Object> params to model class
     * @return
     */
    @Bean
    public ModelMapper modelMapper() {
    	ModelMapper modelMapper = new ModelMapper();
    	
        Provider<LocalDateTime> localDateTimeProvider = new AbstractProvider<LocalDateTime>() {
            @Override
            public LocalDateTime get() {
                return LocalDateTime.now();
            }
        };

        Converter<String, LocalDateTime> StringToLocalDateTime = new AbstractConverter<String, LocalDateTime>() {
            @Override
            protected LocalDateTime convert(String source) {
            	if (StringUtils.isEmpty(source))
            		return null;
            	
            	LocalDateTime localDateTime = null;
            	DateTimeFormatter format = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ssZ");
            	
                try {					
                	localDateTime = LocalDateTime.parse(source, format);
				} catch (Exception e) {
					try {
						format = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
						localDateTime = LocalDateTime.parse(source, format);
					} catch (Exception e1) {
						try {
							format = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss'Z'");
							localDateTime = LocalDateTime.parse(source, format);
						} catch (Exception e2) {
							// TODO Auto-generated catch block
							e2.printStackTrace();
						}
					}
					
				}                
                return localDateTime;
            }
        };
        modelMapper.createTypeMap(String.class, LocalDateTime.class) ;
        modelMapper.getTypeMap(String.class, LocalDateTime.class).setProvider(localDateTimeProvider);
        modelMapper.addConverter(StringToLocalDateTime);
        
        Provider<Date> DateProvider = new AbstractProvider<Date>() {
            @Override
            public Date get() {
                return new Date();
            }
        };
        Converter<String, Date> IsoStringToDate = new AbstractConverter<String, Date>() {
            @Override
            protected Date convert(String source) {
            	if (StringUtils.isEmpty(source))
            		return null;
            	
            	SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");                
            	Date date = null;
				try {
					date = inputFormat.parse(source);
				} catch (Exception e) {
					
					try {
						inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
						date = inputFormat.parse(source);
					} catch (Exception e1) {						
						try {
							inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
							date = inputFormat.parse(source);
						} catch (Exception e2) {
							try {
								inputFormat = new SimpleDateFormat("yyyy-MM-dd");
								date = inputFormat.parse(source);
							} catch (Exception e3) {
								// TODO Auto-generated catch block
								e3.printStackTrace();
							}
						}
					}
				}
                return date;
            }
        };                
        modelMapper.createTypeMap(String.class, Date.class);
        modelMapper.getTypeMap(String.class, Date.class).setProvider(DateProvider);
        modelMapper.addConverter(IsoStringToDate);
                
        return modelMapper;
    }

    /**
     * LocalDate as query parameter
     * @return
     */
    @Bean
    public Formatter<LocalDate> localDateFormatter() {
      return new Formatter<LocalDate>() {
        @Override
        public LocalDate parse(String text, Locale locale) throws ParseException {
          return LocalDate.parse(text, DateTimeFormatter.ISO_DATE);
        }
     
        @Override
        public String print(LocalDate object, Locale locale) {
          return DateTimeFormatter.ISO_DATE.format(object);
        }
      };
    }

}
