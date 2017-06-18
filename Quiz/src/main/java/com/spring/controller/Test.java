package com.spring.controller;

import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Test {
	
	@RequestMapping(value = "/test")
	public String test(Model m,HttpServletRequest h) throws UnknownHostException {
		return "t1";
	}
}
