"use client";

import React, { useState, useCallback } from 'react';
import dynamic from 'next/dynamic';

// Use dynamic imports to prevent SSR issues
const StockList = dynamic(() => import('../../components/StockList'), { ssr: false });
const StockListIndividual = dynamic(() => import('../../components/StockList.individual'), { ssr: false });

interface Stock {
  id: number;
  symbol: string;
  name: string;
  staticPrice: number;
}

export default function PerformanceTestPage() {
  const [testRunning, setTestRunning] = useState(false);
  const [results, setResults] = useState<{
    individual?: { renderTime: number };
    delegation?: { renderTime: number };
  }>({});

  const stocks = Array.from({ length: 10000 }, (_, i) => ({
    id: i,
    symbol: `STK${i}`,
    name: `Company ${i}`,
    staticPrice: Math.random() * 10000
  }));

  const runPerformanceTest = useCallback(() => {
    setTestRunning(true);
    
    // Test Individual Handlers
    const individualStart = performance.now();
    const individualMarkup = <StockListIndividual stocks={stocks} handleAction={() => {}} />;
    const individualEnd = performance.now();

    // Test Event Delegation
    const delegationStart = performance.now();
    const delegationMarkup = <StockList stocks={stocks} handleAction={() => {}} />;
    const delegationEnd = performance.now();

    setResults({
      individual: { renderTime: individualEnd - individualStart },
      delegation: { renderTime: delegationEnd - delegationStart }
    });

    setTestRunning(false);
  }, [stocks]);

  return (
    <div className="container mx-auto p-4">
      <h1 className="text-2xl font-bold mb-6">Performance Test</h1>
      
      <button
        onClick={runPerformanceTest}
        disabled={testRunning}
        className={`px-4 py-2 rounded text-white ${
          testRunning ? 'bg-gray-500' : 'bg-blue-600 hover:bg-blue-700'
        }`}
      >
        {testRunning ? 'Testing...' : 'Run Performance Test'}
      </button>

      {results.individual && results.delegation && (
        <div className="mt-8 grid grid-cols-2 gap-4">
          <div className="bg-white p-4 rounded shadow">
            <h3 className="font-medium">Individual Handlers</h3>
            <p>Render Time: {results.individual.renderTime.toFixed(5)}ms</p>
          </div>
          <div className="bg-white p-4 rounded shadow">
            <h3 className="font-medium">Event Delegation</h3>
            <p>Render Time: {results.delegation.renderTime.toFixed(5)}ms</p>
            <p className="text-green-600 font-medium">
              Improvement: {(
                ((results.individual.renderTime - results.delegation.renderTime) / 
                 results.individual.renderTime) * 100
              ).toFixed(2)}%
            </p>
          </div>
        </div>
      )}
    </div>
  );
}