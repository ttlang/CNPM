package com.spring.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.spring.domain.Post;
import com.spring.domain.Room;

public interface RoomR extends CrudRepository<Room, Integer> {
	/**
	 * Lấy ra tên phòng học từ mã người dùng nhận vào 
	 * @param idRoom mã phòng học
	 * @return tên phòng học
	 */
	@Query("Select r.roomName  from Room r where r.idRoom=:idRoom")
	public String getNameRoom(@Param("idRoom") int idRoom);

	
	/**
	 * Lấy ra danh sách bài đăng trong một phòng học
	 * @param idRoom mã phòng học
	 * @param p phân trang
	 * @return
	 */
	
	@Query("select r.postList from Room r  where r.idRoom=:idRoom ")
	public List<Post>getListPostInRoom(@Param("idRoom") int idRoom,Pageable p);
	
	
}
