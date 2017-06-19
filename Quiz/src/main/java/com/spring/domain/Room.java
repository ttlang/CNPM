package com.spring.domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "room")
@NamedQueries({
    @NamedQuery(name = "Room.findAll", query = "SELECT r FROM Room r")
    , @NamedQuery(name = "Room.findByIdRoom", query = "SELECT r FROM Room r WHERE r.idRoom = :idRoom")
    , @NamedQuery(name = "Room.findByRoomName", query = "SELECT r FROM Room r WHERE r.roomName = :roomName")
    , @NamedQuery(name = "Room.findByRoomDescr", query = "SELECT r FROM Room r WHERE r.roomDescr = :roomDescr")})
public class Room implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_room", nullable = false)
    private Integer idRoom;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "room_name", nullable = false, length = 50)
    private String roomName;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "room_descr", nullable = false, length = 100)
    private String roomDescr;
    @ManyToMany(mappedBy = "roomList")
    private List<Post> postList;
    @JoinColumn(name = "id_acc", referencedColumnName = "id_acc", nullable = false)
    @ManyToOne(optional = false)
    private Account idAcc;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "room")
    private List<RoomManage> roomManageList;

    public Room() {
    }

    public Room(Integer idRoom) {
        this.idRoom = idRoom;
    }

    public Room(Integer idRoom, String roomName, String roomDescr) {
        this.idRoom = idRoom;
        this.roomName = roomName;
        this.roomDescr = roomDescr;
    }

    public Integer getIdRoom() {
        return idRoom;
    }

    public void setIdRoom(Integer idRoom) {
        this.idRoom = idRoom;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public String getRoomDescr() {
        return roomDescr;
    }

    public void setRoomDescr(String roomDescr) {
        this.roomDescr = roomDescr;
    }

    public List<Post> getPostList() {
        return postList;
    }

    public void setPostList(List<Post> postList) {
        this.postList = postList;
    }

    public Account getIdAcc() {
        return idAcc;
    }

    public void setIdAcc(Account idAcc) {
        this.idAcc = idAcc;
    }

    public List<RoomManage> getRoomManageList() {
        return roomManageList;
    }

    public void setRoomManageList(List<RoomManage> roomManageList) {
        this.roomManageList = roomManageList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRoom != null ? idRoom.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof Room)) {
            return false;
        }
        Room other = (Room) object;
        if ((this.idRoom == null && other.idRoom != null) || (this.idRoom != null && !this.idRoom.equals(other.idRoom))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.spring.domain.Room[ idRoom=" + idRoom + " ]";
    }
    
}
