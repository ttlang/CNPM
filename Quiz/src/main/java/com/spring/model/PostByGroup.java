package com.spring.model;

import java.util.Date;

public class PostByGroup {
	private int idPost;
	private String postContent;
	private Date postDate;
	private int idAcc;
	private String typePost;
	private String answer1;
	private String answer2;
	private String answer3;
	private String answer4;
	public PostByGroup(int idPost, String postContent, Date postDate, int idAcc, String typePost, String answer1,
			String answer2, String answer3, String answer4) {
		super();
		this.idPost = idPost;
		this.postContent = postContent;
		this.postDate = postDate;
		this.idAcc = idAcc;
		this.typePost = typePost;
		this.answer1 = answer1;
		this.answer2 = answer2;
		this.answer3 = answer3;
		this.answer4 = answer4;
	}
	public int getIdPost() {
		return idPost;
	}
	public void setIdPost(int idPost) {
		this.idPost = idPost;
	}
	public String getPostContent() {
		return postContent;
	}
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	public Date getPostDate() {
		return postDate;
	}
	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}
	public int getIdAcc() {
		return idAcc;
	}
	public void setIdAcc(int idAcc) {
		this.idAcc = idAcc;
	}
	public String getTypePost() {
		return typePost;
	}
	public void setTypePost(String typePost) {
		this.typePost = typePost;
	}
	public String getAnswer1() {
		return answer1;
	}
	public void setAnswer1(String answer1) {
		this.answer1 = answer1;
	}
	public String getAnswer2() {
		return answer2;
	}
	public void setAnswer2(String answer2) {
		this.answer2 = answer2;
	}
	public String getAnswer3() {
		return answer3;
	}
	public void setAnswer3(String answer3) {
		this.answer3 = answer3;
	}
	public String getAnswer4() {
		return answer4;
	}
	public void setAnswer4(String answer4) {
		this.answer4 = answer4;
	}
	
	

}
