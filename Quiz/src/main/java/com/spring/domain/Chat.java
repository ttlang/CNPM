/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.spring.domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Huynh Thanh
 */
@Entity
@Table(name = "chat")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Chat.findAll", query = "SELECT c FROM Chat c")
    , @NamedQuery(name = "Chat.findByChatId", query = "SELECT c FROM Chat c WHERE c.chatId = :chatId")
    , @NamedQuery(name = "Chat.findByCode", query = "SELECT c FROM Chat c WHERE c.code = :code")
    , @NamedQuery(name = "Chat.findByRoomId", query = "SELECT c FROM Chat c WHERE c.roomId = :roomId")
    , @NamedQuery(name = "Chat.findByCountMsg", query = "SELECT c FROM Chat c WHERE c.countMsg = :countMsg")
    , @NamedQuery(name = "Chat.findByLastUser", query = "SELECT c FROM Chat c WHERE c.lastUser = :lastUser")})
public class Chat implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "chat_id", nullable = false)
    private Integer chatId;
    @Basic(optional = false)
    @Column(name = "code", nullable = false, length = 2147483647)
    private String code;
    @Basic(optional = false)
    @Column(name = "room_id", nullable = false, length = 2147483647)
    private String roomId;
    @Column(name = "COUNT_MSG")
    private Integer countMsg;
    @Column(name = "LAST_USER", length = 2147483647)
    private String lastUser;
    @OneToMany(mappedBy = "chatId")
    private List<Chatdetails> chatdetailsList;

    public Chat() {
    }

    public Chat(Integer chatId) {
        this.chatId = chatId;
    }

    public Chat(Integer chatId, String code, String roomId) {
        this.chatId = chatId;
        this.code = code;
        this.roomId = roomId;
    }

    public Integer getChatId() {
        return chatId;
    }

    public void setChatId(Integer chatId) {
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

    public Integer getCountMsg() {
        return countMsg;
    }

    public void setCountMsg(Integer countMsg) {
        this.countMsg = countMsg;
    }

    public String getLastUser() {
        return lastUser;
    }

    public void setLastUser(String lastUser) {
        this.lastUser = lastUser;
    }

    @XmlTransient
    public List<Chatdetails> getChatdetailsList() {
        return chatdetailsList;
    }

    public void setChatdetailsList(List<Chatdetails> chatdetailsList) {
        this.chatdetailsList = chatdetailsList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (chatId != null ? chatId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Chat)) {
            return false;
        }
        Chat other = (Chat) object;
        if ((this.chatId == null && other.chatId != null) || (this.chatId != null && !this.chatId.equals(other.chatId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.nlu.dao.entity.Chat[ chatId=" + chatId + " ]";
    }
    
}
