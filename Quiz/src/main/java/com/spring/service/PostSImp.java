package com.spring.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.hibernate.internal.SessionImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.Account;
import com.spring.domain.Comment;
import com.spring.domain.Post;
import com.spring.repository.PostR;

@Service
@Transactional
public class PostSImp implements PostS {
	@Autowired
	PostR postR;
	@Autowired
	private SessionFactory sf;

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
			sqlex.printStackTrace();
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

}
