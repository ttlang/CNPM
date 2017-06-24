package com.spring.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "account", uniqueConstraints = { @UniqueConstraint(columnNames = { "email" }) })
@NamedQueries({ @NamedQuery(name = "Account.findAll", query = "SELECT a FROM Account a"),
		@NamedQuery(name = "Account.findByIdAcc", query = "SELECT a FROM Account a WHERE a.idAcc = :idAcc"),
		@NamedQuery(name = "Account.findByName", query = "SELECT a FROM Account a WHERE a.name = :name"),
		@NamedQuery(name = "Account.findByBirth", query = "SELECT a FROM Account a WHERE a.birth = :birth"),
		@NamedQuery(name = "Account.findByJob", query = "SELECT a FROM Account a WHERE a.job = :job"),
		@NamedQuery(name = "Account.findByGender", query = "SELECT a FROM Account a WHERE a.gender = :gender"),
		@NamedQuery(name = "Account.findByEmail", query = "SELECT a FROM Account a WHERE a.email = :email"),
		@NamedQuery(name = "Account.findByPassword", query = "SELECT a FROM Account a WHERE a.password = :password"),
		@NamedQuery(name = "Account.findByState", query = "SELECT a FROM Account a WHERE a.state = :state"),
		@NamedQuery(name = "Account.findByAddress", query = "SELECT a FROM Account a WHERE a.address = :address"),
		@NamedQuery(name = "Account.findByAvatar", query = "SELECT a FROM Account a WHERE a.avatar = :avatar") })
public class Account implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id_acc", nullable = false)
	private Integer idAcc;
	@Size(max = 100)
	@Column(name = "name", length = 100)
	private String name;
	@Column(name = "birth")
	@Temporal(TemporalType.DATE)
	private Date birth;
	@Size(max = 50)
	@Column(name = "job", length = 50)
	private String job;
	@Column(name = "gender")
	private Boolean gender;
	// @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
	// message="Invalid email")//if the field contains email address consider
	// using this annotation to enforce field validation
	@Basic(optional = false)
	@NotNull
	@Size(min = 1, max = 50)
	@Column(name = "email")
	private String email;
	@Basic(optional = false)
	@NotNull
	@Size(min = 1, max = 50)
	@Column(name = "password")
	private String password;
	@Basic(optional = false)
	@NotNull
	@Column(name = "state", nullable = false)
	private boolean state;
	@Size(max = 300)
	@Column(name = "address", length = 300)
	private String address;
	@Column(name = "avatar", length = 500)
	private String avatar;
	/* join table like */

	@JoinTable(name = "liked", joinColumns = {
			@JoinColumn(name = "id_acc", referencedColumnName = "id_acc") }, inverseJoinColumns = {
					@JoinColumn(name = "id_post", referencedColumnName = "id_post") })
	@ManyToMany
	private List<Post> postListLike;

	/* /join table like */
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "account")
	private List<Task> taskList;
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "idAcc")
	private List<Post> postList;
	@OneToMany(mappedBy = "idAcc")
	private List<Topic> topicList;
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "idAcc")
	private List<Comment> commentList;
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "idAcc")
	private List<Room> roomList; /* danh sách phòng quản lý */
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "account")
	private List<RoomManage> roomManageList; /* Danh sách phòng tham gia */
	// relationship
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "accountAdd")
	private List<Relationship> relationshipList;// danh sách bạn cá nhân
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "accountFriend")
	private List<Relationship> relationshipList1;// danh sách những người

	public List<Relationship> getRelationshipList() {
		return relationshipList;
	}

	public void setRelationshipList(List<Relationship> relationshipList) {
		this.relationshipList = relationshipList;
	}

	public List<Relationship> getRelationshipList1() {
		return relationshipList1;
	}

	public void setRelationshipList1(List<Relationship> relationshipList1) {
		this.relationshipList1 = relationshipList1;
	}
	// ./ end relationship

	public Account() {
	}

	public Account(Integer idAcc) {
		this.idAcc = idAcc;
	}

	public Account(Integer idAcc, String email, String password, boolean state) {
		this.idAcc = idAcc;
		this.email = email;
		this.password = password;
		this.state = state;
	}

	public Integer getIdAcc() {
		return idAcc;
	}

	public void setIdAcc(Integer idAcc) {
		this.idAcc = idAcc;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getBirth() {
		return birth;
	}

	public void setBirth(Date birth) {
		this.birth = birth;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public Boolean getGender() {
		return gender;
	}

	public void setGender(Boolean gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean getState() {
		return state;
	}

	public void setState(boolean state) {
		this.state = state;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public List<Post> getPostListLike() {
		return postListLike;
	}

	public void setPostListLike(List<Post> postListLike) {
		this.postListLike = postListLike;
	}

	public List<Task> getTaskList() {
		return taskList;
	}

	public void setTaskList(List<Task> taskList) {
		this.taskList = taskList;
	}

	public List<Post> getPostList() {
		return postList;
	}

	public void setPostList(List<Post> postList) {
		this.postList = postList;
	}

	public List<Topic> getTopicList() {
		return topicList;
	}

	public void setTopicList(List<Topic> topicList) {
		this.topicList = topicList;
	}

	public List<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}

	public List<Room> getRoomList() {
		return roomList;
	}

	public void setRoomList(List<Room> roomList) {
		this.roomList = roomList;
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
		hash += (idAcc != null ? idAcc.hashCode() : 0);
		return hash;
	}

	@Override
	public boolean equals(Object object) {
		// TODO: Warning - this method won't work in the case the id fields are
		// not set
		if (!(object instanceof Account)) {
			return false;
		}
		Account other = (Account) object;
		if ((this.idAcc == null && other.idAcc != null) || (this.idAcc != null && !this.idAcc.equals(other.idAcc))) {
			return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "com.spring.domain.Account[ idAcc=" + idAcc + " ]";
	}

}
