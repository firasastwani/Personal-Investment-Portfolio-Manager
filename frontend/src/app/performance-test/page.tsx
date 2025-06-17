"use client";

import React, { useState, useEffect, useRef } from "react";
import StockList from "../../../src/components/StockList";
import StockListIndividual from "../../../src/components/StockList.individual";
import { useAuth } from "../AuthContext/AuthContext";
import axios from "axios";

interface Stock {
    id: number;
    symbol: string;
    name: string;
    price: number;
}

interface RenderMeasurement {
    id: string;
    phase: 'mount' | 'update';
    duration: number;
    timestamp: number;
}

const PerformanceTest: React.FC = () => {
    const { user, loading, refreshUser } = useAuth();
    const [stocks, setStocks] = useState<Stock[]>([]);
    const [fetching, setFetching] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [measurements, setMeasurements] = useState<RenderMeasurement[]>([]);
    const testCountRef = useRef(0);
    const renderStartTimeRef = useRef<{[key: string]: number}>({});
    const [performance, setPerformance] = useState<{
        fetchTime: number;
        parseTime: number;
        totalTime: number;
    } | null>(null);

    const startMeasurement = (componentId: string) => {
        // Clear previous measurements
        performance.clearMarks(`${componentId}-render-start`);
        performance.clearMarks(`${componentId}-render-end`);
        performance.clearMeasures(`${componentId}-render-duration`);
        
        // Set start time
        renderStartTimeRef.current[componentId] = performance.now();
        performance.mark(`${componentId}-render-start`);
    };

    const endMeasurement = (componentId: string, phase: 'mount' | 'update') => {
        if (!renderStartTimeRef.current[componentId]) return;

        performance.mark(`${componentId}-render-end`);
        performance.measure(
            `${componentId}-render-duration`,
            `${componentId}-render-start`,
            `${componentId}-render-end`
        );

        const measures = performance.getEntriesByName(`${componentId}-render-duration`);
        const lastMeasure = measures[measures.length - 1];

        if (lastMeasure) {
            const newMeasurement: RenderMeasurement = {
                id: componentId,
                phase,
                duration: lastMeasure.duration,
                timestamp: Date.now()
            };
            setMeasurements(prev => [...prev, newMeasurement]);
        }
    };

    const fetchStocks = async () => {
        const startTime = performance.now();
        try {
            setError(null);
            const response = await axios.get("/api/securities");
            const fetchEndTime = performance.now();
            const fetchTime = fetchEndTime - startTime;

            const parseStartTime = performance.now();
            setStocks(response.data);
            const parseEndTime = performance.now();
            const parseTime = parseEndTime - parseStartTime;

            setPerformance({
                fetchTime,
                parseTime,
                totalTime: parseEndTime - startTime
            });
        } catch (error) {
            console.error("Error fetching stocks:", error);
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else {
                    setError("Failed to fetch stocks. Please try again.");
                }
            } else {
                setError("An unexpected error occurred. Please try again.");
            }
        } finally {
            setFetching(false);
        }
    };

    useEffect(() => {
        if (user) {
            fetchStocks();
        }
    }, [user]);

    const handleAction = (symbol: string) => {
        console.log(`Action for ${symbol}`);
        testCountRef.current += 1;
        // Force re-render to test update performance
        setStocks(prev => [...prev]);
    };

    const getAverageDuration = (componentId: string) => {
        const componentMeasures = measurements.filter(m => m.id === componentId);
        if (componentMeasures.length === 0) return 0;
        return componentMeasures.reduce((sum, m) => sum + m.duration, 0) / componentMeasures.length;
    };

    if (loading || fetching) {
        return <div>Loading...</div>;
    }

    if (!user) {
        return <div>Please log in to access the performance test.</div>;
    }

    return (
        <div className="p-6 max-w-4xl mx-auto">
            <h1 className="text-2xl font-bold mb-6">Performance Test</h1>
            
            {error && (
                <div className="mb-4 p-4 bg-red-100 text-red-700 rounded">
                    {error}
                </div>
            )}
            {performance && (
                <div className="mb-4 p-4 bg-green-100 text-green-700 rounded">
                    <h2 className="font-bold mb-2">Performance Metrics:</h2>
                    <p>Fetch Time: {performance.fetchTime.toFixed(2)}ms</p>
                    <p>Parse Time: {performance.parseTime.toFixed(2)}ms</p>
                    <p>Total Time: {performance.totalTime.toFixed(2)}ms</p>
                </div>
            )}

            <div className="mb-8 bg-gray-100 p-4 rounded">
                <h2 className="text-xl font-bold mb-4">Test Results</h2>
                <div className="grid grid-cols-2 gap-4">
                    <div>
                        <h3 className="font-semibold mb-2">StockListIndividual</h3>
                        <p>Renders: {measurements.filter(m => m.id === 'StockListIndividual').length}</p>
                        <p>Avg: {getAverageDuration('StockListIndividual').toFixed(2)}ms</p>
                    </div>
                    <div>
                        <h3 className="font-semibold mb-2">StockList</h3>
                        <p>Renders: {measurements.filter(m => m.id === 'StockList').length}</p>
                        <p>Avg: {getAverageDuration('StockList').toFixed(2)}ms</p>
                    </div>
                </div>
            </div>

            <div className="mb-8">
                <div className="flex justify-between items-center mb-2">
                    <h2 className="text-xl font-bold">Individual Handlers</h2>
                    <button 
                        onClick={() => startMeasurement('StockListIndividual')}
                        className="bg-blue-500 text-white px-3 py-1 rounded"
                    >
                        Start Test
                    </button>
                </div>
                <div 
                    ref={() => {
                        if (renderStartTimeRef.current['StockListIndividual']) {
                            endMeasurement('StockListIndividual', 'update');
                        }
                    }}
                >
                    <StockListIndividual stocks={stocks} handleAction={handleAction} />
                </div>
            </div>
            
            <div>
                <div className="flex justify-between items-center mb-2">
                    <h2 className="text-xl font-bold">Event Delegation</h2>
                    <button 
                        onClick={() => startMeasurement('StockList')}
                        className="bg-blue-500 text-white px-3 py-1 rounded"
                    >
                        Start Test
                    </button>
                </div>
                <div 
                    ref={() => {
                        if (renderStartTimeRef.current['StockList']) {
                            endMeasurement('StockList', 'update');
                        }
                    }}
                >
                    <StockList stocks={stocks} handleAction={handleAction} />
                </div>
            </div>

            <div className="mt-8 bg-gray-100 p-4 rounded">
                <h2 className="text-xl font-bold mb-2">Raw Measurements</h2>
                <div className="max-h-60 overflow-y-auto">
                    <table className="w-full">
                        <thead>
                            <tr>
                                <th className="text-left">Component</th>
                                <th className="text-left">Phase</th>
                                <th className="text-left">Duration (ms)</th>
                                <th className="text-left">Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            {measurements.map((m, i) => (
                                <tr key={i} className="border-t">
                                    <td>{m.id}</td>
                                    <td>{m.phase}</td>
                                    <td>{m.duration.toFixed(2)}</td>
                                    <td>{new Date(m.timestamp).toLocaleTimeString()}</td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    );
};

export default PerformanceTest;