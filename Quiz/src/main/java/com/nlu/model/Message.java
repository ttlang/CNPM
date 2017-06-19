package com.nlu.model;

/*
 * Message received from client.
 *
 * @Author Jay Sridhar
 */
public class Message
{
    private String from;
    private String text;
    private String location;

    public Message() {}

    public Message(String from,String text)
    {
	this.from = from;
	this.text = text;
    }

    public Message(String from, String text, String location) {
		this.from = from;
		this.text = text;
		this.location = location;
	}

	public String getFrom()
    {
        return from;
    }

    public void setFrom(String from)
    {
        this.from = from;
    }

    public String getText()
    {
        return text;
    }

    public void setText(String text)
    {
        this.text = text;
    }

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
}
