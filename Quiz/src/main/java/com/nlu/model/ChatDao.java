package com.nlu.model;

import java.sql.Date;

public class ChatDao {
	
String body ;
Date date  ;
String url ;
String clientId ;
String urlImg;
	String code;
public String getCode() {
	return code;
}
public void setCode(String code) {
	this.code = code;
}
public String getUrlImg() {
	return urlImg;
}
public void setUrlImg(String urlImg) {
	this.urlImg = urlImg;
}
public ChatDao(String body, Date date, String url  , String clientId) {
	super();
	this.body = body;
	this.date = date;
	this.url = url;
	this.clientId = clientId ;
}
public String getBody() {
	return body;
}
public void setBody(String body) {
	this.body = body;
}
public Date getDate() {
	return date;
}
public void setDate(Date date) {
	this.date = date;
}
public String getUrl() {
	return url;
}
public void setUrl(String url) {
	this.url = url;
}
public String getClientId() {
	return clientId;
}
public void setClientId(String clientId) {
	this.clientId = clientId;
}

}
