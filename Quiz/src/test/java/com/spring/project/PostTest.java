package com.spring.project;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.spring.service.PostS;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class PostTest {
	@Autowired
	PostS postS;

	@Test
	public void testDeletePost() {
		System.out.println(postS.deletePost(39, 5));
	}

	@Test
	public void testGetListAccountLike() {
		System.out.println(postS.getListAccountLike(35).size());
	}

}
