package com.nlu.model;

public class MemberDao {
	private int idAcc;
	private String name;
	private String avatar;
	private boolean gender;
	private String email;

	public int getIdAcc() {
		return idAcc;
	}

	public void setIdAcc(int idAcc) {
		this.idAcc = idAcc;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "MemberDao [idAcc=" + idAcc + ", name=" + name + ", avatar=" + avatar + ", gender=" + gender + ", email="
				+ email + "]";
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public boolean isGender() {
		return gender;
	}

	public void setGender(boolean gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
