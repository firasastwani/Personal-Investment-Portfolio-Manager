// TODO: for future implementation, stream price updates directly to frontend display

/* 
package com.pipsap.stockpriceservice.grpc;

import com.pipsap.stockprice.proto.PriceRequest;
import com.pipsap.stockprice.proto.PriceResponse;
import com.pipsap.stockprice.proto.StockPriceServiceGrpc;
import com.pipsap.stockprice.proto.PriceUpdate;
import com.pipsap.stockpriceservice.service.PriceFetchService;

import io.grpc.stub.StreamObserver;
import org.springframework.grpc.server.service.GrpcService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.HashMap;

@GrpcService
public class StockPriceGrpcService extends StockPriceServiceGrpc.StockPriceServiceImplBase { 
    
    private static final Logger logger = LoggerFactory.getLogger(StockPriceGrpcService.class);
    private final PriceFetchService priceFetchService;

    public StockPriceGrpcService(PriceFetchService priceFetchService) {
        this.priceFetchService = priceFetchService;
        logger.info("StockPriceGrpcService initialized");
    }

    @Override
    public void getCurrentPrice(PriceRequest request, StreamObserver<PriceResponse> responseObserver) {
        logger.info("Received request for symbols: {}", request.getSymbolsList());
        
        List<String> symbols = request.getSymbolsList();
        HashMap<String, PriceUpdate> priceMap = new HashMap<>();

        for (String symbol : symbols) {
            try {
                double price = priceFetchService.fetchPrice(symbol);
                logger.info("Fetched price for {}: {}", symbol, price);
                
                PriceUpdate priceUpdate = PriceUpdate.newBuilder()
                    .setSymbol(symbol)
                    .setPrice(price)
                    .setSource("Finnhub API")
                    .build();
                    
                priceMap.put(symbol, priceUpdate);
            } catch (Exception e) {
                logger.error("Error fetching price for {}: {}", symbol, e.getMessage());
                PriceUpdate priceUpdate = PriceUpdate.newBuilder()
                    .setSymbol(symbol)
                    .setPrice(0.0)
                    .setSource("Error: " + e.getMessage())
                    .build();
                    
                priceMap.put(symbol, priceUpdate);
            }
        }

        PriceResponse response = PriceResponse.newBuilder()
            .putAllPrices(priceMap)
            .build();

        responseObserver.onNext(response);
        responseObserver.onCompleted();
        logger.info("Response sent successfully");
    }
} 
*/