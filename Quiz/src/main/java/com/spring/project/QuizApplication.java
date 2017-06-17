package com.spring.project;

import org.hibernate.SessionFactory;
import org.hibernate.jpa.HibernateEntityManagerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

import it.ozimov.springboot.mail.configuration.EnableEmailTools;

@SpringBootApplication
@ComponentScan({ "com" })
@EnableAutoConfiguration
@EnableJpaRepositories("com.spring.repository")
@EntityScan("com.spring.domain")
@EnableEmailTools

public class QuizApplication {
	@Bean
	public SessionFactory sessionFactory(HibernateEntityManagerFactory hemf) {
		return hemf.getSessionFactory();
	}

	public static void main(String[] args) {
		SpringApplication.run(QuizApplication.class, args);
	}
}
