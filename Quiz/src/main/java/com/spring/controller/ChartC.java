package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ChartC {
	@GetMapping(value = "/chart")
	public String chart() {
		return "chart_answer";
	}

}