package com.spring.jwt.controller.demo;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/demo")
public class DemoController {

	@GetMapping("jwt/LoginDemo")
	public String jwtLoginDemo(Model model) {
		
		return "demo/jwtLoginDemo";
	}
	
	@GetMapping("freemarker/hello")
	public String hiFreemarker(Model model) {
		model.addAttribute("time", new Date());
        model.addAttribute("message", "Hello Freemarker");
        return "demo/hiFreemarker";
	}
	
	@GetMapping("fileUpload/ajax")
	public String ajaxFileUpload(Model model) {
		
        return "demo/uploadDemo";
	}
	
}
