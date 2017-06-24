package com.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.domain.Account;
import com.spring.service.AccountS;
import com.spring.service.PostS;
import com.spring.service.RoomS;

@Controller
public class HomeC {
	@Autowired
	RoomS rooms;
	@Autowired
	AccountS accountS;
	@Autowired
	PostS postS;

	@RequestMapping(value = "/home")
	public String homePage(HttpSession session, Model model) {
		Account account = (Account) session.getAttribute("account");
		if (account == null) {
			return "redirect:/";
		} else {
			Account accountInfo = accountS.getAccountByID(account.getIdAcc());
			if (accountInfo.getName() == null || accountInfo.getName().equals("")) {
				return "redirect:/account/info";
			}
		}
		model.addAttribute("listRoomManager", rooms.getListRoomManager(account.getIdAcc()));
		model.addAttribute("listRoomParticipation", rooms.getListRoomParticipation(account.getIdAcc()));
		model.addAttribute("newPost", postS.getPostOfUser(account.getIdAcc()));
		return "homepage";

	}
}
