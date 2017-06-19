package com.nlu.model;

public class MailBoxDao {
	int chatId ;
	String code ;
	String roomId ;
	int countMsg ;
	String lastUser ;
	public int getChatId() {
		return chatId;
	}
	public void setChatId(int chatId) {
		this.chatId = chatId;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public int getCountMsg() {
		return countMsg;
	}
	public void setCountMsg(int countMsg) {
		this.countMsg = countMsg;
	}
	public String getLastUser() {
		return lastUser;
	}
	public void setLastUser(String lastUser) {
		this.lastUser = lastUser;
	}
	

}
