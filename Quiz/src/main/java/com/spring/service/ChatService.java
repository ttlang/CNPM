package com.spring.service;

import java.sql.SQLException;
import java.util.List;

import com.nlu.model.ChatDao;
import com.nlu.model.MailBoxDao;
import com.nlu.model.MemberDao;

public interface ChatService {
	public boolean themNoiDung(String from, String to, String body, String url) throws SQLException;

	public List<ChatDao> tinNhan(String client1, String client2, int top) throws SQLException;

	public List<MailBoxDao> findMailBox(String user_id) throws SQLException;

	public List<MemberDao> danhSachChat(int magv) throws SQLException;

	public List<ChatDao> loadNotify(String client1, String client2, int top) throws SQLException;
}
