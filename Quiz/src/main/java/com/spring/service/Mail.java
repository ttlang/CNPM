package com.spring.service;

import java.io.UnsupportedEncodingException;
import java.util.Collection;
import java.util.Map;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;


import it.ozimov.springboot.mail.service.exception.CannotSendEmailException;

public interface Mail {
	public final String FROM = "ttlang162@gmail.com";

	/**
	 * 
	 * @param from
	 *            địa chỉ mail gửi
	 * @param to
	 *            địa chỉ mail nhận
	 * @param message
	 *            view được gửi đi
	 * @throws AddressException
	 * @throws CannotSendEmailException
	 * @throws UnsupportedEncodingException
	 */
	public void sendMail(Collection<InternetAddress>to,String subject ,String message,Map<String,Object>model)
			throws AddressException, CannotSendEmailException, UnsupportedEncodingException;

}
