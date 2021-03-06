package com.spring.jwt.tablibs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.web.servlet.support.RequestContext;

import com.google.gson.Gson;
import com.google.gson.internal.LinkedTreeMap;
import com.google.gson.reflect.TypeToken;

import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.Data;


@Data
public class FtlDataTableTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	
	private String fileName = "";
	private String tableId  = "";
    private String dtAjaxUrl  = "";
    private String crudAjaxUrl  = "";
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
		Map<String, Object> params = gson.fromJson(paramsStr, new TypeToken<LinkedHashMap<String, Object>>() {}.getType());
		
		Map<String, Object> p = new HashMap<String, Object>();
		params.forEach((k,v)->{
			if (k.equals("isAjaxOptions") && v.equals(true)) {
				p.put("ajaxOptions", messageSource.getMessage("label.ajaxOptions", null, "ajaxOptions", locale));
				p.put(k, v);
			} else {
				p.put(k, v);
			}
		});
		
		return p;
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
	
	private Map<String, String> setFormInputs(){
		Gson gson = new Gson();
		List<Map<String , String>> columns = gson.fromJson(columnsStr, new TypeToken< List<LinkedHashMap<String , String>> >() {}.getType() );
		
		//轉換成 input 
		Map<String , String> formColumns = new LinkedHashMap<String, String>();	
		int i = 0;
		for (Map<String, String> column : columns) {
			String tagValue = "";
			boolean isHide = false;
			boolean isTextarea = false;
			String inputKey="";
			String inputLabel="";
			String inputValue="<";
			i++;
			
			tagValue = getMapValueByKey(column,"type");
			switch (tagValue) {
			case "textarea":
				inputKey = "textarea" + Integer.toString(i);
				inputValue += "textarea class=\"form-control\"  rows=\"5\" cols=\"80\" ";
				isTextarea = true;
				break;
			case "hidden":
				inputKey = "hidden" + Integer.toString(i);
				inputValue += "input type=\"hidden\" ";
				isHide = true;
				break;
			case "text":
				inputKey = "input" + Integer.toString(i);
				inputValue +="input type=\"text\" class=\"form-control\" ";
				break;
			}
			
			tagValue = getMapValueByKey(column,"data");
			inputValue += " name='" + tagValue + "' " ;
			inputValue += " id='" + tableId + tagValue + "' ";
			
			tagValue = getMapValueByKey(column,"th");
			if ( !isHide ) {
				inputLabel="<label for=";
				inputLabel += "\"" + tableId + getMapValueByKey(column,"data") + "\">" + messageSource.getMessage(tagValue, null, tagValue, locale);
				inputLabel += "</label>";
			}
			
			if (isTextarea) {
				inputValue += "></textarea>";
			} else {
				inputValue += " \\>";
			}
			
			formColumns.put(inputKey, inputLabel+inputValue);
		}
		
		
		return formColumns;
	}
	
	private String getMapValueByKey(Map<String , String> map, String mapKey) {
		String value = "";
		for( Entry<String, String> entry : map.entrySet()) {
			if (entry.getKey().equals(mapKey))
				value = entry.getValue();
		}
		return value;		
	}
	
	@Override
	public int doStartTag() throws JspException {
		JspWriter out = pageContext.getOut();
		HttpServletRequest request = (HttpServletRequest) pageContext.getRequest();
		
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
			dataModel.put("dtAjaxUrl", dtAjaxUrl);
			dataModel.put("crudAjaxUrl", crudAjaxUrl);
			dataModel.put("columns", this.setColumns());
			dataModel.put("formInputs", this.setFormInputs());
			
			if (!paramsStr.isEmpty()) {
				dataModel.putAll(this.setParams());
			}
			dataModel.put("springMacroRequestContext", new RequestContext(request) );
			tl.process(dataModel, out);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return Tag.SKIP_BODY;
	}
    
}
