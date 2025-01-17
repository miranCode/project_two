package org.zerock.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@GetMapping(value = {"/", "/home"})
	public String home(Locale locale, Model model) {
		return "home";
	}
	
	@GetMapping(value = "/info")
	public String info(Locale locale, Model model) {
		return "html/info";
	}
}
