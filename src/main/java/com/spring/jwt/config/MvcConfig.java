package com.spring.jwt.config;

import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/demo/bank").setViewName("demo/accountsPage");
        registry.addViewController("/demo/vue").setViewName("demo/vueDemo");
        registry.addViewController("/home").setViewName("home");
        registry.addViewController("/").setViewName("home");
        registry.addViewController("/home/auth").setViewName("home-auth");
        registry.addViewController("/hello").setViewName("hello");
        registry.addViewController("/login").setViewName("login");
    }
    
    //多語系設定
    @Bean(name = "localeResolver")
    public LocaleResolver getLocaleResolver()  {
        CookieLocaleResolver resolver= new CookieLocaleResolver();   
        resolver.setDefaultLocale(Locale.US);
        resolver.setCookieDomain("jwtLocaleCookie");
        // 60 minutes 
        resolver.setCookieMaxAge(60*60); 
        return resolver;
    } 
    //多語系設定 語系切換偵測
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        LocaleChangeInterceptor localeInterceptor = new LocaleChangeInterceptor();
        localeInterceptor.setParamName("lang");
                  
        registry.addInterceptor(localeInterceptor).addPathPatterns("/*");
    }

}
