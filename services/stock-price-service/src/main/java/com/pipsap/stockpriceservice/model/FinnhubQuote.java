package com.pipsap.stockpriceservice.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class FinnhubQuote {
    @JsonProperty("c")
    private double currentPrice;
} 