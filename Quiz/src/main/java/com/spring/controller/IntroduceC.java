package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IntroduceC {
	
	@RequestMapping (value="/introduce")
	public String pageIntro() {
		return "introduce";
	}
}
