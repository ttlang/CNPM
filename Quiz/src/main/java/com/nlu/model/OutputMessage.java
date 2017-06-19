package com.nlu.model;

import java.util.Date;

/*
 * Output message sent to client.
 *
 * @Author Jay Sridhar
 */
public class OutputMessage {
	private String from;
	private String message;
	private String topic;
	private Date time = new Date();
	/**
	 * append
	 */
	private int[] listIdAcc;
	private String messageContent;
	private String url;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getMessageContent() {
		return messageContent;
	}

	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}

	public int[] getListIdAcc() {
		return listIdAcc;
	}

	public void setListIdAcc(int[] listIdAcc) {
		this.listIdAcc = listIdAcc;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	/**
	 * *
	 */

	public OutputMessage() {
	}

	public OutputMessage(String from, String message, String topic) {
		this.from = from;
		this.message = message;
		this.topic = topic;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public Date getTime() {
		return time;
	}
}
