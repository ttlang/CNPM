package com.spring.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.domain.Account;
import com.spring.domain.Post;
import com.spring.service.AccountS;
import com.spring.service.PostS;

@Controller
public class ChartC {
	@Autowired
	private PostS postS;
	@Autowired
	private AccountS accountS;

	@RequestMapping(value = "/thong-ke-trac-nghiem", method = RequestMethod.POST)
	@ResponseBody
	public Map<Integer, Integer> thongKe(@RequestParam("idPost") int idPost) {
		Map<Integer, Integer> result = postS.thongKeTracNghiem(idPost);
		return result;
	}

	@RequestMapping(value = "/check-trac-nghiem", method = RequestMethod.POST)
	@ResponseBody
	public String checkQuiz(HttpSession session, @RequestParam("idPost") int idPost) {
		Map<Integer, Integer> nguoiChonTracNghiem = postS.nguoiChonTracNghiem(idPost);
		Account account = (Account) session.getAttribute("account");
		if (nguoiChonTracNghiem.containsKey(account.getIdAcc())) {
			return "1";
		}

		return "0";
	}

	@RequestMapping(value = "/nguoi-chon-trac-nghiem", method = RequestMethod.POST)
	@ResponseBody
	public List<com.spring.model.Account> nguoiChonTracNghiem(@RequestParam("idPost") int idPost) {
		List<com.spring.model.Account> listAccountResult = new ArrayList<>();
		Map<Integer, Integer> dsDapAn = postS.nguoiChonTracNghiem(idPost);
		for (Map.Entry<Integer, Integer> entry : dsDapAn.entrySet()) {
			Account account = accountS.getAccountByID(entry.getKey());
			com.spring.model.Account account2 = new com.spring.model.Account(entry.getKey(), account.getEmail(),
					account.getName(), account.getAvatar(), account.getJob(), account.getGender(), account.getAddress(),
					entry.getValue());
			listAccountResult.add(account2);

		}

		return listAccountResult;
	}
	@RequestMapping(value="/dap-an-dung",method=RequestMethod.POST)
	@ResponseBody
	public String dapAnDung(HttpSession session,@RequestParam("idPost")int idPost){
		Account account =(Account)session.getAttribute("account");
		Post p =postS.getPostById(idPost);
		if(p!=null){
			
			int idAccRoomPost =p.getRoomList().get(0).getIdAcc().getIdAcc(); // mã tài khoản là chủ phòng chứa bài post
			int idAccPost =p.getIdAcc().getIdAcc();// tài khoản là người dùng là chủ bài đăng
			if(idAccRoomPost==account.getIdAcc()||idAccPost==account.getIdAcc()){
				// lấy ra đáp án đúng và trả về client
				int correctAnswer =postS.getCorrectAnswerFromPost(idPost);
				if(correctAnswer==0){
					return "0|không có dữ liệu";
				}else{
					return "1|"+correctAnswer;
				}
				
			}
			
		}else{
			return "0|không có dữ liệu";
		}
		return "0|không có dữ liệu";
				
	}
	
}