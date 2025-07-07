package com.pipsap.stockpriceservice.service;

import org.springframework.stereotype.Service;
import org.springframework.kafka.core.KafkaTemplate;


import java.util.Map;


@Service
public class PricePublishService {

    private final String topic = "stock-price-updates";
    private final KafkaTemplate<String, String> kafkaTemplate;

    public PricePublishService(KafkaTemplate<String, String> kafkaTemplate) {
        this.kafkaTemplate = kafkaTemplate;
    }

    public void publishPrices(Map<String, String> prices) {
        for (Map.Entry<String, String> entry : prices.entrySet()) {
            String message = entry.getKey() + ":" + entry.getValue();
            kafkaTemplate.send(topic, message);
        }
    }
    
}
