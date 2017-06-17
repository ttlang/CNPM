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
public class CommentSImp implements CommnentS {
	@Autowired
	private SessionFactory sf;

	@Override
	public boolean deleteComment(int idComment, int idAcc) {
		SessionImpl session = (SessionImpl) sf.getCurrentSession();
		Connection connection = session.connection();
		try {
			CallableStatement callableStatement = connection
					.prepareCall("execute p_deleteComment_Comment @id_comment=?,@id_acc=?");
			callableStatement.setInt(1, idComment);
			callableStatement.setInt(2, idAcc);
			int resultSet = callableStatement.executeUpdate();

			return resultSet > 0 ? true : false;
		} catch (SQLException sqlex) {
			sqlex.printStackTrace();
			return false;
		}

	}

}
