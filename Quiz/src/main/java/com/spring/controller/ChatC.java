package com.spring.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatC {
	
	@RequestMapping (value="/chat-template")
	public String chatTemplate (HttpSession session, Model model) {
		return "chat";
	}
}
