package com.spring.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.hibernate.internal.SessionImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class TestServiceImp implements TestService {
	@Autowired
	private SessionFactory sf;

	@Override
	public boolean chooseAnswerInPostQuiz(int idRoom, int idPost, int idAcc, int idDapAn) {
		//String sql = "";
		SessionImpl impl = (SessionImpl) sf.getCurrentSession();
		Connection connection = impl.connection();
		//int idAccount = 0;
		try {
			CallableStatement statement = connection.prepareCall(
					"EXEC [dbo].[p_chooseAnswerInPost] @id_room = ?,	@id_post = ?, @id_acc = ?,	@id_answer = ?");
			statement.setInt(1, idRoom);
			statement.setInt(2, idPost);
			statement.setInt(3, idAcc);
			statement.setInt(4, idDapAn);
			statement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

}
