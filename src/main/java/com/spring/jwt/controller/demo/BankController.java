package com.spring.jwt.controller.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.jwt.db.maria.dao.demo.BankAccountDao;
import com.spring.jwt.db.maria.model.demo.BankAccount;
import com.spring.jwt.db.maria.model.demo.SendMoneyForm;
import com.spring.jwt.db.maria.service.demo.BankAccountService;
import com.spring.jwt.exception.CommonTransactionException;

import java.util.List;

@Controller
@RequestMapping(path = "/demo/bank")
public class BankController {

    @Autowired
    private BankAccountDao bankAccountDao;
    @Autowired
    private BankAccountService bankAccountService;



    @GetMapping(path = "showBankAccounts")
    public String showBankAccounts(Model model) {
        List<BankAccount> list = (List<BankAccount>) bankAccountDao.findAll();
        model.addAttribute("accountInfos", list);
        return "demo/accountsPage";
    }

    @RequestMapping(value = "sendMoney", method = RequestMethod.GET)
    public String viewSendMoneyPage(Model model) {
        SendMoneyForm form = new SendMoneyForm(1L, 2L, 700d);
        model.addAttribute("sendMoneyForm", form);
        return "/demo/sendMoneyPage";
    }

    @RequestMapping(value = "sendMoney", method = RequestMethod.POST)
    public String processSendMoney(Model model, SendMoneyForm sendMoneyForm) {

        System.out.println("Send Money: " + sendMoneyForm.getAmount());

        try {
            bankAccountService.sendMoney(sendMoneyForm.getFromAccountId(),
                    sendMoneyForm.getToAccountId(),
                    sendMoneyForm.getAmount());

        } catch (CommonTransactionException e) {
            model.addAttribute("errorMessage", "Error: " + e.getMessage());
            return "/demo/sendMoneyPage";
        }
        return "redirect:/demo/bank/showBankAccounts";
    }

}