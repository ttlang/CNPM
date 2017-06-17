package com.spring.repository;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import com.spring.domain.Account;
import com.spring.domain.Comment;
import com.spring.domain.Post;

public interface PostR extends CrudRepository<Post, Integer> {
	@Query("select p.commentList  from Post  p where p.idPost=:idPost")
	public List<Comment> getListCommentByIdPost(@Param("idPost") int idPost);

	@Query("select p from Post p where p.idPost=:idPost")
	public Post getPostById(@Param("idPost") int idPost);

	@Query("select p.accountList from Post p where p.idPost=:idPost")
	public List<Account> getListAccountLike(@Param("idPost") int idPost);
}
