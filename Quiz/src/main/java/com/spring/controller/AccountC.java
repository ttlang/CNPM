package com.spring.controller;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.request.WebRequest;

import com.spring.domain.Account;
import com.spring.domain.Relationship;
import com.spring.service.AES;
import com.spring.service.AccountS;
import com.spring.service.Mail;

import it.ozimov.springboot.mail.service.exception.CannotSendEmailException;

@RequestMapping("/account")
@SessionAttributes("account")
@Controller
public class AccountC {
	@Autowired
	private AccountS accountService;
	@Autowired
	private Mail mail;
	@Autowired
	private AES aes;

	// Đăng nhập
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPage(Model model, WebRequest wr, HttpSession session) {
		String email = wr.getParameter("email");
		String password = wr.getParameter("password");
		String message = accountService.checkLogin(email, password);
		model.addAttribute("email", email);
		if (NumberUtils.isNumber(message)) {
			Integer accountID = Integer.parseInt(message);
			Account account = accountService.getAccountByID(accountID);
			model.addAttribute("account", account);
			session.setAttribute("account", account);
			return "redirect:/home";
		} else {
			model.addAttribute("email", email);
			model.addAttribute("err", message);
			return "login_page";
		}

	}

	// Quên mật khẩu
	@RequestMapping(value = "/forgot_pass", method = RequestMethod.GET)
	public String forgotPassPage(Model model, WebRequest wr, HttpServletRequest h)
			throws AddressException, UnsupportedEncodingException, CannotSendEmailException {
		String email = wr.getParameter("email");
		if (email == null || email.isEmpty()) {
			return "forgot_password";
		}
		if (!accountService.checkEmail(email)) {
			model.addAttribute("err", "email không tồn tại trong hệ thống");
			return "forgot_password";
		} else {
			String accountID = String.valueOf(accountService.getAccountByEmail(email).getIdAcc());
			String decryptString = aes.encrypt(accountID);
			Collection<InternetAddress> to = new ArrayList<>();
			to.add(new InternetAddress(email));
			String a = h.getScheme() + "://" + h.getServerName() + ":" + h.getServerPort() + "/account/change_pass?id="
					+ decryptString;
			Map<String, Object> map = new HashMap<>();
			map.put("mail", email);
			map.put("link", a);
			mail.sendMail(to, "Đổi mật khẩu", "change_pass_mail.html", map);
			model.addAttribute("suscess", "Mail đổi mật khẩu đã gửi đến tài khoản của bạn");
			return "forgot_password";
		}
	}

	// hiển thị trang đổi mật khẩu
	@RequestMapping(value = "/change_pass", method = RequestMethod.GET)
	public String changePasswordPage(HttpSession session, WebRequest wr) {
		String idAccount = wr.getParameter("id");
		if (idAccount != null) {
			session.setAttribute("idAccount", idAccount);
		} else {
			return "redirect:/404";
		}
		return "change_password";
	}

	// action cho đổi mật khẩu
	@RequestMapping(value = "/doChangePassword", method = RequestMethod.POST)
	public String dochangePass(Model m, WebRequest wr, HttpSession session) {
		String password = wr.getParameter("pass");
		String idAccount = (String) session.getAttribute("idAccount");
		try {
			// giải mã Mã người dùng
			int idAccountDeCrypt = Integer.valueOf(aes.decrypt(idAccount));
			System.err.println(idAccountDeCrypt + "lang");
			accountService.changePassword(idAccountDeCrypt, password);
			m.addAttribute("success", "Đổi mật khẩu thành công");
			return "change_password";
		} catch (Exception e) {
			return "redirect:/404";

		}
	}

	// Đăng kí tài khoản
	@RequestMapping(value = "/sign_up")
	public String signUp(Model model, WebRequest wr, HttpServletRequest h)
			throws AddressException, UnsupportedEncodingException, CannotSendEmailException {
		String email = wr.getParameter("email");
		String password = wr.getParameter("password");
		String rePassword = wr.getParameter("repassword");
		if (email == null && password == null && rePassword == null) {
			return "sign_up";
		} else if (accountService.checkEmail(email)) {
			model.addAttribute("err", "email đã tồn tại trong hệ thống");
			model.addAttribute("email", email);
			return "sign_up";
		} else if (!rePassword.equals(password)) {
			model.addAttribute("err", "mật khẩu nhập lại không đúng");
			model.addAttribute("email", email);
			return "sign_up";
		} else {
			int accountID = accountService.SignUp(email, password);
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			String date = df.format(new Date());
			// Mã hóa ngày đăng kí và mã người dùng
			String decryptString = aes.encrypt(date + "|" + accountID);
			// Địa chỉ email người nhận
			Collection<InternetAddress> to = new ArrayList<>();

			to.add(new InternetAddress(email));
			String a = h.getScheme() + "://" + h.getServerName() + ":" + h.getServerPort() + "/account/register?id="
					+ decryptString;
			Map<String, Object> map = new HashMap<>();
			map.put("link", a);
			mail.sendMail(to, "Kích hoạt tài khoản", "register_mail.html", map);
			model.addAttribute("suscess", "chúc mừng bạn đã đăng kí thành công  hãy vào mail để kích hoạt");
			return "sign_up";
		}
	}

	// xác thực đăng ký
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String registerAccount(Model m, WebRequest wr) {
		String encryptString = wr.getParameter("id");
		System.out.println(encryptString);
		String decryptString = null;
		try {
			decryptString = aes.decrypt(encryptString);
			StringTokenizer st = new StringTokenizer(decryptString, "|");
			System.out.println(st.countTokens());
			if (st.countTokens() != 2) {
				System.out.println("loi");
				return "redirect:/404";
			} else {
				String dateRegister = st.nextToken();
				String idAccount = st.nextToken();
				accountService.enableAccount(Integer.parseInt(idAccount), true);
				m.addAttribute("sucess", "kích hoạt thành công");
				m.addAttribute("dateRegister", dateRegister);
				return "register_page";
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:/404";
		}

	}

	// Kiểm tra email có tồn tại trong hệ thống hay không
	@ResponseBody
	@RequestMapping(value = "/check_email", method = RequestMethod.GET)
	public String checkEmailSignUp(WebRequest wr) {
		String email = wr.getParameter("email");
		boolean checkEmail = accountService.checkEmail(email);
		return (checkEmail) ? "email đã tồn tại trong hệ thống" : "";
	}

	// Đăng xuất
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "login_page";
	}

	// trang thông tin người dùng
	@RequestMapping(value = "/info")
	public String accountInfo(Model m, HttpSession session) {
		Account account = (Account) session.getAttribute("account");
		if (account == null) {
			return "redirect:/";
		}
		m.addAttribute("acc_setting", accountService.getAccountByID(account.getIdAcc()));
		m.addAttribute("title", "Thông tin tài khoản");
		return "account_setting";
	}

	@RequestMapping(value = "/viewinfo/acc{idAcc}")
	public String accountInfomation(@PathVariable("idAcc") int idAcc, Model m, HttpSession session) {
		Account account = (Account) session.getAttribute("account");
		if (account == null) {
			return "redirect:/";
		}
		Account accountView = accountService.getAccountByID(idAcc);
		m.addAttribute("accountView", accountView);
		return "account_info";
	}

	// cập nhật thông tin người dùng
	@GetMapping("/update/info")
	@ResponseBody
	public String updateInfo(WebRequest w, HttpSession session) throws ParseException {
		String name = w.getParameter("name");
		boolean gender;
		if (w.getParameter("gender") == null) {
			gender = false;
		} else {
			gender = (w.getParameter("gender").equals("1")) ? true : false;
		}

		String job = w.getParameter("job");
		String address = w.getParameter("address");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date date2 = formatter.parse(w.getParameter("birth"));
		Account account = (Account) session.getAttribute("account");
		// int idAccount = account.getIdAcc();
		if (accountService.updateAccountInfo(name, date2, job, gender, address, account.getIdAcc())) {
			session.setAttribute("account", accountService.getAccountByID(account.getIdAcc()));

			Account account2 = (Account) session.getAttribute("account");

			System.err.println(account2.getName());
			return "Cập nhật thành công";
		} else {
			return "Cập nhật thất bại";
		}
	}
	// lấy mật khẩu người dùng

	@PostMapping(value = "/getUserPassword")
	@ResponseBody
	public String getUserPassword(HttpSession session) {
		Account account = (Account) session.getAttribute("account");
		return account.getPassword();

	}

	@RequestMapping(value = "/profilemember", method = RequestMethod.POST)
	public String profileMember(WebRequest w, Model m, HttpSession session) {
		int idFriend = Integer.parseInt(w.getParameter("idAccount"));
		Account accAdd = accountService
				.getAccountByID(((Account) session.getAttribute("account")).getIdAcc().intValue());
		System.out.println("profile member " + idFriend);
		Account accFriend = accountService.getAccountByID(idFriend);

		// check friend ngay đây
		// select * from [relationship] where id_add = 1 and id_friend=3 and
		// waiting = 0
		// chạy câu lệnh này, nếu > 0 thì true else false, idAdd là acc
		// session,
		// còn idFriend là cái mình get từ cái bấm nút
		m.addAttribute("trangThai", statusFriend(accAdd.getIdAcc().intValue(), idFriend));
		m.addAttribute("profileMem", accFriend);
		return "info-user/info-user";
	}

	/**
	 * 0 không là gì của nhau \n 1 đã gửi lời mời kết bạn \n 2 đã kết bạn \n 3
	 * chấp nhận yêu cầu kết bạn \n 4 hai người là 1
	 * 
	 * @param idAdd
	 * @param idFriend
	 * @return
	 */
	private int statusFriend(int idAdd, int idFriend) {
		int trangThai = 0;// chưa có gì cả 2 người
		Account myAcc = accountService.getAccountByID(idAdd);
		Account acc = accountService.getAccountByID(idFriend);
		if (idFriend == myAcc.getIdAcc().intValue()) {
			trangThai = 4;// chính nó
		} else {
			System.out.println(myAcc.getRelationshipList());
			for (Relationship relationship : myAcc.getRelationshipList()) {
				if (relationship.getAccountFriend().getIdAcc().intValue() == idFriend) {
					if (relationship.getWaiting()) {
						trangThai = 1; // Da gui loi moi kết bạn
					} else {
						trangThai = 2;// đã kết bạn
					}
					break;
				}
			}
			// kiểm tra xem người này có gửi lời mời kết bạn với mình không
			// "Chấp
			// nhận kết bạn
			for (Relationship relationship : acc.getRelationshipList()) {
				if (relationship.getAccountFriend().getIdAcc().intValue() == myAcc.getIdAcc().intValue()) {
					if (relationship.getWaiting()) {
						trangThai = 3;// chờ yêu cầu chấp nhận kết bạn
						break;
					}
				}
			}
		}
		return trangThai;
	}

	// xử lý nút kết bạn, code mã giả
	@RequestMapping(value = "/addFriend", method = RequestMethod.POST)
	@ResponseBody
	public String addFriend(WebRequest w, Model m, HttpSession session) throws SQLException {
		int idFriend = Integer.parseInt(w.getParameter("idFriend"));
		Account accAdd = (Account) session.getAttribute("account");
		System.out.println("add Friend:  " + idFriend);
		switch (statusFriend(accAdd.getIdAcc().intValue(), idFriend)) {
		case 0:
			accountService.sendRequestAddFriend(accAdd.getIdAcc().intValue(), idFriend);
			return "Đã gửi lời mời kết bạn";
		case 1:
			accountService.deleteRequestAddFriend(accAdd.getIdAcc().intValue(), idFriend);
			return "Kết bạn";
		case 2:
			accountService.deleteRelationship(accAdd.getIdAcc().intValue(), idFriend);
			return "Kết bạn";
		default: // 3
			accountService.acceptRequestAddFriend(accAdd.getIdAcc().intValue(), idFriend);
			return "Hủy kết bạn";
		}
	}

	// dánh sách bạn của account
	@RequestMapping(value = "/friend-list", method = RequestMethod.GET)
	public String friendList(HttpSession session, Model model) {
		Account account = (Account) session.getAttribute("account");
		List<Relationship> accounts = (List<Relationship>) accountService.getAccountByID(account.getIdAcc().intValue())
				.getRelationshipList();
		model.addAttribute("listRelationship", accounts);
		return "friend";
	}

	@RequestMapping(value = "/friend-request", method = RequestMethod.GET)
	public String friendRequest(HttpSession session, Model model) {
		Account account = (Account) session.getAttribute("account");
		List<Relationship> accounts = (List<Relationship>) accountService.getAccountByID(account.getIdAcc().intValue())
				.getRelationshipList1();
		model.addAttribute("listRelationship", accounts);
		return "friendRequests";
	}

	// lấy danh sách bạn bè của một tài khoản nhận vào mã tài khoản người dùng

	@RequestMapping(value = "/get_friend_list", method = RequestMethod.POST)
	@ResponseBody
	public List<com.spring.model.Account> getListFriend(@RequestParam("id_acc") int idAcc) {

		List<Relationship> listFriend = (List<Relationship>) accountService.getAccountByID(idAcc).getRelationshipList();
		List<com.spring.model.Account> result = new ArrayList<>();
		for (Relationship relationship : listFriend) {
			if (!relationship.getWaiting()) {
				result.add(new com.spring.model.Account(relationship.getAccountFriend().getIdAcc(),
						relationship.getAccountFriend().getEmail(), relationship.getAccountFriend().getName(),
						relationship.getAccountFriend().getAvatar(), relationship.getAccountFriend().getJob(),
						relationship.getAccountFriend().getGender(), relationship.getAccountFriend().getAddress()));
			}
		}

		return result;
	}

	// gửi lời mời kết bạn với một tài khoản khác IDACC
	@RequestMapping(value = "/friend-request-new", method = RequestMethod.POST)
	@ResponseBody
	public String friendRequestNew(HttpSession session, @RequestParam("id_acc") int idAcc) {
		Account account = (Account) session.getAttribute("account");

		if (account.getIdAcc() == idAcc) {
			// không thể tự kết bạn với mình
			return "0|Không thể kết bạn với chính mình";
		} else {
			int check = statusFriend(account.getIdAcc(), idAcc);
			switch (check) {
			case 0:
				try {

					accountService.sendRequestAddFriend(account.getIdAcc(), idAcc);
				} catch (Exception e) {
					e.printStackTrace();
					return "0|Gửi lời mời kết bạn thất bại";

				}
				break;
			case 1:
				return "1|Bạn đã gửi lời mời kết bạn";
			case 2:
				return "1|Các bạn đã là bạn bè";
			case 3:
				return "1|Bạn đã gửi lời mời kết bạn";

			default:
				return "0|Gửi lời mời kết bạn thất bại";
			}

		}

		return "1|Gửi lời mời kết bạn thành công";

	}

}
