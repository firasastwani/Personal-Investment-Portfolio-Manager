"use client";

import TabBar from "@/components/TabBar";
import { useAuth } from "../../AuthContext/AuthContext";
import { useState } from "react";
import { useEffect } from "react";
import BuyList from "@/components/BuyList";
import { useParams } from "next/navigation";

interface Stock {
    id: number;
    name: string;
    symbol: string;
    staticPrice: number;
}

export default function Buy() {
    const { user, loading } = useAuth();
    const [stocks, setStocks] = useState<Stock[]>([]);
    const [fetching, setFetching] = useState(true);
    const params = useParams();
    const id = params.id as string;


    const fetchStocks = async () => {
        try {
            const response = await fetch("http://localhost:8080/api/securities", {
                method: "GET",
                credentials: "include",
            });
            if (!response.ok) {
                throw new Error("Network response was not ok");
            }
            const data = await response.json();
            setStocks(data);
        } catch (error) {
            console.error("Error fetching stocks:", error);
        } finally {
            setFetching(false);
        }
    };

    useEffect(() => {
        if (user) {
            fetchStocks();
        }
    }, [user]);


    if (loading || fetching) {
        return <div>Loading...</div>;
    }

    if (!user) {
        return <div>Please log in to access the stocks.</div>;
    }

    const handleAddToWatchList = (symbol: string) => {
        console.log(`Buying ${symbol} to Portfolio ${params.id}`);
        try {
            console.log(`Request: http://localhost:8080/api/holdings/buy/${id}/${symbol}`);
            const response = fetch(`http://localhost:8080/api/holdings/buy/${id}/${symbol}?quantity=1`, {
                method: "POST",
                credentials: "include",
            });
        } catch (error) {
            console.error("Error adding to watchlist:", error);
        }
    }

    return (
        <>
            <div className="flex flex-col min-h-screen bg-gray-100">
                <TabBar />
                <div className="flex-grow flex justify-center pt-4 px-20">
                    <div className="bg-white p-6 rounded shadow-md w-full text-center">
                        <h2 className="text-2xl font-bold mb-4">Buy</h2>
                        <BuyList stocks={stocks} handleAction={handleAddToWatchList} />
                    </div>
                </div>
            </div>
        </>
    );
}
