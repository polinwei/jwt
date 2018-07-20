package com.spring.jwt.controller.demo;

import java.time.LocalDateTime;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller

public class VueController {

    /**
     * vue js Test
     */
	@GetMapping("/demo/vue")
    public String getTimeToVueDemoPage(Model model) {
    	model.addAttribute("dateTime", LocalDateTime.now());
    	return "/demo/vueDemo";
    }
}
