package com.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.spring.domain.Account;
import com.spring.service.PostS;

@Controller
public class PostC {
	@Autowired
	PostS postS;

	@RequestMapping(value = "/deletepost", method = RequestMethod.POST)
	@ResponseBody
	public String deletePost(WebRequest webrq, HttpSession session) {
		try {
			int idPost = Integer.parseInt(webrq.getParameter("id_post"));
			// System.out.println(idPost+"ádasdasdasdsa");
			Account account = (Account) session.getAttribute("account");
			return postS.deletePost(idPost, account.getIdAcc()) ? "true" : "";
		} catch (Exception e) {
			return "";
		}
	}

}
