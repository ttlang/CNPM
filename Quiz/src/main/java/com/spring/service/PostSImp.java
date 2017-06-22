package com.spring.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.hibernate.internal.SessionImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.Account;
import com.spring.domain.Comment;
import com.spring.domain.Post;
import com.spring.domain.Room;
import com.spring.model.PostRoom;
import com.spring.repository.PostR;

@Service
@Transactional
public class PostSImp implements PostS {
	@Autowired
	PostR postR;
	@Autowired
	private SessionFactory sf;
	@Autowired
	RoomS roomS;

	@Override
	public List<Comment> getListCommentByIdPost(int idPost) {
		return postR.getListCommentByIdPost(idPost);
	}

	@Override
	public Post getPostById(int idPost) {
		return postR.getPostById(idPost);
	}

	@Override
	public boolean deletePost(int idPost, int idAcc) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		// System.out.println("idPost: " + idPost);
		// System.out.println("idAcc: " + idAcc);
		try {
			CallableStatement callableStatement = connection
					.prepareCall("execute p_deletePost_post  @id_post=?, @id_acc=?");
			callableStatement.setInt(1, idPost);
			callableStatement.setInt(2, idAcc);
			callableStatement.executeUpdate();
			return true;
		} catch (SQLException sqlex) {
			return false;
		}
	}

	@Override
	public boolean likePostFromAccount(int idPost, Integer idAcc) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			CallableStatement callableStatement = connection
					.prepareCall("execute p_likeOrUnlikePost  @id_post=?, @id_acc=?");
			callableStatement.setInt(1, idPost);
			callableStatement.setInt(2, idAcc);
			int numberRowEffected = callableStatement.executeUpdate();
			return numberRowEffected > 0 ? true : false;
		} catch (SQLException sqlex) {
			sqlex.printStackTrace();
			return false;
		}
	}

	@Override
	public List<Account> getListAccountLike(int idPost) {
		return postR.getListAccountLike(idPost);
	}

	@Override
	public List<PostRoom> getPostOfUser(int idAcc) {
		List<Room> listRoomManage = roomS.getListRoomManager(idAcc);
		List<Room> listRoomPar = roomS.getListRoomParticipation(idAcc);

		Set<Integer> listRoom = new HashSet<>();
		List<PostRoom> result = new ArrayList<>();

		for (Room room : listRoomManage) {
			listRoom.add(room.getIdRoom());
		}
		for (Room room : listRoomPar) {
			listRoom.add(room.getIdRoom());
		}

		for (Integer integer : listRoom) {
			List<PostRoom> listPostInRoom = roomS.getListPostRoom(integer);
			if (listPostInRoom != null && !listPostInRoom.isEmpty()) {
				result.add(listPostInRoom.get(0));
			}

		}

		Collections.sort(result, new Comparator<PostRoom>() {

			@Override
			public int compare(PostRoom o1, PostRoom o2) {
				return o2.getContent().getPostDate().compareTo(o1.getContent().getPostDate());
			}
		});

		return result;
	}

}
