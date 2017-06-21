package com.spring.domain;
 
 import java.io.Serializable;
 import javax.persistence.Column;
 import javax.persistence.EmbeddedId;
 import javax.persistence.Entity;
 import javax.persistence.JoinColumn;
 import javax.persistence.ManyToOne;
 import javax.persistence.NamedQueries;
 import javax.persistence.NamedQuery;
 import javax.persistence.Table;
 
 /**
  *
  * @author Mr.Teo
  */
 @Entity
 @Table(name = "relationship", catalog = "Quiz", schema = "dbo")
 @NamedQueries({ @NamedQuery(name = "Relationship.findAll", query = "SELECT r FROM Relationship r"),
 		@NamedQuery(name = "Relationship.findByIdAccAdd", query = "SELECT r FROM Relationship r WHERE r.relationshipPK.idAccAdd = :idAccAdd"),
 		@NamedQuery(name = "Relationship.findByIdAccFriend", query = "SELECT r FROM Relationship r WHERE r.relationshipPK.idAccFriend = :idAccFriend"),
 		@NamedQuery(name = "Relationship.findByWaiting", query = "SELECT r FROM Relationship r WHERE r.waiting = :waiting") })
 public class Relationship implements Serializable {
 
 	private static final long serialVersionUID = 1L;
 	@EmbeddedId
 	protected RelationshipPK relationshipPK;
 	@Column(name = "waiting")
 	private Boolean waiting;
 	@JoinColumn(name = "id_acc_add", referencedColumnName = "id_acc", nullable = false, insertable = false, updatable = false)
 	@ManyToOne(optional = false)
 	private Account accountAdd;
 	@JoinColumn(name = "id_acc_friend", referencedColumnName = "id_acc", nullable = false, insertable = false, updatable = false)
 	@ManyToOne(optional = false)
 	private Account accountFriend;
 
 	public Account getAccountAdd() {
 		return accountAdd;
 	}
 
 	public void setAccountAdd(Account accountAdd) {
 		this.accountAdd = accountAdd;
 	}
 
 	public Account getAccountFriend() {
 		return accountFriend;
 	}
 
 	public void setAccountFriend(Account accountFriend) {
 		this.accountFriend = accountFriend;
 	}
 
 	public Relationship() {
 	}
 
 	public Relationship(RelationshipPK relationshipPK) {
 		this.relationshipPK = relationshipPK;
 	}
 
 	public Relationship(int idAccAdd, int idAccFriend) {
 		this.relationshipPK = new RelationshipPK(idAccAdd, idAccFriend);
 	}
 
 	public RelationshipPK getRelationshipPK() {
 		return relationshipPK;
 	}
 
 	public void setRelationshipPK(RelationshipPK relationshipPK) {
 		this.relationshipPK = relationshipPK;
 	}
 
 	public Boolean getWaiting() {
 		return waiting;
 	}
 
 	public void setWaiting(Boolean waiting) {
 		this.waiting = waiting;
 	}
 
 
 
 
 	@Override
 	public int hashCode() {
 		int hash = 0;
 		hash += (relationshipPK != null ? relationshipPK.hashCode() : 0);
 		return hash;
 	}
 
 	@Override
 	public boolean equals(Object object) {
 		// TODO: Warning - this method won't work in the case the id fields are
 		// not set
 		if (!(object instanceof Relationship)) {
 			return false;
 		}
 		Relationship other = (Relationship) object;
 		if ((this.relationshipPK == null && other.relationshipPK != null)
 				|| (this.relationshipPK != null && !this.relationshipPK.equals(other.relationshipPK))) {
 			return false;
 		}
 		return true;
 	}
 
 	@Override
 	public String toString() {
 		return "\u00e1dasd.Relationship[ relationshipPK=" + relationshipPK + " ]";
 	}
 
 }