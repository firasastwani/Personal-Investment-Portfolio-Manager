"use client";

import TabBar from "@/components/TabBar"
import PortfolioList from "@/components/PortfolioList"
import { useAuth } from "../../AuthContext/AuthContext";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { useParams, useSearchParams } from "next/navigation";

interface portfolioData {
    id: number;
    name: string;
    symbol: string;
    quantity: number
    staticPrice: number;
}

export default function PortfolioPage() {
    const { user, loading } = useAuth();
    const router = useRouter();
    const [stocks, setStocks] = useState<portfolioData[]>([]);
    const [fetching, setFetching] = useState(true);

    const params = useParams();
    const id = params.id as string;

    const searchParams = useSearchParams();
    const name = searchParams.get("name") as string;

    const handleOnClick = () => {
        console.log("Add stock button clicked")
        router.push(`/buy/${id}`)
    }

    const handleRemove = (symbol: string) => {
        console.log("Remove stock with id:", id)
        try {
            console.log(`Request: http://localhost:8080/api/holdings/sell/${id}/${symbol}`);
            const response = fetch(`http://localhost:8080/api/holdings/sell/${id}/${symbol}?quantity=1`, {
                method: "POST",
                credentials: "include",
            });

        } catch (error) {
            console.error("Error removing stock:", error);
        } finally {
            setStocks(prevStocks =>
                prevStocks.flatMap(stock => {
                    if (stock.symbol === symbol) {
                        if (stock.quantity > 1) {
                            return [{ ...stock, quantity: stock.quantity - 1 }];
                        } else {
                            return []; // Remove stock if quantity is 1
                        }
                    }
                    return [stock];
                })
            );
        }

    }

    const fetchStocks = async () => {
        try {
            const response = await fetch(`http://localhost:8080/api/holdings/portfolio/${id}`, {
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
                quantity: stock.quantity,
                staticPrice: stock.security.staticPrice,
            }));

            setStocks(stocksData);
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


    return (
        <div className="flex flex-col min-h-screen bg-gray-100">
            <TabBar />
            <div className="flex-grow justify-center pt-4 px-20">
                <div className="bg-white p-6 rounded shadow-md w-full text-center">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-2xl font-bold mb-4">Portfolio: {name}</h2>
                        <button onClick={handleOnClick} className="ml-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors">
                            Buy Stock
                        </button>
                    </div>
                    {fetching ? (
                        <p className="mb-4">Fetching stocks...</p>
                    ) : stocks.length > 0 ? (
                        <PortfolioList portfolios={stocks} handleAction={handleRemove} />
                    ) : (
                        <p className="mb-4">Your portfolio is empty.</p>
                    )}
                    {/* <p className="mb-4">Your watchlist is empty.</p> */}
                    {/* <StockList stocks={stocks} handleAction={() => { }} /> */}
                </div>
            </div>
        </div>
    )
}