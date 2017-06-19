package com.spring.domain;

import java.io.Serializable;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(name = "room_manage")
@NamedQueries({
    @NamedQuery(name = "RoomManage.findAll", query = "SELECT r FROM RoomManage r")
    , @NamedQuery(name = "RoomManage.findByIdRoom", query = "SELECT r FROM RoomManage r WHERE r.roomManagePK.idRoom = :idRoom")
    , @NamedQuery(name = "RoomManage.findByIdAcc", query = "SELECT r FROM RoomManage r WHERE r.roomManagePK.idAcc = :idAcc")
    , @NamedQuery(name = "RoomManage.findByState", query = "SELECT r FROM RoomManage r WHERE r.state = :state")})
public class RoomManage implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected RoomManagePK roomManagePK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "state", nullable = false)
    private boolean state;// trạng thái đã tham gia hay chưa
    @JoinColumn(name = "id_acc", referencedColumnName = "id_acc", nullable = false, insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Account account;
    @JoinColumn(name = "id_room", referencedColumnName = "id_room", nullable = false, insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Room room;

    public RoomManage() {
    }

    public RoomManage(RoomManagePK roomManagePK) {
        this.roomManagePK = roomManagePK;
    }

    public RoomManage(RoomManagePK roomManagePK, boolean state) {
        this.roomManagePK = roomManagePK;
        this.state = state;
    }

    public RoomManage(int idRoom, int idAcc) {
        this.roomManagePK = new RoomManagePK(idRoom, idAcc);
    }

    public RoomManagePK getRoomManagePK() {
        return roomManagePK;
    }

    public void setRoomManagePK(RoomManagePK roomManagePK) {
        this.roomManagePK = roomManagePK;
    }

    public boolean getState() {
        return state;
    }

    public void setState(boolean state) {
        this.state = state;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (roomManagePK != null ? roomManagePK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof RoomManage)) {
            return false;
        }
        RoomManage other = (RoomManage) object;
        if ((this.roomManagePK == null && other.roomManagePK != null) || (this.roomManagePK != null && !this.roomManagePK.equals(other.roomManagePK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.spring.domain.RoomManage[ roomManagePK=" + roomManagePK + " ]";
    }
    
}
