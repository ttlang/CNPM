package com.spring.project;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.spring.service.RoomS;

@RunWith(SpringRunner.class)
@SpringBootTest
public class RoomManageTest {
	@Autowired
	RoomS s;
	@Test
	public void testGetRoomMage(){
		assertEquals(2, s.getListRoomanageByIDRoomAndState(2, true).size());
	}
	@Test
	public void testDeleteMember(){
		System.out.println(s.deleteMember(4,2));
	}
	@Test
	public void testGetNumberOfMem(){
		System.out.println(s.getNumberOfMem(4));
	}
	// lỗi đang fix
	@Test
	public void testGetRoomManage(){
		System.out.println(s.getRoomManage(1, 5));
	}
}
