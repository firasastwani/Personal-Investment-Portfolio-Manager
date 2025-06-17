package com.pipsap.stockpriceservice.component;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.test.context.EmbeddedKafka;
import org.springframework.test.context.TestPropertySource;
import org.springframework.kafka.test.EmbeddedKafkaBroker;
import org.springframework.kafka.test.utils.KafkaTestUtils;
import org.apache.kafka.clients.consumer.Consumer;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.apache.kafka.clients.consumer.ConsumerRecords;

import java.time.Duration;
import java.util.List;
import java.util.ArrayList;
import java.util.concurrent.TimeUnit;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@EmbeddedKafka(partitions = 1, topics = {"price-update-requests", "stock-price-updates"})
@TestPropertySource(properties = {
    "spring.kafka.producer.bootstrap-servers=${spring.embedded.kafka.brokers}",
    "spring.kafka.consumer.bootstrap-servers=${spring.embedded.kafka.brokers}",
    "spring.kafka.consumer.group-id=stock-price-consumer-group",
    "spring.kafka.consumer.auto-offset-reset=earliest"
})
public class PriceRequestKafkaListenerTest {

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    @Autowired
    private EmbeddedKafkaBroker embeddedKafkaBroker;

    @Test
    public void testPriceRequestProcessing() throws Exception {
        // Prepare test data
        String testSymbols = "AAPL,GOOGL,MSFT";
        
        // Send test message to the input topic
        kafkaTemplate.send("price-update-requests", testSymbols);
        
        // Wait for processing (adjust timeout as needed)
        TimeUnit.SECONDS.sleep(5);
        
        // Verify that messages were published to the output topic
        var consumerProps = KafkaTestUtils.consumerProps("test-group", "true", embeddedKafkaBroker);
        Consumer<String, String> consumer = new org.apache.kafka.clients.consumer.KafkaConsumer<>(consumerProps);
        embeddedKafkaBroker.consumeFromAnEmbeddedTopic(consumer, "stock-price-updates");
        
        ConsumerRecords<String, String> records = consumer.poll(Duration.ofSeconds(5));
        assertFalse(records.isEmpty(), "Should have received price updates");
        
        // Verify that we got updates for all requested symbols
        List<String> receivedSymbols = new ArrayList<>();
        for (ConsumerRecord<String, String> record : records.records("stock-price-updates")) {
            receivedSymbols.add(record.key());
        }
        
        assertTrue(receivedSymbols.containsAll(List.of("AAPL", "GOOGL", "MSFT")), 
            "Should have received updates for all requested symbols");
        
        // Verify that the values are valid price strings
        for (ConsumerRecord<String, String> record : records.records("stock-price-updates")) {
            String price = record.value();
            assertNotNull(price, "Price should not be null");
            assertTrue(price.matches("\\d+(\\.\\d+)?"), "Price should be a valid number");
        }
        
        consumer.close();
    }

    @Test
    public void testEmptySymbolList() throws Exception {
        // Send empty symbol list
        kafkaTemplate.send("price-update-requests", "");
        
        // Wait for processing
        TimeUnit.SECONDS.sleep(2);
        
        // Verify no messages were published
        var consumerProps = KafkaTestUtils.consumerProps("test-group", "true", embeddedKafkaBroker);
        Consumer<String, String> consumer = new org.apache.kafka.clients.consumer.KafkaConsumer<>(consumerProps);
        embeddedKafkaBroker.consumeFromAnEmbeddedTopic(consumer, "stock-price-updates");
        
        ConsumerRecords<String, String> records = consumer.poll(Duration.ofSeconds(2));
        assertTrue(records.isEmpty(), "Should not receive any updates for empty symbol list");
        
        consumer.close();
    }
} 