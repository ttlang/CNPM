/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.spring.domain;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 *
 * @author Mr.Teo
 */
@Embeddable
public class RelationshipPK implements Serializable {

    @Basic(optional = false)
    @Column(name = "id_acc_add", nullable = false)
    private int idAccAdd;
    @Basic(optional = false)
    @Column(name = "id_acc_friend", nullable = false)
    private int idAccFriend;

    public RelationshipPK() {
    }

    public RelationshipPK(int idAccAdd, int idAccFriend) {
        this.idAccAdd = idAccAdd;
        this.idAccFriend = idAccFriend;
    }

    public int getIdAccAdd() {
        return idAccAdd;
    }

    public void setIdAccAdd(int idAccAdd) {
        this.idAccAdd = idAccAdd;
    }

    public int getIdAccFriend() {
        return idAccFriend;
    }

    public void setIdAccFriend(int idAccFriend) {
        this.idAccFriend = idAccFriend;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idAccAdd;
        hash += (int) idAccFriend;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RelationshipPK)) {
            return false;
        }
        RelationshipPK other = (RelationshipPK) object;
        if (this.idAccAdd != other.idAccAdd) {
            return false;
        }
        if (this.idAccFriend != other.idAccFriend) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "\u00e1dasd.RelationshipPK[ idAccAdd=" + idAccAdd + ", idAccFriend=" + idAccFriend + " ]";
    }
    
}
