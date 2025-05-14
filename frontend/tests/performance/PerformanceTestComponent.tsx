import React, { useState, useEffect, Profiler, ProfilerOnRenderCallback } from "react";
import StockList from "../../src/components/StockList";
import StockListIndividual from "../../src/components/StockList.individual";

interface Stock {
    id: number;
    symbol: string;
    name: string;
    staticPrice: number;
}

type SchedulerInteraction = {
    id: number;
    name: string;
    timestamp: number;
};

const PerformanceTest: React.FC = () => {
  const [stocks, setStocks] = useState<Stock[]>([]);
  const [loading, setLoading] = useState(true);

  const onRenderCallback: ProfilerOnRenderCallback = (
    id: string,
    phase: 'mount' | 'update',
    actualDuration: number,
    baseDuration: number,
    startTime: number,
    commitTime: number,
    interactions: Set<SchedulerInteraction>,
    ...args: any[]
  ) => {
    console.log(`${id} ${phase} took ${actualDuration}ms`);
    interactions.forEach(interaction => {
      console.log(`Interaction: ${interaction.name}`);
    });
  };

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
        <Profiler id="StockListIndividual" onRender={onRenderCallback}>
          <StockListIndividual stocks={stocks} handleAction={handleAction} />
        </Profiler>
      </div>
      
      <div>
        <h2 className="text-xl font-bold mb-2">Event Delegation</h2>
        <Profiler id="StockList" onRender={onRenderCallback}>
          <StockList stocks={stocks} handleAction={handleAction} />
        </Profiler>
      </div>
    </div>
  );
};

export default PerformanceTest;