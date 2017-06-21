package com.spring.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.hibernate.internal.SessionImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import com.spring.domain.Post;
import com.spring.domain.Room;
import com.spring.domain.RoomManage;
import com.spring.model.PostByGroup;
import com.spring.model.PostRoom;
import com.spring.repository.AccountR;
import com.spring.repository.RoomManageR;
import com.spring.repository.RoomR;

@Service
@Transactional
public class RoomSImp implements RoomS {
	@Autowired
	private SessionFactory sf;
	@Autowired
	private AccountR accountR;
	@Autowired
	private RoomR roomR;
	@Autowired
	private RoomManageR roomManageR;

	@PersistenceContext
	private EntityManager em;

	@Override
	public int createRoom(String roomName, int idAccount) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		int roomID = 0;
		try {
			CallableStatement callableStatement = connection
					.prepareCall("EXECUTE p_addRoom_room @room_name=?,@room_descr=?,@id_acc=?");
			callableStatement.setNString(1, roomName);
			callableStatement.setNString(2, "");
			callableStatement.setInt(3, idAccount);
			ResultSet resultSet = callableStatement.executeQuery();
			while (resultSet.next()) {
				roomID = resultSet.getInt("LastID");
			}

		} catch (SQLException sqlex) {
			sqlex.printStackTrace();
		}

		return roomID;
	}

	@Override
	public List<Room> getListRoomManager(int idAccount) {
		return accountR.getListRoomManager(idAccount);
	}

	@Override
	public List<Room> getListRoomParticipation(int idAccount) {
		List<RoomManage> list = accountR.getListRoomParticipation(idAccount);
		List<Room> listRoomManage = accountR.getListRoomManager(idAccount);
		List<Room> res = new ArrayList<>();
		for (RoomManage roomManage : list) {
			if (roomManage.getState()) {
				res.add(roomManage.getRoom());
			}
		}
		res.removeAll(listRoomManage);
		return res;
	}

	@Override
	public boolean participationRoom(int idRoom, int idAccount) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			CallableStatement callableStatement = connection
					.prepareCall("EXECUTE p_participationRoom_room_manage @id_room=?,@id_acc=?");
			callableStatement.setInt(1, idRoom);
			callableStatement.setInt(2, idAccount);
			int res = callableStatement.executeUpdate();
			return res > 0 ? true : false;
		} catch (SQLException sqlex) {
			return false;
		}

	}

	@Override
	public String getNameRoom(int idRoom) {
		return roomR.getNameRoom(idRoom);
	}

	@Override
	public Room getRoom(int IDacc, int roomID) {
		List<Room> listOfRoom = accountR.findOne(IDacc).getRoomList();
		for (Room room : listOfRoom) {
			if (room.getIdRoom() == roomID) {
				return room;
			}
		}
		return null;
	}

	// ? phương thức bị lỗi
	@Override
	public Room getRoomParticipation(int IDacc, int roomID) {
		List<RoomManage> listOfRoom = accountR.findOne(IDacc).getRoomManageList();
		for (RoomManage roomManage : listOfRoom) {
			if (roomManage.getRoom().getIdRoom() == roomID) {
				return roomManage.getRoom();
			}
		}
		return null;
	}

	@Override
	// ?? phương thức bị lỗi
	public int getAccountInRom(Room r) {
		List<RoomManage> roomManages = new ArrayList<>();
		roomManages = r.getRoomManageList();
		int result = 0;
		for (RoomManage roomManage : roomManages) {
			if (roomManage.getState()) {
				result += 1;
			}
		}
		return result;
	}

	public List<Post> getListPostInRoom2(int idRoom, int limit, int offset) {
		List<Post> result = roomR.getListPostInRoom(idRoom, new PageRequest(offset, limit));
		/* PageRequest lấy page từ 0,1,2,... */
		return result;
	}

	@Override
	public int addPostAfterIntoRoom(String postContent, int idRoom, int typePost, int idAcc) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			CallableStatement callableStatement = connection.prepareCall(
					"EXECUTE p_addPostAfterIntoRoom_postAndRoom  @post_content=?, @id_post_type=?, @id_acc=?, @id_room=?");
			callableStatement.setString(1, postContent);
			callableStatement.setInt(2, typePost);
			callableStatement.setInt(3, idAcc);
			callableStatement.setInt(4, idRoom);
			ResultSet resultSet = callableStatement.executeQuery();
			int res = -1;
			while (resultSet.next()) {
				res = resultSet.getInt(1);
			}
			return res;
		} catch (SQLException sqlex) {
			return -1;
		}
	}

	@Override
	public String deleteRoom(int idRoom) {

		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		String message = "";
		try {
			CallableStatement callableStatement = connection.prepareCall("EXECUTE p_delete_room @id_room=?");
			callableStatement.setInt(1, idRoom);
			ResultSet resultSet = callableStatement.executeQuery();
			resultSet.next();
			message = resultSet.getString("result");
		} catch (SQLException sqlex) {
			message = sqlex.getMessage();
		}

		return message;

	}

	@Override
	public int addCommentIntoPost(String commentContent, int idPost, int idAcc) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			CallableStatement callableStatement = connection
					.prepareCall(" EXECUTE p_addCommentIntoPost_comment @comment_content=?,@id_post=?, @id_acc=?");
			callableStatement.setNString(1, commentContent);
			callableStatement.setInt(2, idPost);
			callableStatement.setInt(3, idAcc);
			int resultSet = callableStatement.executeUpdate();
			return resultSet;
		} catch (SQLException sqlex) {
			return -1;
		}

	}

	@Override
	public Map<Integer, String> getMemberInRoom(int idRoom) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			Map<Integer, String> res = new HashMap<>();
			CallableStatement callableStatement = connection.prepareCall(" select * from f_getMemberInRoom(?)");
			callableStatement.setInt(1, idRoom);

			ResultSet re = callableStatement.executeQuery();
			while (re.next()) {
				res.put(re.getInt("id_acc"), re.getString("name"));
			}
			return res;
		} catch (SQLException sqlex) {
			return null;
		}
	}

	@Override
	public List<Post> getListPostInRoom(int idRoom) {
		try {
			Session session = sf.getCurrentSession();
			Criteria criteria = session.createCriteria(Room.class);
			Room room = (Room) criteria.add(Restrictions.eq("idRoom", idRoom)).uniqueResult();
			return room.getPostList();
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

	}

	@Override
	public List<RoomManage> getListRoomanageByIDRoomAndState(int idRoom, boolean state) {
		return roomManageR.getListRoomanageByIDRoomAndState(idRoom, state);
	}

	@Override
	public int deleteMember(int idAcc, int idRoom) {
		return roomManageR.deleteMember(idAcc, idRoom);
	}

	@Override
	public int setStateForMember(int idAcc, int idRoom, boolean state) {
		return roomManageR.setStateForMember(idAcc, idRoom, state);
	}

	@Override
	public int getNumberOfMem(int idRoom) {
		return roomManageR.getNumberOfMem(idRoom);
	}

	// PHƯƠNG thức bị lỗi
	@Override
	public Room getRoomManage(int idAcc, int idRoom) {
		return roomManageR.getRoomManage(idAcc, idRoom);
	}

	@Override
	public Room getRoom(int idRoom) {
		return roomR.findOne(idRoom);
	}

	@Override
	public int addPostQuizIntoRoom(int idRoom, Integer idAcc, String noiDung, String dap1, String dap2, String dap3,
			String dap4, int daDung) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			CallableStatement callableStatement = connection.prepareCall(
					" EXECUTE p_addQuizPostIntoGroup @id_room=?,@id_acc=?,@question_content=?, @answer_content1=?,@answer_content2=?,@answer_content3 =?,@answer_content4 =?,@correct_question =?");
			callableStatement.setInt(1, idRoom);
			callableStatement.setInt(2, idAcc);
			callableStatement.setNString(3, noiDung);
			callableStatement.setNString(4, dap1);
			callableStatement.setNString(5, dap2);
			callableStatement.setNString(6, dap3);
			callableStatement.setNString(7, dap4);
			callableStatement.setInt(8, daDung);
			ResultSet resultSet = callableStatement.executeQuery();
			if (resultSet.next()) {
				return resultSet.getInt("LastID");
			}
			return -1;
		} catch (SQLException sqlex) {
			System.out.println(sqlex.getMessage());
			return -2;
		}

	}

	@Override
	public List<PostByGroup> getPostByGroup(int room_id) {
		List<PostByGroup> rs = new ArrayList<>();
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			CallableStatement callableStatement = connection
					.prepareCall("select * from dbo.getpostbygroup(?) ORDER BY ID_POST DESC");
			callableStatement.setInt(1, room_id);
			ResultSet resultSet = callableStatement.executeQuery();
			PostByGroup temp;
			while (resultSet.next()) {
				temp = new PostByGroup(resultSet.getInt(1), resultSet.getString(2), resultSet.getDate(3),
						resultSet.getInt(4), resultSet.getString(5), resultSet.getString(6), resultSet.getString(7),
						resultSet.getString(8), resultSet.getString(9));
				rs.add(temp);

			}

		} catch (SQLException sqlex) {
			System.out.println(sqlex.getMessage());

		}
		return rs;
	}

	@Override
	public PostByGroup getQuizPost(int post_id) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			CallableStatement callableStatement = connection.prepareCall("select * from dbo.getPostQuizByGroup(?)");
			callableStatement.setInt(1, post_id);
			ResultSet resultSet = callableStatement.executeQuery();
			PostByGroup temp;
			while (resultSet.next()) {
				temp = new PostByGroup(resultSet.getInt(1), resultSet.getString(2), resultSet.getDate(3),
						resultSet.getInt(4), resultSet.getString(5), resultSet.getString(6), resultSet.getString(7),
						resultSet.getString(8), resultSet.getString(9));
				return temp;

			}

		} catch (SQLException sqlex) {
			System.out.println(sqlex.getMessage());

		}
		return null;
	}

	@Override
	public List<PostRoom> getListPostRoom(int idRoom) {
		List<Post> list = getListPostInRoom(idRoom);
		Collections.reverse(list);
		List<PostRoom> listrs = new ArrayList<>();
		for (Post p : list) {
			PostRoom temp = new PostRoom();
			temp.setContent(p);
			if (p.getIdConnect() > 0) {
				PostByGroup pbg = getQuizPost(p.getIdPost());
				temp.setDa1(pbg.getAnswer1());
				temp.setDa2(pbg.getAnswer2());
				temp.setDa3(pbg.getAnswer3());
				temp.setDa4(pbg.getAnswer4());
			}
			listrs.add(temp);
		}
		return listrs;
	}

	@Override
	public boolean leaveRoom(int idAcc, int idRoom) {

		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			CallableStatement callableStatement = connection.prepareCall(" EXECUTE p_leaveRoom_room_manage ?,?");
			callableStatement.setInt(1, idRoom);
			callableStatement.setInt(2, idAcc);
			return (callableStatement.executeUpdate() > 0) ? true : false;
		} catch (SQLException sqlex) {
			System.out.println(sqlex.getMessage());
			return false;
		}
	}

	@Override
	public int[] getListIDAccountInRoom(int idRoom) {
		List<RoomManage> roomManages = roomManageR.getListRoomanageByIDRoomAndState(idRoom, true);
		int[] res = new int[roomManages.size()];
		for (int i = 0; i < res.length; i++) {
			res[i] = roomManages.get(i).getAccount().getIdAcc().intValue();
		}
		roomManages.clear();
		return res;
	}
}
