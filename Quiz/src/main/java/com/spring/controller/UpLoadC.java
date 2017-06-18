package com.spring.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.GeneralSecurityException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.api.services.drive.model.File;
import com.spring.domain.Account;
import com.spring.service.AccountS;
import com.spring.service.GDriveService;

@Controller
public class UpLoadC {
	private String folderId = "0B27mfRY62YKZYjRyUFAyRVcwUEE";
	@Autowired
	ServletContext context;
	@Autowired
	GDriveService gdriveService;
	@Autowired
	AccountS accountService;

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

}
