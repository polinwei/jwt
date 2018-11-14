package com.spring.jwt.tablibs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.Data;


@Data
public class FtlDataTableTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	
	private String fileName = "";
	private String tableId  = "";
    private String ajaxUrl  = "";
    private String columnsStr = "";
    private String paramsStr = "";
    private ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
    private Locale locale = LocaleContextHolder.getLocale();
    
    public FtlDataTableTag() {
    	init();
    }
    
    private void init() {		
		messageSource.setBasenames("i18n/messages");
    }
    
	/**
	 * JSON 字串轉換成 MAP
	 * @return
	 */
	private Map<String, Object> setParams() {
		Gson gson = new Gson();
		Map<String, Object> params = gson.fromJson(paramsStr, new TypeToken<Map<String, Object>>() {}.getType());
		params.forEach((k,v)->{
			if (k.equals("isAjaxOptions") && v.equals(true)) {
				params.put("ajaxOptions", messageSource.getMessage("label.ajaxOptions", null, "ajaxOptions", locale));
			}
		});
		
		return params;
	}
	
	private List<LinkedHashMap<String , String>> setColumns(){
		Gson gson = new Gson();
		List<LinkedHashMap<String , String>> columns = gson.fromJson(columnsStr, new TypeToken< List<LinkedHashMap<String , String>> >() {}.getType() );
		
		//轉換多語系, LinkedHashMap 欄位順序才不會亂
		List<LinkedHashMap<String , String>> dataModel = new ArrayList<LinkedHashMap<String, String>>();		
		
		columns.stream().forEach( (column)->{
			LinkedHashMap<String , String> model = new LinkedHashMap<String, String>();
			(column).forEach((k,v)->{				
				if (k.equals("th")) {
					model.put(k, messageSource.getMessage(v, null, v, locale)) ;
				} else {
					model.put(k,v);
				}				
			});
			dataModel.add(model);			
		});
			
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
			Map<String,Object> progPermits = new HashMap<>();
			progPermits.putAll( (Map<String,Object>)pageContext.getRequest().getAttribute("progPermits"));
			
			Map<String , Object> dataModel = new HashMap<String, Object>();
			dataModel.put("progPermits", progPermits);
			dataModel.put("tableId", tableId);
			dataModel.put("ajaxUrl", ajaxUrl);
			dataModel.put("columns", this.setColumns());
			if (!paramsStr.isEmpty()) {
				dataModel.putAll(this.setParams());
			}
			tl.process(dataModel, out);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return Tag.SKIP_BODY;
	}
    
}
