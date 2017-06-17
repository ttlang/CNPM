package com.spring.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.domain.Account;
import com.spring.domain.Comment;
import com.spring.domain.Post;
import com.spring.domain.Room;
import com.spring.model.PostRoom;
import com.spring.service.AccountS;
import com.spring.service.PostS;
import com.spring.service.RoomS;

@Controller

public class RoomC {
	@Autowired
	RoomS rooms;
	@Autowired
	PostS postS;
	@Autowired
	AccountS accountS;

	@RequestMapping(value = "/createroom", method = RequestMethod.POST)
	@ResponseBody
	public String createRoom(WebRequest webrq, HttpSession session) {
		Account account = (Account) session.getAttribute("account");
		if (account != null) {
			String roomName = webrq.getParameter("name_room");
			return String.valueOf(rooms.createRoom(roomName, account.getIdAcc()));
		}
		return "false";
	}

	@RequestMapping(value = "/searchroom", method = RequestMethod.POST)
	@ResponseBody
	public String searchRoom(WebRequest webrq) {
		int idRoom;
		try {
			idRoom = Integer.parseInt(webrq.getParameter("id_room"));
		} catch (Exception e) {
			return "false";
		}
		return rooms.getNameRoom(idRoom);

	}

	// quản lý phòng học
	@RequestMapping(value = "/room/accountManager")
	public String accountManager() {

		return "acc_management";
	}

	// phòng học quản lý
	@RequestMapping(value = "/classRoom/{idRoom}", method = RequestMethod.GET)
	public String classRom(Model m, WebRequest wr, HttpSession session, @PathVariable("idRoom") String idRoom) {
		m.addAttribute("title", "phòng học");
		try {
			Account account = (Account) (session.getAttribute("account"));
			int roomID = Integer.parseInt(idRoom);
			// kiểm tra không có sesion
			if (account == null) {
				return "redirect:/";
			}
			// đối tượng phòng học
			Room r = rooms.getRoom(roomID);
			System.err.println(r);
			m.addAttribute("Room", r);
			// số lượng thành viên trong phòng
			m.addAttribute("numberOfAccount", rooms.getNumberOfMem(roomID));
			m.addAttribute("listMember", rooms.getMemberInRoom(roomID));
			List<PostRoom> list1 = rooms.getListPostRoom(roomID);
			// List<Post> list = rooms.getListPostInRoom(roomID);
			m.addAttribute("listPost", list1);
			return "classroom";
		} catch (NumberFormatException ex) {
			ex.printStackTrace();
		}
		return "classroom";

	}

	@RequestMapping(value = "/participationroom", method = RequestMethod.POST)
	@ResponseBody
	public String participationRoom(WebRequest webrq, HttpSession session) {
		int idRoom;
		try {
			idRoom = Integer.parseInt(webrq.getParameter("id_room"));
		} catch (Exception e) {
			return "false";
		}
		Account account = (Account) session.getAttribute("account");
		if (account != null) {
			// String roomName = webrq.getParameter("name_room");
			return String.valueOf(rooms.participationRoom(idRoom, account.getIdAcc()));
		}
		return "false";
	}

	@RequestMapping(value = "/addcomment", method = RequestMethod.POST)
	// @ResponseBody
	public String addComment(WebRequest webrq, HttpSession session, RedirectAttributes value) {
		int idPost = Integer.parseInt(webrq.getParameter("idpost"));
		String commentValue = webrq.getParameter("comment_value");
		Account account = (Account) session.getAttribute("account");
		rooms.addCommentIntoPost(commentValue, idPost, account.getIdAcc());
		List<Comment> comments = postS.getListCommentByIdPost(idPost);
		value.addFlashAttribute("commentList", comments);
		return "redirect:/subAddComment";
	}

	/**
	 * Trả về dữ liệu cho request addComment
	 * 
	 * @param model
	 * @param value
	 * @return dữ liệu là html
	 */
	@RequestMapping(value = "/subAddComment")
	public String subAddComment() {
		return "/post/addComment";
	}

	@RequestMapping(value = "/postStatusInRoom", method = RequestMethod.POST)
	// @ResponseBody
	public String postInRoom(WebRequest webrq, HttpSession session, RedirectAttributes value) {
		int idRoom = Integer.parseInt(webrq.getParameter("id_room"));
		String contentPost = webrq.getParameter("content_post");
		Account account = (Account) session.getAttribute("account");
		/* mã bài viết vừa thêm vào */
		int idPost = rooms.addPostAfterIntoRoom(contentPost, idRoom, 1, account.getIdAcc());
		System.out.println(contentPost);
		if (idPost != -1) {
			/* Lấy bài viết từ mã bài viết mơi stheem */
			Post post = postS.getPostById(idPost);
			value.addFlashAttribute("post", post);
		}

		return "redirect:/subPostStatusInRoom"; // chịu :\ dc r chu
	}

	// dc cai j ?del cmt h viêt procedure xóa post vs comment mới làm trên giao
	// điện
	/**
	 * trả về dữ liệu cho postInRooom
	 * 
	 * @param post
	 * @return html cho khung post
	 */
	@RequestMapping(value = "/subPostStatusInRoom")
	public String subPostInRoom() {
		return "/post/addStatusPost";
	}

	@RequestMapping(value = "/postQuizInRoom", method = RequestMethod.POST)
	public String postQuizInRoom(WebRequest wr, HttpSession httpSession) {
		String noiDung = wr.getParameter("nd");
		String dap1 = wr.getParameter("da1");
		String dap2 = wr.getParameter("da2");
		String dap3 = wr.getParameter("da3");
		String dap4 = wr.getParameter("da4");
		int daDung = Integer.parseInt(wr.getParameter("daDung"));
		int idRoom = Integer.parseInt(wr.getParameter("id_room"));
		Account account = (Account) httpSession.getAttribute("account");
		int idPost = rooms.addPostQuizIntoRoom(idRoom, account.getIdAcc(), noiDung, dap1, dap2, dap3, dap4, daDung);
		System.out.println(idPost + " Thanfh cong mej no cong");
		return "/post/addQuizPost";
	}

	@RequestMapping(value = "/postFileInRoom", method = RequestMethod.POST)
	public String postFileInRoom() {
		return "/post/addFilePost";
	}

	@RequestMapping(value = "/adminroom", method = RequestMethod.GET)
	public String adminRoomPage(HttpSession session, Model m, WebRequest wr) {
		try {
			int roomID = Integer.parseInt(wr.getParameter("idRoom"));
			Account account = (Account) session.getAttribute("account");
			if (account == null) {
				return "redirect:/";
			} else if (!accountS.checkIsAdmin(account.getIdAcc(), roomID)) {
				return "redirect:/home";
			} else {
				// đối tượng phòng học
				Room r = rooms.getRoom(roomID);
				m.addAttribute("Room", r);
				// số lượng thành viên trong phòng
				m.addAttribute("numberOfAccount", rooms.getNumberOfMem(roomID));
				m.addAttribute("listMember", rooms.getMemberInRoom(roomID));
				// danh sách tài khoản tham gia phòng
				m.addAttribute("members", rooms.getListRoomanageByIDRoomAndState(roomID, true));
				// danh sách thành viên chờ duyệt
				m.addAttribute("watting", rooms.getListRoomanageByIDRoomAndState(roomID, false));
				return "acc_management";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "acc_management";
	}

	@RequestMapping(value = "/deleteMember", method = RequestMethod.GET)
	@ResponseBody
	public String deleteMeber(WebRequest wr) {
		String idMember = wr.getParameter("merberID");
		String idRoom = wr.getParameter("IDroom");
		int result = rooms.deleteMember(Integer.parseInt(idMember), Integer.parseInt(idRoom));
		return String.valueOf(result);
	}

	@RequestMapping(value = "/addMem")
	@ResponseBody
	public String addMem(WebRequest wr) {
		String idMember = wr.getParameter("merberID");
		String idRoom = wr.getParameter("IDroom");
		int result = rooms.setStateForMember(Integer.parseInt(idMember), Integer.parseInt(idRoom), true);
		return String.valueOf(result);
	}

	@RequestMapping(value = "/getHtmlFormPost", method = RequestMethod.POST)
	public String getHtmlFormPost(WebRequest wr) {
		try {
			int typePost = Integer.parseInt(wr.getParameter("type"));
			switch (typePost) {
			case 1:
				return "redirect:/formStatus";
			case 2:
				return "redirect:/formQuiz";
			case 3:
				return "redirect:/formFile";
			default:
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	/**
	 * sub method getHtmlFormPost type formStatus
	 * 
	 * @return form html
	 */
	@RequestMapping(value = "/formStatus")
	public String getHtmlFormStatus() {
		return "/post/statusPost";
	}

	/**
	 * sub method getHtmlFormPost type formQuiz
	 * 
	 * @return form html
	 */
	@RequestMapping(value = "/formQuiz")
	public String getHtmlFormQuiz() {
		return "/post/quizPost";
	}

	/**
	 * sub method getHtmlFormPost type formFile
	 * 
	 * @return form html
	 */
	@RequestMapping(value = "/formFile")
	public String getHtmlFormHtml() {
		return "/post/filePost";
	}

	@RequestMapping(value = "/likeOrUnlikePost", method = RequestMethod.POST)
	@ResponseBody
	public String likePost(WebRequest wr, HttpSession httpSession) {
		try {
			int idPost = Integer.parseInt(wr.getParameter("id_post"));
			Account account = (Account) httpSession.getAttribute("account");
			boolean isSuccess = postS.likePostFromAccount(idPost, account.getIdAcc());
			// System.out.println("Like success " + isSuccess);
			if (isSuccess) {
				return "true";
			}
			return null;
		} catch (Exception e) {
			return null;
		}
	}

	// test get category post
	@RequestMapping(value = "/newclassroom", method = RequestMethod.GET)
	public String newClassRoom() {
		return "newclassroom";
	}

	/**
	 * Lấy danh sách những người liked bài viết
	 * 
	 * @return mã html từ trang listAccountLike.html
	 */
	@RequestMapping(value = "/listAccountLike", method = RequestMethod.POST)
	public String listAccountLike(WebRequest wr, RedirectAttributes value) {
		try {
			int idPost = Integer.parseInt(wr.getParameter("id_post"));
			List<Account> listAccountLike = postS.getListAccountLike(idPost);
			value.addFlashAttribute("accounts", listAccountLike);
			return "redirect:/subGetListAccountLike";
		} catch (Exception e) {
			return "/post/listAccountLiked";
		}
	}

	@RequestMapping(value = "/subGetListAccountLike")
	public String subGetListAccountLike() {
		return "/post/listAccountLiked";
	}

	@PostMapping("/deleteRoom")
	@ResponseBody
	public String deleteRoom(@RequestParam("id_room") int idRoom) {
		String mes = rooms.deleteRoom(idRoom);
		return mes;
	}
}
