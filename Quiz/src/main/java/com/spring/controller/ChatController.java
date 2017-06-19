package com.spring.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nlu.model.ChatDao;
import com.nlu.model.MailBoxDao;
import com.nlu.model.MemberDao;
import com.nlu.model.Message;
import com.nlu.model.OutputMessage;
import com.spring.domain.Account;
import com.spring.repository.ChatRepository;
import com.spring.service.AccountS;
import com.spring.service.ChatService;
import com.spring.service.RoomS;

@Controller
public class ChatController {
	@Autowired
	private SimpMessagingTemplate template;
	@Autowired
	ChatService chatService;
	@Autowired
	ChatRepository chatRepository;
	@Autowired
	RoomS roomService;
	@Autowired
	AccountS acccountS;

	@RequestMapping(value = "/chat")
	public String index(Model model) {
		model.addAttribute("model", chatRepository.findAll());
		return "chat/index";
	}

	// magv là ma gv dc phan cong
	@RequestMapping(value = "/thong-bao-phan-cong", method = RequestMethod.POST)
	public @ResponseBody boolean thongBaoPhanCong(int magv, String msg, HttpServletRequest request) {

		System.err.println("ma giảng viên" + magv + " tin nhan" + msg);

		this.template.convertAndSend("/topic/messages", new OutputMessage("uu" + "", magv + "", "Server Notifile"));
		return true;

	}

	@MessageMapping("/chat/{topic}")
	@SendTo("/topic/messages")
	public OutputMessage send(@DestinationVariable("topic") String topic, Message message) throws Exception {
		if ("notification".equals(topic)) {
			int idRoom = Integer.parseInt(message.getText());
			int idAcc = Integer.parseInt(message.getFrom());
			OutputMessage res = new OutputMessage(message.getFrom(), message.getText(), topic);
			int[] listIdAcc = roomService.getListIDAccountInRoom(idRoom);
			Account account = acccountS.getAccountByID(idAcc);
			String messageContent = account.getName() + " vừa đăng một bài viết mới trong nhóm "
					+ roomService.getNameRoom(idRoom);
			String url = "/classRoom/" + idRoom + message.getLocation();
			//
			for (int i = 0; i < listIdAcc.length; i++) {
				if (idAcc == listIdAcc[i]) {
					listIdAcc[i] = -1;
					break;
				}
			}
			for (int i : listIdAcc) {
				if (i != -1) {
					chatService.themNoiDung("POST_" + idAcc, i + "", messageContent, url);
				}
			}
			//
			res.setListIdAcc(listIdAcc);
			res.setMessageContent(messageContent);
			res.setUrl(url);
			return res;
		}
		return new OutputMessage(message.getFrom(), message.getText(), topic);
	}

	@RequestMapping(value = "/themnoidung", method = RequestMethod.POST)
	public @ResponseBody boolean themnoidung(String from, String to, String boby, String url) {
		System.out.println(from + " " + to + " " + boby + " " + url);
		try {
			return chatService.themNoiDung(from, to, boby, url);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
	}

	@RequestMapping(value = "/danhsachchat", method = RequestMethod.GET)
	public @ResponseBody List<MemberDao> danhsachchat(int magv) {
		try {
			return chatService.danhSachChat(magv);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ArrayList<MemberDao>();
		}
	}

	@RequestMapping(value = "/chatpoint", method = RequestMethod.POST)
	public @ResponseBody List<ChatDao> chatPoint(@RequestParam(name = "top", defaultValue = "-1") int top, String from,
			String to) {
		try {
			return chatService.tinNhan(from, to, top);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ArrayList<ChatDao>();
		}
	}

	@RequestMapping(value = "/findMailBox", method = RequestMethod.POST)
	public @ResponseBody List<MailBoxDao> findMailBox(String userId) {
		try {
			return chatService.findMailBox(userId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return new ArrayList<MailBoxDao>();
		}
	}

	// thắng
	@RequestMapping(value = "/notification-demo")
	public String notificationDemo() {
		return "notification";
	}

	@RequestMapping(value = "/load-notify", method = RequestMethod.POST)
	public String loadNotify(@RequestParam("from") int from, Model model) throws SQLException {
		List<ChatDao> chatDaos = chatService.loadNotify("POST_", from + "", 10);
		for (ChatDao chatDao : chatDaos) {
			chatDao.setUrlImg(
					acccountS.getAccountByID(Integer.parseInt(chatDao.getCode().replace("POST_", ""))).getAvatar());
		}
		model.addAttribute("chatDaos", chatDaos);
		return "notify/load_notify";

	}

}
