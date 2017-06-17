package com.spring.domain;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

@Embeddable
public class TaskPK implements Serializable {

	private static final long serialVersionUID = 1L;
	@Basic(optional = false)
    @NotNull
    @Column(name = "id_test", nullable = false)
    private int idTest;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_acc", nullable = false)
    private int idAcc;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_question", nullable = false)
    private int idQuestion;

    public TaskPK() {
    }

    public TaskPK(int idTest, int idAcc, int idQuestion) {
        this.idTest = idTest;
        this.idAcc = idAcc;
        this.idQuestion = idQuestion;
    }

    public int getIdTest() {
        return idTest;
    }

    public void setIdTest(int idTest) {
        this.idTest = idTest;
    }

    public int getIdAcc() {
        return idAcc;
    }

    public void setIdAcc(int idAcc) {
        this.idAcc = idAcc;
    }

    public int getIdQuestion() {
        return idQuestion;
    }

    public void setIdQuestion(int idQuestion) {
        this.idQuestion = idQuestion;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idTest;
        hash += (int) idAcc;
        hash += (int) idQuestion;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TaskPK)) {
            return false;
        }
        TaskPK other = (TaskPK) object;
        if (this.idTest != other.idTest) {
            return false;
        }
        if (this.idAcc != other.idAcc) {
            return false;
        }
        if (this.idQuestion != other.idQuestion) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.spring.domain.TaskPK[ idTest=" + idTest + ", idAcc=" + idAcc + ", idQuestion=" + idQuestion + " ]";
    }
    
}
