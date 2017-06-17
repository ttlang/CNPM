package com.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Index {
	@RequestMapping("/")
	public String index(HttpSession session ,Model model){
		  if(session.getAttribute("account")!=null){
			   return "redirect:/home";
		  }
		return "login_page";
	}
}
