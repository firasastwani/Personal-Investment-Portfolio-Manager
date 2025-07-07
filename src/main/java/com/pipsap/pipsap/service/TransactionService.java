package com.pipsap.pipsap.service;

import com.pipsap.pipsap.model.Transaction;
import com.pipsap.pipsap.model.Security;
import com.pipsap.pipsap.model.Portfolio;
import com.pipsap.pipsap.repository.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class TransactionService {

    private final TransactionRepository transactionRepository;
    private final SecurityService securityService;
    private final PortfolioService portfolioService;

    public TransactionService(TransactionRepository transactionRepository, SecurityService securityService, PortfolioService portfolioService) {
        this.transactionRepository = transactionRepository;
        this.securityService = securityService;
        this.portfolioService = portfolioService;
    }


    @Transactional
    public Transaction createTransaction(
            Integer portfolioId,
            String symbol,
            Transaction.TransactionType type,
            BigDecimal quantity,
            BigDecimal price,
            String notes) {
        // Get the portfolio
        Portfolio portfolio = portfolioService.getPortfolioById(portfolioId)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Portfolio not found"));

        // Get the security
        Security security = securityService.getSecurityBySymbol(symbol)
            .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Security not found"));

        // Create new transaction
        Transaction transaction = new Transaction();
        transaction.setPortfolio(portfolio);
        transaction.setSecurity(security);
        transaction.setType(type);
        transaction.setQuantity(quantity);
        transaction.setPrice(price);
        transaction.setNotes(notes);

        return transactionRepository.save(transaction);
    }

    public List<Transaction> getTransactionsByPortfolioId(Integer portfolioId) {
        return transactionRepository.findByPortfolio_PortfolioId(portfolioId);
    }

    public Optional<Transaction> getTransactionById(Integer id) {
        return transactionRepository.findById(id);
    }

    @Transactional
    public void deleteTransaction(Integer id) {
        transactionRepository.deleteById(id);
    }
} 