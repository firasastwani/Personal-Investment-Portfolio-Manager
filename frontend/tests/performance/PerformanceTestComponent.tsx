import React, { useState } from "react";
import StockList from "../../src/components/StockList";
import StockListIndividual from "../../src/components/StockList.individual";

const PerformanceTest: React.FC = () => {
  const [stocks] = useState<Stock[]>();
  
  const handleAction = (symbol: string) => {
    console.log(`Action for ${symbol}`);
  };

  return (
    <div>
      <div className="mb-8">
        <h2 className="text-xl font-bold mb-2">Individual Handlers</h2>
        <StockListIndividual stocks={stocks} handleAction={handleAction} />
      </div>
      
      <div>
        <h2 className="text-xl font-bold mb-2">Event Delegation</h2>
        <StockList stocks={stocks} handleAction={handleAction} />
      </div>
    </div>
  );
};