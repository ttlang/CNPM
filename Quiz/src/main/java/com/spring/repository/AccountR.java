package com.spring.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.spring.domain.Account;
import com.spring.domain.Room;
import com.spring.domain.RoomManage;

public interface AccountR extends CrudRepository<Account, Integer> {
	/**
	 * Lấy danh sách tài khoản từ địa chỉ email nhận vào
	 * 
	 * @param email
	 *            địa chỉ email
	 * @return danh sách tài khoản
	 */
	@Query("FROM Account a WHERE a.email=:email AND  a.state=true")
	public List<Account> searchByEmail(@Param("email") String email);

	/**
	 * Lấy danh sách tài khoản từ địa chỉ email và password nhận vào
	 * 
	 * @param email
	 * @param password
	 * @return danh sách tài khoản
	 */
	@Query("FROM Account a WHERE a.email=:email AND a.password=:password AND a.state=true")
	public List<Account> searchByEmail(@Param("email") String email, @Param("password") String password);

	@Query("FROM Account")
	public List<Account> getAllAcc();

	/**
	 * lấy danh sách phòng mà tài khoản quản lý
	 * 
	 * @param idAcc
	 *            mã tài khoản người dùng
	 * @return danh sách phòng
	 */
	@Query("SELECT a.roomList FROM Account a WHERE a.idAcc=:idAcc")
	public List<Room> getListRoomManager(@Param("idAcc") int idAcc);

	/**
	 * Lây danh sách các phòng mà idaccount tham gia
	 * 
	 * @param idAcc
	 * @return danh sách phòng
	 */
	@Query("SELECT a.roomManageList FROM Account a WHERE a.idAcc=:idAcc")
	public List<RoomManage> getListRoomParticipation(@Param("idAcc") int idAcc);

	/**
	 * cập nhật thông tin tài khoản
	 * 
	 * @param name
	 * @param birth
	 * @param job
	 * @param gender
	 * @param address
	 * @param idAccount
	 * @return số dòng bị thay đổi dữ liệu
	 */
	@Modifying
	@Query("UPDATE Account set name=?1,birth=?2,job=?3,gender=?4,address=?5 WHERE idAcc=?6")
	public int updateAccountInfo(String name, Date birth, String job, boolean gender, String address, int idAccount);
/**
 * Cập nhật hình ảnh của tài khoản
 * @param avatarLink
 * @param idAccount
 * @return số dòng bị thay đổi dữ liệu
 */
	@Modifying
	@Query("UPDATE Account set avatar=?1 WHERE idAcc=?2")
	public int updateAccountAvatar(String avatarLink, int idAccount);

}
