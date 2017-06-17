package com.spring.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "post")
@NamedQueries({ @NamedQuery(name = "Post.findAll", query = "SELECT p FROM Post p"),
		@NamedQuery(name = "Post.findByIdPost", query = "SELECT p FROM Post p WHERE p.idPost = :idPost"),
		@NamedQuery(name = "Post.findByPostContent", query = "SELECT p FROM Post p WHERE p.postContent = :postContent"),
		@NamedQuery(name = "Post.findByPostDate", query = "SELECT p FROM Post p WHERE p.postDate = :postDate"),
		@NamedQuery(name = "Post.findByIdConnect", query = "SELECT p FROM Post p WHERE p.idConnect = :idConnect") })
public class Post implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@NotNull
	@Column(name = "id_post", nullable = false)
	private Integer idPost;
	@Basic(optional = false)
	@NotNull
	@Size(min = 1, max = 1073741823)
	@Column(name = "post_content")
	private String postContent;
	@Basic(optional = false)
	@NotNull
	@Column(name = "post_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date postDate;
	@Basic(optional = false)
	@NotNull
	@Column(name = "id_connect", nullable = false)
	private int idConnect;
	@JoinTable(name = "post_manage", joinColumns = {
			@JoinColumn(name = "id_post", referencedColumnName = "id_post") }, inverseJoinColumns = {
					@JoinColumn(name = "id_room", referencedColumnName = "id_room") })
	@ManyToMany
	private List<Room> roomList;
	@ManyToMany(mappedBy = "postListLike")
	private List<Account> accountList;
	@JoinColumn(name = "id_acc", referencedColumnName = "id_acc", nullable = false)
	@ManyToOne(optional = false)
	private Account idAcc;
	@JoinColumn(name = "id_post_type", referencedColumnName = "param_name", nullable = false)
	@ManyToOne(optional = false)
	private ClList2 idPostType;
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "idPost")
	private List<Comment> commentList;

	public Post() {
	}

	public Post(Integer idPost) {
		this.idPost = idPost;
	}

	public Post(Integer idPost, String postContent, Date postDate, int idConnect) {
		this.idPost = idPost;
		this.postContent = postContent;
		this.postDate = postDate;
		this.idConnect = idConnect;

	}

	public Integer getIdPost() {
		return idPost;
	}

	public void setIdPost(Integer idPost) {
		this.idPost = idPost;
	}

	public String getPostContent() {
		return postContent;
	}

	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}

	public Date getPostDate() {
		return postDate;
	}

	public void setPostDate(Date postDate) {
		this.postDate = postDate;
	}

	public int getIdConnect() {
		return idConnect;
	}

	public void setIdConnect(int idConnect) {
		this.idConnect = idConnect;
	}

	public List<Room> getRoomList() {
		return roomList;
	}

	public void setRoomList(List<Room> roomList) {
		this.roomList = roomList;
	}

	public List<Account> getAccountList() {
		return accountList;
	}

	public void setAccountList(List<Account> accountList) {
		this.accountList = accountList;
	}

	public Account getIdAcc() {
		return idAcc;
	}

	public void setIdAcc(Account idAcc) {
		this.idAcc = idAcc;
	}

	public ClList2 getIdPostType() {
		return idPostType;
	}

	public void setIdPostType(ClList2 idPostType) {
		this.idPostType = idPostType;
	}

	public List<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	
	
	@Override
	public int hashCode() {
		int hash = 0;
		hash += (idPost != null ? idPost.hashCode() : 0);
		return hash;
	}

	@Override
	public boolean equals(Object object) {
		// TODO: Warning - this method won't work in the case the id fields are
		// not set
		if (!(object instanceof Post)) {
			return false;
		}
		Post other = (Post) object;
		if ((this.idPost == null && other.idPost != null)
				|| (this.idPost != null && !this.idPost.equals(other.idPost))) {
			return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "com.spring.domain.Post[ idPost=" + idPost + " ]";
	}

}
