package com.spring.service;

import java.io.UnsupportedEncodingException;
import java.util.Collection;
import java.util.Map;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.ozimov.springboot.mail.model.Email;
import it.ozimov.springboot.mail.model.defaultimpl.DefaultEmail;
import it.ozimov.springboot.mail.service.EmailService;
import it.ozimov.springboot.mail.service.exception.CannotSendEmailException;
@Service
public class MailImp implements Mail {
	@Autowired
	EmailService e;

	@Override
	public void sendMail(Collection<InternetAddress> to, String subject, String message,
			Map<String, Object> model) throws AddressException, CannotSendEmailException, UnsupportedEncodingException {
		Email email = DefaultEmail.builder().from(new InternetAddress(FROM)).to(to).subject(subject).body("")
				.encoding("UTF-8").build();
		e.send(email, message, model);
	}
}
