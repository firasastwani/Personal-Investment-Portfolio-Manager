"use client";

import TabBar from "@/components/TabBar"
import { useAuth } from "../AuthContext/AuthContext";
import { useRouter } from "next/navigation";
import WatchList from "@/components/WatchList";
import { useEffect, useState } from "react";

interface Stock {
    id: number;
    name: string;
    symbol: string;
    staticPrice: number;
}


export default function Watchlist() {
    const { user, loading } = useAuth();
    const router = useRouter();
    const [stocks, setStocks] = useState([]);
    const [fetching, setFetching] = useState(true);

    type stockData = {
        id: number;
        name: string;
        symbol: string;
        staticPrice: number;
    }

    const fetchStocks = async () => {
        try {
            const response = await fetch("http://localhost:8080/api/watchlist", {
                method: "GET",
                credentials: "include",
            });
            if (!response.ok) {
                throw new Error("Network response was not ok");
            }
            const data = await response.json();
            
            const stocksData = data.map((stock: any) => ({
                id: stock.id,
                name: stock.security.name,
                symbol: stock.security.symbol,
                staticPrice: stock.security.staticPrice,
            }));

            setStocks(stocksData);
            console.log("Fetched stocks:", stocksData);
        } catch (error) {
            console.error("Error fetching stocks:", error);
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

    const handleRemove = (id: number) => {
        console.log(`Removing stock with id: ${id}`);
        try {
            const response = fetch(`http://localhost:8080/api/watchlist/${id}`, {
                method: "DELETE",
                credentials: "include",
            });
        } catch (error) {
            console.error("Error removing stock from watchlist:", error);
        } finally {
            setStocks((prevStocks) => prevStocks.filter((stock: stockData) => stock.id !== id));
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
                    {stocks.length > 0 ? (
                        <WatchList stocks={stocks} handleAction={handleRemove} />
                    ) : (
                            <p className="mb-4">Your watchlist is empty.</p>
                        )
                    }
                    {/* <p className="mb-4">Your watchlist is empty.</p> */}
                    {/* <StockList stocks={stocks} handleAction={() => { }} /> */}
                </div>
            </div>
        </div>
    )
}