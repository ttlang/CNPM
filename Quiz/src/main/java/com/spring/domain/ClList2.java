/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.spring.domain;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 *
 * @author Lang
 * cl_list2
 */
@Entity
@Table(name = "cl_list2")
@NamedQueries({
    @NamedQuery(name = "ClList2.findAll", query = "SELECT c FROM ClList2 c")
    , @NamedQuery(name = "ClList2.findByPmcode", query = "SELECT c FROM ClList2 c WHERE c.pmcode = :pmcode")
    , @NamedQuery(name = "ClList2.findByCdgr", query = "SELECT c FROM ClList2 c WHERE c.cdgr = :cdgr")
    , @NamedQuery(name = "ClList2.findByValName", query = "SELECT c FROM ClList2 c WHERE c.valName = :valName")
    , @NamedQuery(name = "ClList2.findByParamName", query = "SELECT c FROM ClList2 c WHERE c.paramName = :paramName")})
public class ClList2 implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "pmcode", nullable = false, length = 10)
    private String pmcode;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 10)
    @Column(name = "cdgr", nullable = false, length = 10)
    private String cdgr;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 50)
    @Column(name = "val_name", nullable = false, length = 50)
    private String valName;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "param_name", nullable = false)
    private Integer paramName;
    @OneToMany(mappedBy = "questionType")
    private List<Question> questionList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idPostType")
    private List<Post> postList;

    public ClList2() {
    }

    public ClList2(Integer paramName) {
        this.paramName = paramName;
    }

    public ClList2(Integer paramName, String pmcode, String cdgr, String valName) {
        this.paramName = paramName;
        this.pmcode = pmcode;
        this.cdgr = cdgr;
        this.valName = valName;
    }

    public String getPmcode() {
        return pmcode;
    }

    public void setPmcode(String pmcode) {
        this.pmcode = pmcode;
    }

    public String getCdgr() {
        return cdgr;
    }

    public void setCdgr(String cdgr) {
        this.cdgr = cdgr;
    }

    public String getValName() {
        return valName;
    }

    public void setValName(String valName) {
        this.valName = valName;
    }

    public Integer getParamName() {
        return paramName;
    }

    public void setParamName(Integer paramName) {
        this.paramName = paramName;
    }

    public List<Question> getQuestionList() {
        return questionList;
    }

    public void setQuestionList(List<Question> questionList) {
        this.questionList = questionList;
    }

    public List<Post> getPostList() {
        return postList;
    }

    public void setPostList(List<Post> postList) {
        this.postList = postList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (paramName != null ? paramName.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ClList2)) {
            return false;
        }
        ClList2 other = (ClList2) object;
        if ((this.paramName == null && other.paramName != null) || (this.paramName != null && !this.paramName.equals(other.paramName))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.spring.domain.ClList2[ paramName=" + paramName + " ]";
    }
    
}
