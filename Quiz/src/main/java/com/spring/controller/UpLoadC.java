package com.spring.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.api.services.drive.model.File;
import com.spring.domain.Account;
import com.spring.service.AccountS;
import com.spring.service.GDriveService;
import com.spring.service.RoomS;

@Controller
public class UpLoadC {
	private String folderId = "0B27mfRY62YKZSFpaWll3RkNhTmM";
	@Autowired
	ServletContext context;
	@Autowired
	GDriveService gdriveService;
	@Autowired
	AccountS accountService;

	@Autowired
	RoomS roomS;

	@RequestMapping(value = "/upload/avatar", method = RequestMethod.POST)
	@ResponseBody
	public String uploadingPost(@RequestParam("file") MultipartFile f, HttpSession session)
			throws IOException, GeneralSecurityException, URISyntaxException {

		Account account = (Account) session.getAttribute("account");
		if (f.getContentType().startsWith("image/")) {

			try {
				String UPLOADED_FOLDER = context.getRealPath("/") + java.io.File.separator;
				java.io.File filePath = new java.io.File(UPLOADED_FOLDER + f.getOriginalFilename());
				f.transferTo(filePath);
				System.out.println(filePath.getName());
				File file = gdriveService.upLoadFile(filePath.getName(), filePath.getPath(), folderId,
						f.getContentType());
				filePath.delete();
				String link = "https://docs.google.com/uc?id=" + file.getId();
				if (accountService.updateAccountAvatar(link, account.getIdAcc())) {
					session.setAttribute("account", accountService.getAccountByID(account.getIdAcc()));
					return link;
				}

			} catch (Exception e) {
				return e.getMessage();
			}

		}
		return "Định dạng file không hợp lệ";
	}

	@RequestMapping(value = "/upload/picture", method = RequestMethod.POST)
	@ResponseBody
	public String uploadPicture(HttpSession session, MultipartHttpServletRequest m) {
		// mã phòng
		String idRoom = m.getParameter("id_room");
		Account account = (Account) session.getAttribute("account");
		// nội dung bài đăng
		String postContent = m.getParameter("content_post");

		List<MultipartFile> listFileContent = new ArrayList<>();
		// số lượng file được gửi kèm theo
		int numberOfFile = Integer.parseInt(m.getParameter("num"));

		List<String> listFileResult = new ArrayList<>();
		String UPLOADED_FOLDER = context.getRealPath("/") + java.io.File.separator;

		if (numberOfFile > 0) {
			for (int i = 0; i < numberOfFile; i++) {
				listFileContent.add(m.getFile("f" + i));
			}
		}

		try {

			for (MultipartFile multipartFile : listFileContent) {
				if (multipartFile.getContentType().startsWith("image/")) {

					java.io.File filePath = new java.io.File(UPLOADED_FOLDER + multipartFile.getOriginalFilename());
					multipartFile.transferTo(filePath);
					System.out.println(filePath.getName());
					File file = gdriveService.upLoadFile(filePath.getName(), filePath.getPath(), folderId,
							multipartFile.getContentType());
					filePath.delete();
					String link = "https://docs.google.com/uc?id=" + file.getId();
					listFileResult.add(link);

				} else {
					return "Định dạng không hợp lệ";
				}
			}

		} catch (Exception e) {

			return "Đăng bài thất bại";
		}

		String postContents = "<p>" + postContent + "</p>" + "<div class='row'>";

		String linkView = "";
		for (String s : listFileResult) {
			linkView += "<div class='col-md-4'><a target='_blank' href='"+s+"'><img src='" + s
					+ "'width='200' height='200' style='margin-bottom: 10px;'></a></div>";
		}

		String end = "</div>";
		String postContents2 = postContents + linkView + end;

		return (roomS.addPostAfterIntoRoom(postContents2, Integer.parseInt(idRoom), 1, account.getIdAcc())) > 0 ? "1"
				: "0";
	}

	@RequestMapping(value = "/upload/file", method = RequestMethod.POST)
	@ResponseBody
	public String uploadFile(HttpSession session, MultipartHttpServletRequest m) {
		// mã phòng
		String idRoom = m.getParameter("id_room");
		Account account = (Account) session.getAttribute("account");
		// nội dung bài đăng
		String postContent = m.getParameter("content_post");

		MultipartFile multipartFile = m.getFile("file");
		String UPLOADED_FOLDER = context.getRealPath("/") + java.io.File.separator;

		String linkView, LinkDown, postContents;
		try {

			java.io.File filePath = new java.io.File(UPLOADED_FOLDER + multipartFile.getOriginalFilename());
			multipartFile.transferTo(filePath);
			System.out.println(filePath.getName());
			File file = gdriveService.upLoadFile(filePath.getName(), filePath.getPath(), folderId,
					multipartFile.getContentType());
			filePath.delete();
			linkView = file.getWebViewLink();
			LinkDown = file.getWebContentLink();

			postContents = "<p>" + postContent + "<p>" + "<a class='btn btn-info' href=" + linkView
					+ " target='_blank'>Xem Trước </a><span>&nbsp;</span>"
					+ "<a target='_blank' class='btn btn-success' href=" + LinkDown + ">Tải Xuống</a>";

		} catch (Exception e) {

			return "Đăng bài thất bại";
		}

		return (roomS.addPostAfterIntoRoom(postContents, Integer.parseInt(idRoom), 1, account.getIdAcc())) > 0 ? "1"
				: "0";
	}

}
