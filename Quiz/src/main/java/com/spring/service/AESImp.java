package com.spring.service;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.transaction.Transactional;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class AESImp implements AES {
	private String key = "Bar12345Bar12345"; // 128 bit key
	private String initVector = "RandomInitVector"; // 16 bytes IV

	@Override
	public String encrypt(String key, String initVector, String value) {

		try {
			IvParameterSpec iv = new IvParameterSpec(initVector.getBytes("UTF-8"));
			SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
			cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);

			byte[] encrypted = cipher.doFinal(value.getBytes());
			return Base64.encodeBase64String(encrypted);

		} catch (Exception e) {
			System.out.println(e.getMessage());

			return null;

		}

	}

	@Override
	public String decrypt(String key, String initVector, String encrypted) {

		try {
			IvParameterSpec iv = new IvParameterSpec(initVector.getBytes("UTF-8"));
			SecretKeySpec skeySpec = new SecretKeySpec(key.getBytes("UTF-8"), "AES");

			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
			cipher.init(Cipher.DECRYPT_MODE, skeySpec, iv);

			byte[] original = cipher.doFinal(Base64.decodeBase64(encrypted));
			return new String(original);
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}

	}

	@Override
	public String encrypt(String value) {
		String encryptString = encrypt(key, initVector, value);
		return encryptString.substring(0, encryptString.length() - 2);
	}

	@Override
	public String decrypt(String value) {
		return decrypt(key, initVector, value);
	}

}
