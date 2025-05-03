"use client";

import TabBar from "@/components/TabBar";
import { useAuth } from "../AuthContext/AuthContext";
import StockList from "@/components/StockList";
import { Exo_2 } from "next/font/google";

export default function Stocks() {
    const { user, loading } = useAuth();

    if (loading) {
        return <div>Loading...</div>;
    }

    if (!user) {
        return <div>Please log in to access the stocks.</div>;
    }

    const stocks = [
        { id: 0, symbol: "AAPL", name: "Apple Inc.", price: 150.00 },
        { id: 1, symbol: "GOOGL", name: "Alphabet Inc.", price: 2800.00 },
        { id: 2, symbol: "AMZN", name: "Amazon.com Inc.", price: 3400.00 },
        { id: 3, symbol: "MSFT", name: "Microsoft Corp.", price: 299.00 },
        { id: 4, symbol: "TSLA", name: "Tesla Inc.", price: 700.00 },
    ]

    return (
        <>
            <div className="flex flex-col min-h-screen bg-gray-100">
                <TabBar />
                <div className="flex-grow flex justify-center pt-4 px-20">
                    <div className="bg-white p-6 rounded shadow-md w-full text-center">
                        <h2 className="text-2xl font-bold mb-4">Stocks</h2>
                        <StockList stocks={stocks} />
                    </div>
                </div>
            </div>
        </>
    );
}
