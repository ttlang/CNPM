/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.spring.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Huynh Thanh
 */
@Entity
@Table(name = "chatdetails")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Chatdetails.findAll", query = "SELECT c FROM Chatdetails c")
    , @NamedQuery(name = "Chatdetails.findByDetailsChatId", query = "SELECT c FROM Chatdetails c WHERE c.detailsChatId = :detailsChatId")
    , @NamedQuery(name = "Chatdetails.findByBody", query = "SELECT c FROM Chatdetails c WHERE c.body = :body")
    , @NamedQuery(name = "Chatdetails.findByTimeOn", query = "SELECT c FROM Chatdetails c WHERE c.timeOn = :timeOn")
    , @NamedQuery(name = "Chatdetails.findByUrl", query = "SELECT c FROM Chatdetails c WHERE c.url = :url")
    , @NamedQuery(name = "Chatdetails.findByClientId", query = "SELECT c FROM Chatdetails c WHERE c.clientId = :clientId")})
public class Chatdetails implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "details_chat_id", nullable = false)
    private Integer detailsChatId;
    @Column(name = "body", length = 1073741823)
    private String body;
    @Column(name = "time_on")
    @Temporal(TemporalType.TIMESTAMP)
    private Date timeOn;
    @Column(name = "url", length = 255)
    private String url;
    @Column(name = "client_id", length = 255)
    private String clientId;
    @JoinColumn(name = "chat_id", referencedColumnName = "chat_id")
    @ManyToOne
    private Chat chatId;

    public Chatdetails() {
    }

    public Chatdetails(Integer detailsChatId) {
        this.detailsChatId = detailsChatId;
    }

    public Integer getDetailsChatId() {
        return detailsChatId;
    }

    public void setDetailsChatId(Integer detailsChatId) {
        this.detailsChatId = detailsChatId;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public Date getTimeOn() {
        return timeOn;
    }

    public void setTimeOn(Date timeOn) {
        this.timeOn = timeOn;
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

    public Chat getChatId() {
        return chatId;
    }

    public void setChatId(Chat chatId) {
        this.chatId = chatId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (detailsChatId != null ? detailsChatId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Chatdetails)) {
            return false;
        }
        Chatdetails other = (Chatdetails) object;
        if ((this.detailsChatId == null && other.detailsChatId != null) || (this.detailsChatId != null && !this.detailsChatId.equals(other.detailsChatId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.nlu.dao.entity.Chatdetails[ detailsChatId=" + detailsChatId + " ]";
    }
    
}
