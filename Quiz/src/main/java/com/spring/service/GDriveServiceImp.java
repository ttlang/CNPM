package com.spring.service;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Paths;
import java.security.GeneralSecurityException;
import java.util.Collections;

import org.springframework.stereotype.Service;

import com.google.api.client.googleapis.auth.oauth2.GoogleCredential;
import com.google.api.client.http.FileContent;
import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.drive.Drive;
import com.google.api.services.drive.DriveScopes;
@Service
public class GDriveServiceImp implements GDriveService {
	private static String SERVICE_ACCOUNT_EMAIL = "ttlang@ttlang-171013.iam.gserviceaccount.com";
	private static String applicationName = "ttlang";

	public Drive getDriveService() throws GeneralSecurityException, IOException, URISyntaxException {
		URL resource = GDriveService.class.getResource("/ttlang-f98aaa157b45.p12");
		File key = Paths.get(resource.toURI()).toFile();
		HttpTransport httpTransport = new NetHttpTransport();
		JacksonFactory jsonFactory = new JacksonFactory();

		GoogleCredential credential = new GoogleCredential.Builder().setTransport(httpTransport)
				.setJsonFactory(jsonFactory).setServiceAccountId(SERVICE_ACCOUNT_EMAIL)
				.setServiceAccountScopes(Collections.singleton(DriveScopes.DRIVE))
				.setServiceAccountPrivateKeyFromP12File(key).build();
		Drive service = new Drive.Builder(httpTransport, jsonFactory, credential).setApplicationName(applicationName)
				.setHttpRequestInitializer(credential).build();
		return service;
	}

	@Override
	public com.google.api.services.drive.model.File upLoadFile(String fileName,String filePath, String folderID, String mimeType)
			throws IOException, GeneralSecurityException, URISyntaxException {
		File fileUpload = new File(filePath);
		com.google.api.services.drive.model.File fileMetadata = new com.google.api.services.drive.model.File();
		fileMetadata.setMimeType(mimeType);
		fileMetadata.setName(fileName);
		fileMetadata.setParents(Collections.singletonList(folderID));
		com.google.api.client.http.FileContent fileContent = new FileContent(mimeType, fileUpload);
		com.google.api.services.drive.model.File file = getDriveService().files().create(fileMetadata, fileContent)
				.setFields("id,webContentLink,webViewLink").execute();
		return file;
	}
	

}
