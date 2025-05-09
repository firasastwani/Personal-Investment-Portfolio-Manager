import React, { useState, useEffect } from "react";
import StockList from "../../src/components/StockList";
import StockListIndividual from "../../src/components/StockList.individual";

interface Stock {
    id: number;
    symbol: string;
    name: string;
    staticPrice: number;
  }

const PerformanceTest: React.FC = () => {
  const [stocks, setStocks] = useState<Stock[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchData = async () => {
        try {
            const response = await fetch("http://localhost:8080/api/securities", {
            method: "GET",
            credentials: "include",
            })
            if (!response.ok) {
                throw new Error("Network response was not ok");
            }
            const data = await response.json();

            setStocks(data);
        } catch (error) {
            console.error("Error fetching stocks:", error);
        } finally {
            setLoading(false);
        }
    };

    fetchData();
  }, []);
  
  const handleAction = (symbol: string) => {
    console.log(`Action for ${symbol}`);
  };

  if (loading) {
    return <div>Loading...</div>;
  }

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