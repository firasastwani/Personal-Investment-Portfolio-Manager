package com.pipsap.pipsap.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.kafka.core.KafkaTemplate;
import com.pipsap.pipsap.service.PriceCacheService;
import com.pipsap.pipsap.service.SecurityService;

import java.util.List; 
import java.math.BigDecimal; 

@Service
public class KafkaPriceUpdateService {

    private static final Logger logger = LoggerFactory.getLogger(KafkaPriceUpdateService.class);
    
    private final KafkaTemplate<String, String> kafkaTemplate; 
    private final PriceCacheService priceCacheService; 
    private final SecurityService securityService;

    @Autowired
    public KafkaPriceUpdateService(KafkaTemplate<String, String> kafkaTemplate, PriceCacheService priceCacheService, SecurityService securityService) {
        this.kafkaTemplate = kafkaTemplate;
        this.priceCacheService = priceCacheService;
        this.securityService = securityService;
    }

    @Value("${price-update.microservice.kafka.request-topic}")   
    private String requestTopic; 

    // TODO: No response in monolith, just updates the db and cache?
    @Value("${price-update.microservice.kafka.response-topic}")
    private String responseTopic; 

    @Value("${price-update.kafka.enabled:true}")
    private boolean kafkaEnabled; 

    private final ObjectMapper objectMapper = new ObjectMapper(); 

    /* 
    / send batch price update request to the microservice via posting
    / to the kafka queue
    */
    public void requestBatchPriceUpdate(List<String> symbols){

        if(!kafkaEnabled){
            logger.warn("Kafka currently disabled, skipping batch price update request for {} symbols", symbols.size());
            return;
        }

        if(symbols.isEmpty()){
            logger.info("Nothing to update");
            return;
        }

        try {
            // seperate the symbols list into a comma seperated string
            String symbolsString = String.join(",", symbols);
            logger.info("Sending batch price update request for: {}", symbolsString);


            kafkaTemplate.send(requestTopic, symbolsString);
            logger.info("Successfully sent batch price update request");


        } catch (Exception e){

            logger.error("Error sending batch price update request: {}", e.getMessage(), e);

            // not throwing the expcetion here cus want it to continue anyway.

            logger.warn("using DB prices");
        }
    }

    // Listener to recieve the price updates from the microservice and handle them
    @KafkaListener(topics = "${price-update.microservice.kafka.response-topic}", 
    groupId = "pipsap-monolith-group")
    public void handleBatchPriceUpdate(String message){

        if(!kafkaEnabled){
            logger.debug("Kafka disabled, ignoring message");
            return;
        }

        try {

            logger.info("Recieved price update message: {}", message);
             
            String[] parts = message.split(":");

            if(parts.length == 2){

                String symbol = parts[0].trim();
                String priceStr = parts[1].trim(); 

                try {

                    BigDecimal price = new BigDecimal(priceStr);

                    priceCacheService.cachePrice(symbol, price);

                    securityService.updateSecurityPrice(symbol, price);

                    logger.info("Successfully process price update for: {}: {}, symbol, priceStr");

                } catch(NumberFormatException e){

                    logger.error("Invalid price format for: {}: {}", symbol, priceStr);
                }
            } else {
                logger.error("invalid message format: {}", message); 
            }
        } catch(Exception e){

            logger.error("Error processing price update message: {}", e.getMessage(), e); 
        }
    }

    public void requestSinglePriceUpdate(String symbol){

        if(!kafkaEnabled){
            logger.warn("kafka disabled, unable to process request for: {}", symbol);
            return;
        }

        try {

            logger.info("Processing price update request for: {}", symbol);

            kafkaTemplate.send(requestTopic, symbol);

            logger.info("Successfully sent price update request for: {}", symbol);

        } catch(Exception e){

            logger.error("Error sending price update request for: {}", e.getMessage(), e);
            logger.warn("Cont without kafka, using cache/DB");
        }
    }

}
