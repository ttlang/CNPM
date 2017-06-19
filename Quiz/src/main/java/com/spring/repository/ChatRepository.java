package com.spring.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.domain.Chat;

public interface ChatRepository  extends  JpaRepository<Chat, Integer> {

}
