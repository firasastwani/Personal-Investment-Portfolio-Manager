"use client";

import { useAuth } from "../AuthContext/AuthContext";
import { useEffect, useState } from "react";
import axios from "axios";
import TabBar from "@/components/TabBar";
import StockList from "@/components/StockList";

interface Stock {
    id: number;
    name: string;
    symbol: string;
    staticPrice: number;
}

interface SuccessMessage {
    symbol: string;
    message: string;
    timestamp: number;
}

export default function Stocks() {
    const { user, loading, refreshUser } = useAuth();
    const [stocks, setStocks] = useState<Stock[]>([]);
    const [fetching, setFetching] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [successMessages, setSuccessMessages] = useState<SuccessMessage[]>([]);

    const fetchStocks = async () => {
        try {
            const response = await axios.get("/api/securities");
            setStocks(response.data);
        } catch (error) {
            console.error("Error fetching stocks:", error);
            if (axios.isAxiosError(error) && error.response?.status === 401) {
                setError("Your session has expired. Please log in again.");
                await refreshUser();
            } else {
                setError("Failed to fetch stocks. Please try again.");
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

    // Remove success messages after 3 seconds
    useEffect(() => {
        const timer = setInterval(() => {
            setSuccessMessages(prev => 
                prev.filter(msg => Date.now() - msg.timestamp < 3000)
            );
        }, 1000);

        return () => clearInterval(timer);
    }, []);

    const handleAddToWatchList = async (symbol: string) => {
        try {
            setError(null);
            await axios.post(`/api/watchlist/${symbol}`);
            
            // Add success message with timestamp
            setSuccessMessages(prev => [...prev, {
                symbol,
                message: `Successfully added ${symbol} to watchlist`,
                timestamp: Date.now()
            }]);

            // Remove the success message after 3 seconds
            setTimeout(() => {
                setSuccessMessages(prev => 
                    prev.filter(msg => msg.symbol !== symbol)
                );
            }, 3000);

        } catch (error) {
            console.error("Error adding to watchlist:", error);
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else {
                    setError("Failed to add to watchlist. Please try again.");
                }
            } else {
                setError("An unexpected error occurred. Please try again.");
            }
        }
    };

    if (loading || fetching) {
        return <div>Loading...</div>;
    }

    if (!user) {
        return <div>Please log in to access the stocks.</div>;
    }

    return (
        <div className="flex flex-col min-h-screen bg-gray-100">
            <TabBar />
            <div className="flex-grow flex justify-center pt-4 px-20">
                <div className="bg-white p-6 rounded shadow-md w-full text-center">
                    <h2 className="text-2xl font-bold mb-4">Available Stocks</h2>
                    {error && (
                        <div className="mb-4 p-4 bg-red-100 text-red-700 rounded">
                            {error}
                        </div>
                    )}
                    <StockList 
                        stocks={stocks} 
                        handleAction={handleAddToWatchList}
                        successMessages={successMessages}
                    />
                </div>
            </div>
        </div>
    );
}
