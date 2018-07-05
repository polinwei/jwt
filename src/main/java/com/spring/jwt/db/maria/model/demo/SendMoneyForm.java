package com.spring.jwt.db.maria.model.demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SendMoneyForm {
    private static Logger logger = LoggerFactory.getLogger(SendMoneyForm.class);

    private Long fromAccountId;
    private Long toAccountId;
    private Double amount;

    public SendMoneyForm() {
    }

    public SendMoneyForm(Long fromAccountId, Long toAccountId, Double amount) {
        this.fromAccountId = fromAccountId;
        this.toAccountId = toAccountId;
        this.amount = amount;
    }

    public Long getFromAccountId() {
        return fromAccountId;
    }

    public Long getToAccountId() {
        return toAccountId;
    }

    public Double getAmount() {
        return amount;
    }

    public void setFromAccountId(Long fromAccountId) {
        this.fromAccountId = fromAccountId;
    }

    public void setToAccountId(Long toAccountId) {
        this.toAccountId = toAccountId;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }
}