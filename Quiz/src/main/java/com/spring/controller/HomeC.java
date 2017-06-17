package com.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.domain.Account;
import com.spring.service.RoomS;

@Controller
public class HomeC {
	@Autowired
	RoomS rooms;

	@RequestMapping(value = "/home")
	public String homePage(HttpSession session, Model model) {
		Account account = (Account) session.getAttribute("account");
		if (account == null) {
			return "redirect:/";
		}
		model.addAttribute("listRoomManager", rooms.getListRoomManager(account.getIdAcc()));
		model.addAttribute("listRoomParticipation", rooms.getListRoomParticipation(account.getIdAcc()));
		return "homepage";

	}
}
