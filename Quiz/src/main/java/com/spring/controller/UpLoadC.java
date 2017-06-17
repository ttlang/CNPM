package com.spring.controller;

import java.io.IOException;
import java.util.Collections;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.api.client.http.FileContent;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.model.File;
import com.spring.domain.Account;
import com.spring.service.AccountS;

@Controller
public class UpLoadC {
	// lấy thư mục cài đặt tomcat
	public static String UPLOADED_FOLDER = System.getProperty("catalina.home") + java.io.File.separator;
	@Autowired
	private AccountS accountService;

	// upload avatar
	@PostMapping(value = "/upload/avatar")
	@ResponseBody
	public String upLoadAvatar(@RequestParam("file") MultipartFile uploadfile, HttpSession session) throws IOException {

		Account account = (Account) session.getAttribute("account");
		String fileType = uploadfile.getContentType();
		if (fileType.startsWith("image/")) {
			Drive service = Quickstart.getDriveService();
			File fileMetadata = new File();
			fileMetadata.setName(uploadfile.getOriginalFilename());
			// id thư mục trên google Drive
			String folderId = "0B27mfRY62YKZYjRyUFAyRVcwUEE";
			fileMetadata.setParents(Collections.singletonList(folderId));
			fileMetadata.setMimeType("image/jpeg");
			// đường dẫn trên local
			java.io.File filePath = new java.io.File(UPLOADED_FOLDER + uploadfile.getOriginalFilename());
			uploadfile.transferTo(filePath);
			FileContent mediaContent = new FileContent(uploadfile.getContentType(), filePath);
			File file = service.files().create(fileMetadata, mediaContent).setFields("id").execute();
			// https://docs.google.com/uc?id=0B27mfRY62YKZQTBGNzlLWU5GY1U
			String link = "https://docs.google.com/uc?id=" + file.getId();
			// System.out.println("File ID: " + file.getId());
			// System.err.println(filePath);
			// xóa file trên host
			filePath.delete();
				
			if (accountService.updateAccountAvatar(link, account.getIdAcc())) {
				session.setAttribute("account", accountService.getAccountByID(account.getIdAcc()));
				return link;

			}
		}
		return "Cập nhật thất bại";
	}
}
