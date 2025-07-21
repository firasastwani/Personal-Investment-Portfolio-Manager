// TODO: for future implementation, stream price updates directly to frontend display


/* 
package com.pipsap.stockpriceservice.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import io.grpc.Server;
import io.grpc.ServerBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import com.pipsap.stockpriceservice.grpc.StockPriceGrpcService;
import com.pipsap.stockpriceservice.service.PriceFetchService;
import org.springframework.beans.factory.annotation.Autowired;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.PreDestroy;

@Configuration
public class GrpcServerConfig {
    private static final Logger logger = LoggerFactory.getLogger(GrpcServerConfig.class);

    @Value("${grpc.server.port}")
    private int grpcPort;

    @Autowired
    private StockPriceGrpcService stockPriceGrpcService;

    private Server server;

    @PostConstruct
    public void start() throws Exception {
        logger.info("Starting gRPC server on port: {}", grpcPort);
        server = ServerBuilder.forPort(grpcPort)
                .addService(stockPriceGrpcService)
                .build()
                .start();
        logger.info("gRPC server started successfully on port: {}", grpcPort);
    }

    @PreDestroy
    public void stop() {
        if (server != null) {
            logger.info("Shutting down gRPC server...");
            server.shutdown();
        }
    }
}
    
*/