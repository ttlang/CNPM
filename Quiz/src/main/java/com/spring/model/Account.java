package com.spring.model;

public class Account {
	private int idAcc;
	private String email;
	private String name;
	private String avatar;
	private String job;
	private boolean gender;
	private String address;
	private int DapAn;

	public Account(int idAcc, String email, String name, String avatar, String job, boolean gender, String address) {
		super();
		this.idAcc = idAcc;
		this.email = email;
		this.name = name;
		this.avatar = avatar;
		this.job = job;
		this.gender = gender;
		this.address = address;
	}

	public Account(int idAcc, String email, String name, String avatar) {
		super();
		this.idAcc = idAcc;
		this.email = email;
		this.name = name;
		this.avatar = avatar;
	}
	
	

	public Account(int idAcc, String email, String name, String avatar, String job, boolean gender, String address,
			int dapAn) {
		super();
		this.idAcc = idAcc;
		this.email = email;
		this.name = name;
		this.avatar = avatar;
		this.job = job;
		this.gender = gender;
		this.address = address;
		DapAn = dapAn;
	}

	public int getDapAn() {
		return DapAn;
	}

	public void setDapAn(int dapAn) {
		DapAn = dapAn;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public boolean isGender() {
		return gender;
	}

	public void setGender(boolean gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getIdAcc() {
		return idAcc;
	}

	public void setIdAcc(int idAcc) {
		this.idAcc = idAcc;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

}
