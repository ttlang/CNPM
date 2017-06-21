package com.spring.project;

import static org.junit.Assert.assertEquals;

import java.util.List;

import javax.transaction.Transactional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.spring.domain.Post;
import com.spring.domain.Room;
import com.spring.service.AccountS;
import com.spring.service.PostS;
import com.spring.service.RoomS;

@RunWith(SpringRunner.class)
@SpringBootTest
@Transactional
public class RoomTest {
	@Autowired
	private RoomS rS;
	@Autowired
	PostS postS;
	@Autowired
	AccountS a;

	@Test
	public void testCreateRoom() {
		System.out.println(rS.createRoom("con cho", 1));

	}

	@Test
	public void testGetListRoomManager() {
		System.out.println(rS.getListRoomManager(2).size());
	}

	@Test
	public void testGetListRoomParticipation() {
		System.out.println(rS.getListRoomParticipation(2).size());
		List<Room> list = rS.getListRoomParticipation(2);
		System.out.println(list.toString());

	}

	@Test
	public void testGetNameRoomByID() {
		System.out.println(rS.getNameRoom(2001));
	}

	@Test
	public void testParticipationRoom() {
		System.out.println(rS.participationRoom(16026, 1));
	}

	@Test
	public void testGetRoom() {
		// rS.getRoom(1052, 7);
		// System.err.println(rS.getRoom(1, 6).getRoomManageList().size());
		System.err.println(rS.getAccountInRom((rS.getRoom(1, 2001))));
	}

	@Test
	public void testGetListPostInRoom2() {
		System.out.println(rS.getListPostInRoom2(16035, 10, 0).size());
		List<Post> list = rS.getListPostInRoom2(16035, 10, 0);
		for (Post post : list) {
			System.out.println(post.getPostContent());
		}
	}

	@Test
	public void testAddPostAfterIntoRoom() {
		assertEquals((rS.addPostAfterIntoRoom("Nooi dung test Thang", 4, 1, 4)), true);
		assertEquals((rS.addPostAfterIntoRoom("Nooi dung test Thang", 16021, 1, 2)), false);
	}

	@Test
	public void testAddCommentIntoPost() {
		assertEquals(rS.addCommentIntoPost("COn cặc như lol", 21, 2), true);
		assertEquals(rS.addCommentIntoPost("COn cặc như lol", 21, 1), true);
	}

	@Test
	public void testGettMemberInRoom() {
		System.out.println(rS.getMemberInRoom(4).size());
	}

	@Test
	public void testGetListPostInRoom() {
		assertEquals((rS.addPostAfterIntoRoom("Bài đăng thứ 2", 4, 1, 4)), true);
		System.out.println(rS.getListPostInRoom(4));
	}

	@Test
	public void testGetListCommentByIdPost() {
		System.out.println(postS.getListCommentByIdPost(1).size());
	}
	
	@Test
	public void testGetRoomByID(){
		System.err.println(rS.getRoom(5).getIdAcc().getIdAcc());
	}
	@Test
	public void testAddQuiz(){
		System.out.println("testQiz"  + rS.addPostQuizIntoRoom(7, 1, "nodng", "nodnffg", "nodn4g", "nodng343", "nodng34", 4));
	}
	@Test
	public void testListPost(){
		System.out.println("test list post: " + rS.getListPostInRoom(7).size());
	}
	@Test
	public void testLeaveRoom(){
		System.err.println(rS.leaveRoom(2, 6));
	}
	@Test
	public void getPostOfUser(){
		postS.getPostOfUser(1);
	}
}
