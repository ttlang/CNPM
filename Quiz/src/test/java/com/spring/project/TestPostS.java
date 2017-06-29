package com.spring.project;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.spring.service.PostS;

@RunWith(SpringRunner.class)
@SpringBootTest
public class TestPostS {
	@Autowired
	private PostS postS;
	
	@Test
	public void testGetCorrectAnswer(){
		System.err.println(postS.getCorrectAnswerFromPost(3276));
	}

}
