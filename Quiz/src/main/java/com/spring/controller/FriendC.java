package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FriendC {

	@RequestMapping(value="/friend")
	public String pageFriend() {
		return "friend";
	}
}
