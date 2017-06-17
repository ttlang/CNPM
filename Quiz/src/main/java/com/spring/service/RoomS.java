package com.spring.service;

import java.util.List;
import java.util.Map;

import com.spring.domain.Post;
import com.spring.domain.Room;
import com.spring.domain.RoomManage;
import com.spring.model.PostByGroup;
import com.spring.model.PostRoom;

public interface RoomS {
	/**
	 * Phương thức tạo 1 phòng học mới
	 * 
	 * @param roomName
	 * @return mã phòng mới được tạo
	 */
	public int createRoom(String roomName, int idAccount);

	/**
	 * Phương thức cho account tham gia vào 1 phòng với mã phòng idRoom
	 * 
	 * @param idRoom
	 * @param idAccount
	 * @return
	 */

	public boolean participationRoom(int idRoom, int idAccount);

	/**
	 * Phương thức lấy danh sách phòng được quản lý bởi account có _id_account
	 * 
	 * @param idAccount
	 * @return danh sách Room
	 */
	public List<Room> getListRoomManager(int idAccount);

	/**
	 * Phương thức lấy danh sách phòng được tham gia bởi idAccount
	 * 
	 * @param idAccount
	 * @return danh sách Room
	 */
	public List<Room> getListRoomParticipation(int idAccount);

	/**
	 * phương thức lấy tên room thông qua mã room
	 * 
	 * @param idRoom
	 * @return tên room
	 */
	public String getNameRoom(int idRoom);

	/**
	 * Lấy phòng học từ mã người dùng nhận vào
	 * 
	 * @param IDacc
	 *            tài khoản người dùng
	 * @param roomID
	 *            mã phòng
	 * @return phòng học trùng với mã phòng nhận vào
	 */
	public Room getRoom(int IDacc, int roomID);

	/**
	 * 
	 * @param r
	 *            phòng học
	 * @return số lượng thành viên đã được duyệt vào phòng
	 */
	public int getAccountInRom(Room r);

	/**
	 * Lấy danh sách bài đăng qua mã phòng, giới hạn số lượng theo limit and
	 * offset
	 * 
	 * @param idRoom
	 * @param limit
	 * @param offset
	 * @return danh sách bài đăng
	 */

	public List<Post> getListPostInRoom2(int idRoom, int limit, int offset);

	/**
	 * Thêm một Bài đăng vào trong nhóm với tư cách của thành viên quq idAcc
	 * 
	 * @param postContent
	 * @param idRoom
	 * @param typePost
	 * @param idAcc
	 * @return nếu add thành công trả về true, nếu sai trả về false
	 */
	public int addPostAfterIntoRoom(String postContent, int idRoom, int typePost, int idAcc);

	/**
	 * Thêm bình luận vào bài đăng
	 * 
	 * @param commentContent
	 * @param idPost
	 * @param idAcc
	 */
	public int addCommentIntoPost(String commentContent, int idPost, int idAcc);

	/**
	 * Lấy danh sách thành viên trong nhóm với idRoom
	 * 
	 * @param idRoom
	 * @return member list
	 */
	public Map<Integer, String> getMemberInRoom(int idRoom);

	/**
	 * Lấy danh sách bài viết trong phong qua mã phòng
	 * 
	 * @param idRoom
	 * @return list post
	 */

	public List<Post> getListPostInRoom(int idRoom);

	/**
	 * Lấy phòng từ mã người dùng nhận vào
	 * 
	 * @param IDacc
	 * @param roomID
	 * @return room
	 */
	public Room getRoomParticipation(int IDacc, int roomID);

	/**
	 * Lấy đối tượng dùng để quản lý phòng ( Admin dùng để xe người dùng trong
	 * phòng )
	 * 
	 * @param idRoom
	 *            mã phòng
	 * @param state
	 *            trạng thái người dùng
	 * @return
	 */
	public List<RoomManage> getListRoomanageByIDRoomAndState(int idRoom, boolean state);

	/**
	 * xóa tài khoản người dùng trong một nhóm
	 * 
	 * @param idAcc
	 *            mã tài khoản
	 * @return số record bị tác động
	 */
	public int deleteMember(int idAcc, int idRoom);

	/**
	 * cập nhật trạng thái cho tài khoản trong phòng học
	 * 
	 * @param idAcc
	 *            mã tài khoản
	 * @param idRoom
	 *            mã phòng học
	 * @param state
	 *            trạng thái của tài khoản
	 * @return số dòng trong database bị tác động
	 */
	public int setStateForMember(int idAcc, int idRoom, boolean state);

	/**
	 * lấy số lượng thành viên trong một phòng
	 * 
	 * @param idRoom
	 *            mã phòng nhận vào
	 * @return
	 */
	public int getNumberOfMem(int idRoom);

	// bị lỗi
	/**
	 * Lấy ra đối tượng chứa thông tin phòng học mà tài khoản quản lý
	 * 
	 * @param idAcc
	 * @param idRoom
	 * @return
	 */
	public Room getRoomManage(int idAcc, int idRoom);

	public Room getRoom(int idRoom);

	public int addPostQuizIntoRoom(int idRoom, Integer idAcc, String noiDung, String dap1, String dap2, String dap3,
			String dap4, int daDung);

	public List<PostByGroup> getPostByGroup(int room_id);

	public PostByGroup getQuizPost(int post_id);

	public List<PostRoom> getListPostRoom(int idRoom);

	public String deleteRoom(int idRoom);
}
