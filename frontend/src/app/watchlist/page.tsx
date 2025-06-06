"use client";

import TabBar from "@/components/TabBar"
import { useAuth } from "../AuthContext/AuthContext";
import { useRouter } from "next/navigation";
import WatchList from "@/components/WatchList";
import { useEffect, useState } from "react";
import axios from "axios";

interface Stock {
    id: number;
    name: string;
    symbol: string;
    staticPrice: number;
}

export default function Watchlist() {
    const { user, loading, refreshUser } = useAuth();
    const router = useRouter();
    const [stocks, setStocks] = useState<Stock[]>([]);
    const [fetching, setFetching] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchStocks = async () => {
        try {
            setError(null);
            const response = await axios.get("/api/watchlist");
            const stocksData = response.data.map((stock: any) => ({
                id: stock.id,
                name: stock.security.name,
                symbol: stock.security.symbol,
                staticPrice: stock.security.staticPrice,
            }));
            setStocks(stocksData);
        } catch (error) {
            console.error("Error fetching stocks:", error);
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else {
                    setError("Failed to fetch watchlist. Please try again.");
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
            console.log("Fetching stocks for user:", user.username);
            fetchStocks();
        }
    }, [user]);

    const handleRemove = async (symbol: string) => {
        try {
            setError(null);
            await axios.delete(`/api/watchlist/${symbol}`);
            setStocks((prevStocks) => prevStocks.filter((stock) => stock.symbol !== symbol));
        } catch (error) {
            console.error("Error removing stock from watchlist:", error);
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else {
                    setError("Failed to remove stock from watchlist. Please try again.");
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
        return <div>Please log in to access the watchlist.</div>;
    }

    const handleOnClick = () => {
        router.push("/stocks");
    }

    return (
        <div className="flex flex-col min-h-screen bg-gray-100">
            <TabBar />
            <div className="flex-grow justify-center pt-4 px-20">
                <div className="bg-white p-6 rounded shadow-md w-full text-center">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-2xl font-bold mb-4">{user.username}'s Watchlist</h2>
                        <button onClick={handleOnClick} className="ml-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors">
                            Add Stock
                        </button>
                    </div>
                    {error && (
                        <div className="mb-4 p-2 bg-red-100 text-red-700 rounded">
                            {error}
                        </div>
                    )}
                    {stocks.length > 0 ? (
                        <WatchList stocks={stocks} handleAction={handleRemove} />
                    ) : (
                        <p className="mb-4">Your watchlist is empty.</p>
                    )}
                </div>
            </div>
        </div>
    )
}