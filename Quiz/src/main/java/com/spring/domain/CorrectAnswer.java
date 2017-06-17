package com.spring.domain;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(name = "correct_answer")
@NamedQueries({
    @NamedQuery(name = "CorrectAnswer.findAll", query = "SELECT c FROM CorrectAnswer c")
    , @NamedQuery(name = "CorrectAnswer.findByIdAnswer", query = "SELECT c FROM CorrectAnswer c WHERE c.idAnswer = :idAnswer")
    , @NamedQuery(name = "CorrectAnswer.findByCorrectAnswer", query = "SELECT c FROM CorrectAnswer c WHERE c.correctAnswer = :correctAnswer")})
public class CorrectAnswer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_answer", nullable = false)
    private Integer idAnswer;
    @Lob
    @Size(max = 2147483647)
    @Column(name = "answer_content", length = 2147483647)
    private String answerContent;
    @Column(name = "correct_answer")
    private Boolean correctAnswer;
    @JoinColumn(name = "id_question", referencedColumnName = "id_question", nullable = false)
    @ManyToOne(optional = false)
    private Question idQuestion;

    public CorrectAnswer() {
    }

    public CorrectAnswer(Integer idAnswer) {
        this.idAnswer = idAnswer;
    }

    public Integer getIdAnswer() {
        return idAnswer;
    }

    public void setIdAnswer(Integer idAnswer) {
        this.idAnswer = idAnswer;
    }

    public String getAnswerContent() {
        return answerContent;
    }

    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
    }

    public Boolean getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(Boolean correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public Question getIdQuestion() {
        return idQuestion;
    }

    public void setIdQuestion(Question idQuestion) {
        this.idQuestion = idQuestion;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idAnswer != null ? idAnswer.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        if (!(object instanceof CorrectAnswer)) {
            return false;
        }
        CorrectAnswer other = (CorrectAnswer) object;
        if ((this.idAnswer == null && other.idAnswer != null) || (this.idAnswer != null && !this.idAnswer.equals(other.idAnswer))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.spring.domain.CorrectAnswer[ idAnswer=" + idAnswer + " ]";
    }
    
}
