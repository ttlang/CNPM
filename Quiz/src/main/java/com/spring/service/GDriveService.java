package com.spring.service;

import java.io.IOException;
import java.net.URISyntaxException;
import java.security.GeneralSecurityException;

import com.google.api.services.drive.model.File;

public interface GDriveService {
	/**
	 * 
	 * @param filePath đường dẫn của file trên host
	 * @param folderID ID của folder chứa file trên Gdrive
	 * @param mimeType các công cụ hổi trợ chuyển đổi của Gdrive để mở file ()
	 * @return
	 */
	public File upLoadFile(String fileName,String filePath,String folderID,String mimeType) throws IOException, GeneralSecurityException, URISyntaxException;
	
	

}
