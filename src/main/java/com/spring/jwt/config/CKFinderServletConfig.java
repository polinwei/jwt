package com.spring.jwt.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.ckfinder.connector.ConnectorServlet;

@Configuration
public class CKFinderServletConfig extends ConnectorServlet {

    @Value("${ckeditor.storage.image.path}")
    private String baseDir;
    // @Value("${ckeditor.access.image.url}")
    //private String baseURL;

    @Bean
    public ServletRegistrationBean connectCKFinder(){
        ServletRegistrationBean registrationBean=new ServletRegistrationBean(new ConnectorServlet(),"/AdminLTE2/bower_components/ckfinder/core/connector/java/connector.java");
        registrationBean.addInitParameter("XMLConfig","classpath:ckfinder-config.xml");
        registrationBean.addInitParameter("debug","false");
        registrationBean.addInitParameter("configuration","com.spring.jwt.config.CKFinderConfig");
        //初始化ckfinder.xml 配置
        registrationBean.addInitParameter("baseDir",baseDir);
        //registrationBean.addInitParameter("baseURL",baseURL);
        return registrationBean;
    }
}
