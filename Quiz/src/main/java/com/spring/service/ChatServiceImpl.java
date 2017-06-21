package com.spring.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.internal.SessionImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nlu.model.ChatDao;
import com.nlu.model.MailBoxDao;
import com.nlu.model.MemberDao;

@Service
@Transactional
public class ChatServiceImpl implements ChatService {
	@Autowired
	SessionFactory sf;

	@Override
	public boolean themNoiDung(String from, String to, String body, String url) throws SQLException {
		// TODO Auto-generated method stub
		Session session = sf.getCurrentSession();
		SessionImpl sessionImpl = (SessionImpl) session;
		Connection conn = sessionImpl.connection();
		CallableStatement callableStatement;
		conn.setAutoCommit(false);
		conn.getTransactionIsolation();
		try {
			callableStatement = conn.prepareCall("themnoidung  ?  , ?  , ? ,? ");
			callableStatement.setString(1, from);
			callableStatement.setString(2, to);
			callableStatement.setString(3, body);
			callableStatement.setString(4, url);
			callableStatement.execute();
			conn.commit();
			return true;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			conn.commit();
			return false;
		}

	}

	@Override
	public List<ChatDao> loadNotify(String client1, String client2, int top) throws SQLException {
		// TODO Auto-generated method stub
		Session session = sf.getCurrentSession();
		SessionImpl sessionImpl = (SessionImpl) session;
		Connection conn = sessionImpl.connection();
		CallableStatement callableStatement;
		List<ChatDao> res = new ArrayList<>();
		conn.setAutoCommit(false);
		conn.getTransactionIsolation();
		try {
			callableStatement = conn.prepareCall((top == -1) ? "box_notify ? ,? " : "box_notify ? ,? , ?");
			callableStatement.setNString(1, client1);
			callableStatement.setNString(2, client2);
			if (top != -1) {
				callableStatement.setInt(3, top);
			}

			ResultSet rs = callableStatement.executeQuery();
			while (rs.next()) {
				ChatDao temp = new ChatDao(rs.getString(1), rs.getDate(2), rs.getString(3), rs.getString(4));
				temp.setCode(rs.getString(5));
				res.add(temp);
			}

		} catch (Exception e) {
			// TODO: handle except.ion
			e.printStackTrace();
		}
		conn.commit();
		return res;
	}

	@Override
	public List<ChatDao> tinNhan(String client1, String client2, int top) throws SQLException {
		// TODO Auto-generated method stub
		Session session = sf.getCurrentSession();
		SessionImpl sessionImpl = (SessionImpl) session;
		Connection conn = sessionImpl.connection();
		CallableStatement callableStatement;
		List<ChatDao> res = new ArrayList<>();
		conn.setAutoCommit(false);
		conn.getTransactionIsolation();
		try {
			callableStatement = conn.prepareCall((top == -1) ? "box_msg ? ,? " : "box_msg ? ,? , ?");
			callableStatement.setNString(1, client1);
			callableStatement.setNString(2, client2);
			if (top != -1) {
				callableStatement.setInt(3, top);
			}

			ResultSet rs = callableStatement.executeQuery();
			while (rs.next()) {
				ChatDao temp = new ChatDao(rs.getString(1), rs.getDate(2), rs.getString(3), rs.getString(4));
				res.add(temp);
			}

		} catch (Exception e) {
			// TODO: handle except.ion
			e.printStackTrace();
		}
		conn.commit();
		return res;
	}

	@Override
	public List<MailBoxDao> findMailBox(String user_id) throws SQLException {
		// TODO Auto-generated method stub
		Session session = sf.getCurrentSession();
		SessionImpl sessionImpl = (SessionImpl) session;
		Connection conn = sessionImpl.connection();
		CallableStatement callableStatement = conn.prepareCall("kiemtratinnhan ?");
		callableStatement.setString(1, user_id);
		List<MailBoxDao> res = new ArrayList<>();
		MailBoxDao temp = null;
		ResultSet rs = callableStatement.executeQuery();

		while (rs.next()) {

			temp = new MailBoxDao();
			temp.setChatId(rs.getInt(1));
			temp.setCode(rs.getString(2));
			temp.setRoomId(rs.getString(3));
			temp.setCountMsg(rs.getInt(4));
			temp.setLastUser(rs.getString(5));
			res.add(temp);
		}

		return res;
	}

	@Override
	public List<MemberDao> danhSachChat(int magv) throws SQLException {
		// TODO Auto-generated method stub
		Session session = sf.getCurrentSession();
		SessionImpl sessionImpl = (SessionImpl) session;
		Connection conn = sessionImpl.connection();
		CallableStatement callableStatement = conn.prepareCall("danhsachgiangvien ?");
		callableStatement.setInt(1, magv);
		List<MemberDao> res = new ArrayList<>();
		ResultSet rs = callableStatement.executeQuery();
		MemberDao temp;
		while (rs.next()) {
			temp = new MemberDao();
			temp.setMagv(rs.getInt(1));
			temp.setHogv(rs.getString(2));
			temp.setTengv(rs.getString(3));
			temp.setAnhgv(rs.getString(4));
			temp.setGioitinh(rs.getBoolean(5));
			temp.setEmail(rs.getString(6));
			res.add(temp);
		}
		return res;
	}

	@Override
	public List<MailBoxDao> numberNotify(String user_id) throws SQLException {
		Session session = sf.getCurrentSession();
		SessionImpl sessionImpl = (SessionImpl) session;
		Connection conn = sessionImpl.connection();
		CallableStatement callableStatement = conn.prepareCall("kiemtrathongbao ?");
		callableStatement.setString(1, user_id);
		List<MailBoxDao> res = new ArrayList<>();
		MailBoxDao temp = null;
		ResultSet rs = callableStatement.executeQuery();
		while (rs.next()) {
			temp = new MailBoxDao();
			temp.setChatId(rs.getInt(1));
			temp.setCode(rs.getString(2));
			temp.setRoomId(rs.getString(3));
			temp.setCountMsg(rs.getInt(4));
			temp.setLastUser(rs.getString(5));
			res.add(temp);
		}

		return res;
	}
}
