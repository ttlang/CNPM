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
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "comment")
@NamedQueries({ @NamedQuery(name = "Comment.findAll", query = "SELECT c FROM Comment c"),
		@NamedQuery(name = "Comment.findByCommentContent", query = "SELECT c FROM Comment c WHERE c.commentContent = :commentContent"),
		@NamedQuery(name = "Comment.findByCommentTime", query = "SELECT c FROM Comment c WHERE c.commentTime = :commentTime"),
		@NamedQuery(name = "Comment.findByCommentState", query = "SELECT c FROM Comment c WHERE c.commentState = :commentState"),
		@NamedQuery(name = "Comment.findByIdComment", query = "SELECT c FROM Comment c WHERE c.idComment = :idComment") })
public class Comment implements Serializable {

	private static final long serialVersionUID = 1L;
	@Basic(optional = false)
	@NotNull
	@Size(min = 1, max = 1073741823)
	@Column(name = "comment_content")
	private String commentContent;
	@Basic(optional = false)
	@NotNull
	@Column(name = "comment_time", nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date commentTime;
	@Basic(optional = false)
	@NotNull
	@Column(name = "comment_state", nullable = false)
	private boolean commentState;
	@Id
	@Basic(optional = false)
	@NotNull
	@Column(name = "id_comment", nullable = false)
	private Integer idComment;
	@JoinColumn(name = "id_acc", referencedColumnName = "id_acc", nullable = false)
	@ManyToOne(optional = false)
	private Account idAcc;
	@JoinColumn(name = "id_post", referencedColumnName = "id_post", nullable = false)
	@ManyToOne(optional = false)
	private Post idPost;

	public Comment() {
	}

	public Comment(Integer idComment) {
		this.idComment = idComment;
	}

	public Comment(Integer idComment, String commentContent, Date commentTime, boolean commentState) {
		this.idComment = idComment;
		this.commentContent = commentContent;
		this.commentTime = commentTime;
		this.commentState = commentState;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public Date getCommentTime() {
		return commentTime;
	}

	public void setCommentTime(Date commentTime) {
		this.commentTime = commentTime;
	}

	public boolean getCommentState() {
		return commentState;
	}

	public void setCommentState(boolean commentState) {
		this.commentState = commentState;
	}

	public Integer getIdComment() {
		return idComment;
	}

	public void setIdComment(Integer idComment) {
		this.idComment = idComment;
	}

	public Account getIdAcc() {
		return idAcc;
	}

	public void setIdAcc(Account idAcc) {
		this.idAcc = idAcc;
	}

	public Post getIdPost() {
		return idPost;
	}

	public void setIdPost(Post idPost) {
		this.idPost = idPost;
	}

	@Override
	public int hashCode() {
		int hash = 0;
		hash += (idComment != null ? idComment.hashCode() : 0);
		return hash;
	}

	@Override
	public boolean equals(Object object) {
		// TODO: Warning - this method won't work in the case the id fields are
		// not set
		if (!(object instanceof Comment)) {
			return false;
		}
		Comment other = (Comment) object;
		if ((this.idComment == null && other.idComment != null)
				|| (this.idComment != null && !this.idComment.equals(other.idComment))) {
			return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "com.spring.domain.Comment[ idComment=" + idComment + " ]";
	}

}
