package com.spring.jwt.db.maria.dao.demo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.spring.jwt.db.maria.model.demo.BankAccount;

public interface BankAccountDao extends JpaRepository<BankAccount, Long> {

}
