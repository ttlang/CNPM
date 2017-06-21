package com.spring.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RoomTest {
	
	@RequestMapping (value="/roomtest")
	public String pageRoomTest() {
		return "roomtest";
	}
}
