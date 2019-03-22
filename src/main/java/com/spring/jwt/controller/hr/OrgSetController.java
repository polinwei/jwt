package com.spring.jwt.controller.hr;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(path = "/auth/organization")
public class OrgSetController {

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@RequestMapping("OrgSet")
	public String crudOrgSet(Model model) {
		
		return "/auth/organization/OrgSet";
	}
	
	@RequestMapping("staff")
	public String crudStaff(Model model) {
		return "/auth/organization/staff";
	}
	
}
