package com.spring.project;

import static org.junit.Assert.assertEquals;

import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import org.apache.commons.lang.math.NumberUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.spring.repository.AccountR;
import com.spring.service.AES;
import com.spring.service.AccountS;
import com.spring.service.Mail;

import it.ozimov.springboot.mail.service.exception.CannotSendEmailException;

@RunWith(SpringRunner.class)
@SpringBootTest
public class AccountTest {
	@Autowired
	AccountS s;
	@Autowired
	AccountR r;
	@Autowired
	Mail mail;
	@Autowired
	AES aes;

	/**
	 * testCheckEmail
	 */
	@Test
	public void testCheckEmail() {
		assertEquals(true, s.checkEmail("ttlang162@gmail.com"));
		assertEquals(false, s.checkEmail("ttlang16@gmail.com"));
	}

	/**
	 * test checkEmailAndPassword()
	 * 
	 */
	@Test
	public void testCheckEmailAndPassword() {
		assertEquals(true, s.checkEmailAndPassword("ttlang162@gmail.com", "1234"));
		assertEquals(false, s.checkEmailAndPassword("ttlang162@gmail.com", "12345"));

	}

	/**
	 * Test getAccountByEmail
	 */
	@Test
	public void testGetAccountByEmail() {
		System.out.println(s.getAccountByEmail("ttlang162@gmail.com"));
	}

	@Test
	public void testSignUp() {
		assertEquals(true, s.SignUp("ttlang1234@gmail.com", "1234567"));

	}

	@Test
	public void testCheckLogIn() {
		assertEquals("1", s.checkLogin("ttlang162@gmail.com", "1234"));
		assertEquals("Mật khẩu không đúng", s.checkLogin("ttlang162@gmail.com", "12345"));
		assertEquals("Tài khoản không tồn tại", s.checkLogin("1ttlang162@gmail.com", "1234"));
		assertEquals(false, NumberUtils.isNumber(s.checkLogin("ttlang162@gmail.com3", "1234")));
	}

	@Test
	public void test() {
		System.out.println(r.getAllAcc().size());
	}

	@Test
	public void testSendMail() throws AddressException, UnsupportedEncodingException, CannotSendEmailException {
		String a = aes.encrypt("ttlang");
		Collection<InternetAddress> to = new ArrayList<>();
		to.add(new InternetAddress("lang.tt16@gmail.com"));
		Map<String, Object> map = new HashMap<>();
		map.put("link", a);
		mail.sendMail(to, "Test", "mail2.html", map);

	}
	@Test
	public void testEnableAccount(){
		assertEquals(1, s.enableAccount(1, true));
	}
	@Test
	public void test2(){
		String a="abca|zzzz";
		StringTokenizer st = new StringTokenizer(a, "|");
		System.err.println(st.countTokens());
		System.err.println(st.nextToken());
		
	}
	@Test
	public void testChangePassword(){
		System.err.println(s.changePassword("ttlang162@gmail.com", "12345"));
	}
	@Test
	public void testIsAdmin(){
		assertEquals(true, s.checkIsAdmin(3, 3));
	}
	@Test
	public void testUpdateAccountInfo(){
		String date ="1996-2-1";
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date date2 = formatter.parse(date);
			assertEquals(true, s.updateAccountInfo("Tùng tôm",date2, "sinh viên", true, "nông lâm", 3));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
}
