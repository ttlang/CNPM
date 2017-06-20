package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FriendRequestC {
	
	@RequestMapping(value="/friendrequest")
	public String pageFQ() {
		return "friendRequests";
	}
}
