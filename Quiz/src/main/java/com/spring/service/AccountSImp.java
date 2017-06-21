package com.spring.service;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.internal.SessionImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.domain.Account;
import com.spring.domain.Room;
import com.spring.repository.AccountR;

@Service
@Transactional
public class AccountSImp implements AccountS {
	@Autowired
	private AccountR r;
	@Autowired
	private SessionFactory sf;

	@Override
	public boolean checkEmail(String email) {
		List<Account> lAccount = r.searchByEmail(email);
		return (lAccount.size() > 0) ? true : false;
	}

	@Override
	public boolean checkEmailAndPassword(String email, String password) {

		List<Account> lAccount = r.searchByEmail(email, password);
		return (lAccount.size() > 0) ? true : false;
	}

	@Override
	public Account getAccountByEmail(String email) {

		return r.searchByEmail(email).get(0);
	}

	@Override
	public int SignUp(String email, String password) {
		SessionImpl impl = (SessionImpl) sf.getCurrentSession();
		Connection connection = impl.connection();
		int idAccount = 0;
		try {
			CallableStatement statement = connection.prepareCall("execute p_signUp_account ?,?");
			statement.setString(1, email);
			statement.setString(2, password);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				idAccount = rs.getInt(1);
			}
			

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return idAccount;
	}

	@Override
	public String checkLogin(String email, String password) {
		String message = "";
		SessionImpl impl = (SessionImpl) sf.getCurrentSession();
		Connection connection = impl.connection();
		try {
			CallableStatement statement = connection.prepareCall("execute p_checkLogIn_account ?,?");
			statement.setString(1, email);
			statement.setString(2, password);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				message = rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return message;
	}

	@Override
	public Account getAccountByID(int id) {
		return r.findOne(id);
	}

	@Override
	public int enableAccount(int idAccount, boolean state) {
		Query query = sf.getCurrentSession().createQuery("UPDATE Account SET state=:state WHERE idAcc=:idAcc ")
				.setBoolean("state", state).setInteger("idAcc", idAccount);
		return query.executeUpdate();
	}

	@Override
	public int changePassword(int IdAccount, String NewPassword) {
		Query query = sf.getCurrentSession().createQuery("UPDATE Account SET password=:password WHERE idAcc=:idAcc");
		query.setInteger("idAcc", IdAccount);
		query.setString("password", NewPassword);
		return query.executeUpdate();
	}

	@Override
	public int changePassword(String email, String NewPassword) {
		Query query = sf.getCurrentSession().createQuery("UPDATE Account SET password=:password WHERE email=:email");
		query.setString("email", email);
		query.setString("password", NewPassword);
		return query.executeUpdate();
	}

	@Override
	public boolean checkIsAdmin(int IDAccount, int IdRoom) {
		List<Room> listRoomManage = r.getListRoomManager(IDAccount);
		for (Room room : listRoomManage) {
			if (room.getIdRoom() == IdRoom) {
				return true;
			}
		}
		return false;
	}

	@Override
	public boolean updateAccountInfo(String name, Date birth, String job, boolean gender, String address,
			int idAccount) {
		return (r.updateAccountInfo(name, birth, job, gender, address, idAccount) > 0) ? true : false;
	}

	@Override
	public boolean updateAccountAvatar(String avatarLink, int idAccount) {
		return r.updateAccountAvatar(avatarLink, idAccount) > 0 ? true : false;

	}

	@Override
	public void sendRequestAddFriend(int idAdd, int idFriend) throws SQLException {
		/**
		 * thêm 1 dòng vào db relationship(idadd, idfriend)
		 */
		SessionImpl impl = (SessionImpl) sf.getCurrentSession();
		Connection connection = impl.connection();
		CallableStatement statement = connection
				.prepareCall("insert into relationship(id_acc_add, id_acc_friend,waiting)  values(?,?,?)");
		statement.setInt(1, idAdd);
		statement.setInt(2, idFriend);
		statement.setBoolean(3, true);
		statement.executeUpdate();

	}

	@Override
	public void deleteRelationship(int idAdd, int idFriend) throws SQLException {
		/**
		 * xóa quan hệ giữa 2nguowif
		 * relationship(idAdd,idFriend),relationship(idFriend,idAdd)
		 */
		SessionImpl impl = (SessionImpl) sf.getCurrentSession();
		Connection connection = impl.connection();
		CallableStatement statement = connection.prepareCall(
				"delete from relationship where (id_acc_add=?  and id_acc_friend=?) or (id_acc_add=?  and id_acc_friend=?)");
		statement.setInt(1, idAdd);
		statement.setInt(2, idFriend);
		statement.setInt(3, idFriend);
		statement.setInt(4, idAdd);
		int a = statement.executeUpdate();
		System.out.printf("Đã xóa quan hệ bạn bè %d dòng của bạn và tôi!\n ", a);
	}

	@Override
	public void acceptRequestAddFriend(int idAdd, int idFriend) throws SQLException {
		/**
		 * chỉnh relationship(idadd, idfrien, true) insert
		 * relationship(idadd,idfrien,true)
		 */
		SessionImpl impl = (SessionImpl) sf.getCurrentSession();
		Connection connection = impl.connection();
		CallableStatement statement = connection
				.prepareCall("exec [dbo].[p_friend_except] @id_acc_add = ?,	@id_acc_friend = ?");
		statement.setInt(1, idFriend);
		statement.setInt(2, idAdd);
		statement.executeUpdate();
	}

	@Override
	public void deleteRequestAddFriend(int idAdd, int idFriend) throws SQLException {
		SessionImpl impl = (SessionImpl) sf.getCurrentSession();
		Connection connection = impl.connection();
		CallableStatement statement = connection
				.prepareCall("delete from relationship where (id_acc_add=?  and id_acc_friend=?  and  waiting=1) ");
		statement.setInt(1, idAdd);
		statement.setInt(2, idFriend);

		int a = statement.executeUpdate();
		System.out.printf("Đã xóa yê cầu kết bạn %d dòng của bạn và tôi!\n ", a);

	}
}
