package com.spring.model;

import com.spring.domain.Post;

public class PostRoom {
	private Post content;
	private String da1;
	private String da2;
	private String da3;
	private String da4;
	public void setContent(Post content) {
		this.content = content;
	}
	public void setDa1(String da1) {
		this.da1 = da1;
	}
	public void setDa2(String da2) {
		this.da2 = da2;
	}
	public void setDa3(String da3) {
		this.da3 = da3;
	}
	public void setDa4(String da4) {
		this.da4 = da4;
	}
	
	public Post getContent() {
		return content;
	}
	public String getDa1() {
		return da1;
	}
	public String getDa2() {
		return da2;
	}
	public String getDa3() {
		return da3;
	}
	public String getDa4() {
		return da4;
	}
	public PostRoom(){
		
	}
	public PostRoom(Post content, String da1, String da2, String da3, String da4) {
		this.content = content;
		this.da1 = da1;
		this.da2 = da2;
		this.da3 = da3;
		this.da4 = da4;
	}

	
}
