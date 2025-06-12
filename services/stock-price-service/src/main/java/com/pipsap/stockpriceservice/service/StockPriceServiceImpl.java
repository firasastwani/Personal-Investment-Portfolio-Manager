package com.pipsap.stockpriceservice.service;

import com.pipsap.stockprice.proto.PriceRequest;
import com.pipsap.stockprice.proto.PriceResponse;
import com.pipsap.stockprice.proto.StockPriceServiceGrpc;

import io.grpc.stub.StreamObserver;
import org.springframework.grpc.server.service.GrpcService;

import java.util.List;
import com.pipsap.stockprice.proto.PriceUpdate;
import java.util.HashMap;


@GrpcService
public class StockPriceServiceImpl extends StockPriceServiceGrpc.StockPriceServiceImplBase{ 
 

    @Override
    public void getCurrentPrice(PriceRequest request, StreamObserver<PriceResponse> responseObserver) {

        List<String> symbols = request.getSymbolsList();

        // 1. Batch fetch prices (placeholder logic)
        // In the future, replace this with actual API/cache/database fetching
        HashMap<String, PriceUpdate> priceMap = new HashMap<>();
        for (String symbol : symbols) {
            // Placeholder: set dummy price
            double price = 100.0; // TODO: Replace with real price fetching logic
            PriceUpdate priceUpdate = PriceUpdate.newBuilder()
                .setSymbol(symbol)
                .setPrice(price)
                // .setTimestamp(System.currentTimeMillis()) // Timestamp should be a protobuf Timestamp
                .setSource("API")
                .build();
            priceMap.put(symbol, priceUpdate);
        }

        // 2. Build the response
        PriceResponse response = PriceResponse.newBuilder()
            .putAllPrices(priceMap)
            .build();

        responseObserver.onNext(response);
        responseObserver.onCompleted();
    }

     
}
