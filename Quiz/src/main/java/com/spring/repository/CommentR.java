package com.spring.repository;

import org.springframework.data.repository.CrudRepository;

import com.spring.domain.Comment;

public interface CommentR extends CrudRepository<Comment, Integer> {
}
