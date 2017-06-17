package com.spring.domain;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

@Embeddable
public class RoomManagePK implements Serializable {

	private static final long serialVersionUID = 1L;
	@Basic(optional = false)
	@NotNull
	@Column(name = "id_room", nullable = false)
	private int idRoom;
	@Basic(optional = false)
	@NotNull
	@Column(name = "id_acc", nullable = false)
	private int idAcc;

	public RoomManagePK() {
	}

	public RoomManagePK(int idRoom, int idAcc) {
		this.idRoom = idRoom;
		this.idAcc = idAcc;
	}

	public int getIdRoom() {
		return idRoom;
	}

	public void setIdRoom(int idRoom) {
		this.idRoom = idRoom;
	}

	public int getIdAcc() {
		return idAcc;
	}

	public void setIdAcc(int idAcc) {
		this.idAcc = idAcc;
	}

	@Override
	public int hashCode() {
		int hash = 0;
		hash += (int) idRoom;
		hash += (int) idAcc;
		return hash;
	}

	@Override
	public boolean equals(Object object) {
		// TODO: Warning - this method won't work in the case the id fields are
		// not set
		if (!(object instanceof RoomManagePK)) {
			return false;
		}
		RoomManagePK other = (RoomManagePK) object;
		if (this.idRoom != other.idRoom) {
			return false;
		}
		if (this.idAcc != other.idAcc) {
			return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "com.spring.domain.RoomManagePK[ idRoom=" + idRoom + ", idAcc=" + idAcc + " ]";
	}

}
