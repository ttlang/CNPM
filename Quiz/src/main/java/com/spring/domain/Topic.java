/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.spring.domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author Mr.Teo
 */
@Entity
@Table(name = "topic", catalog = "Quiz2", schema = "dbo")
@NamedQueries({
    @NamedQuery(name = "Topic.findAll", query = "SELECT t FROM Topic t")
    , @NamedQuery(name = "Topic.findByIdTopic", query = "SELECT t FROM Topic t WHERE t.idTopic = :idTopic")
    , @NamedQuery(name = "Topic.findByTopicName", query = "SELECT t FROM Topic t WHERE t.topicName = :topicName")})
public class Topic implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_topic")
    private Integer idTopic;
    @Size(max = 300)
    @Column(name = "topic_name")
    private String topicName;
    @OneToMany(mappedBy = "idTopic")
    private List<Question> questionList;
    @JoinColumn(name = "id_acc", referencedColumnName = "id_acc")
    @ManyToOne
    private Account idAcc;

    public Topic() {
    }

    public Topic(Integer idTopic) {
        this.idTopic = idTopic;
    }

    public Integer getIdTopic() {
        return idTopic;
    }

    public void setIdTopic(Integer idTopic) {
        this.idTopic = idTopic;
    }

    public String getTopicName() {
        return topicName;
    }

    public void setTopicName(String topicName) {
        this.topicName = topicName;
    }

    public List<Question> getQuestionList() {
        return questionList;
    }

    public void setQuestionList(List<Question> questionList) {
        this.questionList = questionList;
    }

    public Account getIdAcc() {
        return idAcc;
    }

    public void setIdAcc(Account idAcc) {
        this.idAcc = idAcc;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTopic != null ? idTopic.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Topic)) {
            return false;
        }
        Topic other = (Topic) object;
        if ((this.idTopic == null && other.idTopic != null) || (this.idTopic != null && !this.idTopic.equals(other.idTopic))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "domain.Topic[ idTopic=" + idTopic + " ]";
    }
    
}
