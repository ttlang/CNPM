package com.spring.project;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.spring.service.AES;

@RunWith(SpringRunner.class)
@SpringBootTest
public class AESTest {
	@Autowired
	AES aes;
	@Test
	public void testAES(){
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		String data = df.format(new Date());
		String a =data+"|"+String.valueOf(102);
		System.err.println(aes.encrypt(a));
		System.err.println(aes.decrypt(aes.encrypt(a)));
		System.err.println(aes.getClass());

		
        
	}

}
