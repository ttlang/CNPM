package com.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.spring.domain.Account;
import com.spring.service.CommnentS;

@Controller
public class CommentC {
	@Autowired
	CommnentS commentS;

	@RequestMapping(value = "/deletecomment", method = RequestMethod.POST)
	@ResponseBody
	public String deleteComment(WebRequest webrq, HttpSession session) {
		try {
			int idComment = Integer.parseInt(webrq.getParameter("id_comment"));
			Account account = (Account) session.getAttribute("account");
			return commentS.deleteComment(idComment, account.getIdAcc()) ? "true" : "";
		} catch (Exception e) {
			return "";
		}

	}
}
