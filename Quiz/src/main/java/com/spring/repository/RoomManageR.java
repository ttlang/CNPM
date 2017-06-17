package com.spring.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.spring.domain.Room;
import com.spring.domain.RoomManage;

public interface RoomManageR extends CrudRepository<RoomManage, Integer> {

	/**
	 * Lấy danh sách đối tượng dùng để quản lý phòng
	 * 
	 * @param idRoom
	 *            mã phòng
	 * @param state
	 *            trạng thái người dùng
	 * @return
	 */
	@Query("FROM RoomManage r WHERE r.roomManagePK.idRoom=:idRoom AND r.state=:state")
	public List<RoomManage> getListRoomanageByIDRoomAndState(@Param("idRoom") int idRoom,
			@Param("state") boolean state);

	/**
	 * xóa tài khoản người dùng trong một phòng học
	 * 
	 * @param idAcc
	 *            mã người dùng
	 * @return
	 */
	 /** anotation dùng để JPA xác định câu lệnh dùng để cập nhật dữ
				 * liệu Data Manipulation Language (DML)
	
				 */
	@Modifying
	@Query("DELETE RoomManage WHERE account.idAcc=:idAcc AND roomManagePK.idRoom=:idRoom")
	public int deleteMember(@Param("idAcc") int idAcc, @Param("idRoom") int idRoom);

	/**
	 * thay đổi trạng thái của tài khoản trong phòng học
	 * 
	 * @param idAcc
	 *            mã tài khoản
	 * @param idRoom
	 *            mã phòng học
	 * @param state
	 *            trạng thái (true: được kích hoạt | false: không được kích
	 *            hoạt)
	 * 
	 * @return
	 */
	@Query("UPDATE RoomManage SET state=:state WHERE account.idAcc=:idAcc AND roomManagePK.idRoom=:idRoom")
	@Modifying
	public int setStateForMember(@Param("idAcc") int idAcc, @Param("idRoom") int idRoom, @Param("state") boolean state);
	/**
	 * Lấy số lượng thành viên đã được duyệt vào phòng
	 * @param roomID mã phòng
	 * @return
	 */
	@Query("SELECT COUNT(account.idAcc) FROM RoomManage WHERE roomManagePK.idRoom=:idRoom AND state=1 ")
	public int getNumberOfMem(@Param("idRoom")int roomID);
	// lỗi đang fix
	/**
	 * Lấy đối tượng thông tin phòng học mà người dùng quản lý
	 * @param idAcc mã người dùng	
	 * @param idRoom mã phòng
	 * @return Room
	 */
	@Query("SELECT r.room FROM RoomManage r WHERE r.roomManagePK.idRoom=:idRoom AND r.roomManagePK.idAcc=:idAcc")
	public Room getRoomManage(@Param("idAcc")int idAcc,@Param("idRoom")int idRoom);

}
