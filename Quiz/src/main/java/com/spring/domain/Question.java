package com.spring.domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "question")
@NamedQueries({ @NamedQuery(name = "Question.findAll", query = "SELECT q FROM Question q"),
		@NamedQuery(name = "Question.findByIdQuestion", query = "SELECT q FROM Question q WHERE q.idQuestion = :idQuestion") })
public class Question implements Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@Basic(optional = false)
	@NotNull
	@Column(name = "id_question", nullable = false)
	private Integer idQuestion;
	@Lob
	@Size(max = 2147483647)
	@Column(name = "question_content", length = 2147483647)
	private String questionContent;
	@JoinTable(name = "test_content", joinColumns = {
			@JoinColumn(name = "id_question", referencedColumnName = "id_question", nullable = false) }, inverseJoinColumns = {
					@JoinColumn(name = "id_test", referencedColumnName = "id_test", nullable = false) })
	@ManyToMany
	private List<Test> testList;
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "question")
	private List<Task> taskList;
	@JoinColumn(name = "question_type", referencedColumnName = "param_name")
	@ManyToOne
	private ClList2 questionType;
	@JoinColumn(name = "id_topic", referencedColumnName = "id_topic")
	@ManyToOne
	private Topic idTopic;
	@OneToMany(cascade = CascadeType.ALL, mappedBy = "idQuestion")
	private List<CorrectAnswer> correctAnswerList;

	public Question() {
	}

	public Question(Integer idQuestion) {
		this.idQuestion = idQuestion;
	}

	public Integer getIdQuestion() {
		return idQuestion;
	}

	public void setIdQuestion(Integer idQuestion) {
		this.idQuestion = idQuestion;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public List<Test> getTestList() {
		return testList;
	}

	public void setTestList(List<Test> testList) {
		this.testList = testList;
	}

	public List<Task> getTaskList() {
		return taskList;
	}

	public void setTaskList(List<Task> taskList) {
		this.taskList = taskList;
	}

	public ClList2 getQuestionType() {
		return questionType;
	}

	public void setQuestionType(ClList2 questionType) {
		this.questionType = questionType;
	}

	public Topic getIdTopic() {
		return idTopic;
	}

	public void setIdTopic(Topic idTopic) {
		this.idTopic = idTopic;
	}

	public List<CorrectAnswer> getCorrectAnswerList() {
		return correctAnswerList;
	}

	public void setCorrectAnswerList(List<CorrectAnswer> correctAnswerList) {
		this.correctAnswerList = correctAnswerList;
	}

	@Override
	public int hashCode() {
		int hash = 0;
		hash += (idQuestion != null ? idQuestion.hashCode() : 0);
		return hash;
	}

	@Override
	public boolean equals(Object object) {
		// TODO: Warning - this method won't work in the case the id fields are
		// not set
		if (!(object instanceof Question)) {
			return false;
		}
		Question other = (Question) object;
		if ((this.idQuestion == null && other.idQuestion != null)
				|| (this.idQuestion != null && !this.idQuestion.equals(other.idQuestion))) {
			return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "com.spring.domain.Question[ idQuestion=" + idQuestion + " ]";
	}

}
