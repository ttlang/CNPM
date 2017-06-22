package com.spring.controller;

import java.net.UnknownHostException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;

import com.spring.domain.Account;
import com.spring.service.TestService;

@Controller
public class Test {
	@Autowired
	TestService testService;

	@RequestMapping(value = "/test")
	public String test(Model m, HttpServletRequest h) throws UnknownHostException {
		return "t1";
	}

	@RequestMapping(value = "/answer-post-test", method = RequestMethod.POST)
	@ResponseBody
	public boolean answerPostTest(WebRequest wr, HttpSession session) {
		int idRoom = Integer.parseInt(wr.getParameter("id_room"));
		int idPost = Integer.parseInt(wr.getParameter("id_post"));
		int idDapAn = Integer.parseInt(wr.getParameter("id_dapan"));
		Account account = (Account) session.getAttribute("account");
		boolean isSuccess = testService.chooseAnswerInPostQuiz(idRoom, idPost, account.getIdAcc().intValue(), idDapAn);
		return isSuccess;
	}
}
