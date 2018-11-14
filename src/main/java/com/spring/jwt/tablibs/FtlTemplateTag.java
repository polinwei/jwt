package com.spring.jwt.tablibs;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import freemarker.ext.jsp.TaglibFactory;
import freemarker.template.Configuration;
import freemarker.template.Template;

public class FtlTemplateTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	
	private String fileName = null;
    private String paramsStr = null;
    private String columnsStr = null;
    private ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
    
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}	   
	public void setParamsStr(String paramsStr) {
		this.paramsStr = paramsStr;
	}
	public void setColumnsStr(String columnsStr) {
		this.columnsStr = columnsStr;
	}
	/**
	 * JSON 字串轉換成 MAP
	 * @return
	 */
	private Map<String, String> setParams() {
		Gson gson = new Gson();
		return gson.fromJson(paramsStr, new TypeToken<Map<String, String>>() {
		}.getType());
	}
	
	private Map<String , String> setColumns(){
		Locale locale = LocaleContextHolder.getLocale();
		
		messageSource.setBasenames("i18n/messages");
		
		Gson gson = new Gson();
		Map<String , String> columns = gson.fromJson(columnsStr, new TypeToken<Map<String, String>>() {}.getType() );
		
		//轉換多語系
		Map<String , String> dataModel = new LinkedHashMap<String, String>();
		columns.forEach( (k,v)-> dataModel.put(k, messageSource.getMessage(v, null, v, locale)) );
			
		return dataModel;
	}
	
	
	@Override
	public int doStartTag() throws JspException {
		JspWriter out = pageContext.getOut();
		
		Configuration conf = new Configuration();
		conf.setClassForTemplateLoading(this.getClass(), "/templates/");
		conf.setDefaultEncoding("UTF-8");
		
		try {
			Template  tl = conf.getTemplate(fileName);
			Map<String , Object> dataModel = new HashMap<String, Object>();
			dataModel.putAll(this.setParams());
			dataModel.put("columns", this.setColumns());
			

			tl.process(dataModel, out);
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return Tag.SKIP_BODY;
	}
    
	
}
