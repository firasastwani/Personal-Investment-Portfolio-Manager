"use client";

import TabBar from "@/components/TabBar"
import { useAuth } from "../AuthContext/AuthContext";
import { useRouter } from "next/navigation";
import PortfolioList from "@/components/PortfolioList";
import { useEffect, useState } from "react";

interface Stock {
    id: number;
    name: string;
    symbol: string;
    staticPrice: number;
}


export default function Dashboard() {
    const { user, loading } = useAuth();
    const router = useRouter();
    const [portfolios, setPortfolios] = useState([]);
    const [fetching, setFetching] = useState(true);

    type stockData = {
        id: number;
        name: string;
        description: string;
        created_at: Date;
    }

    const fetchPortfolios = async () => {

    };

    useEffect(() => {
        if (user) {
            console.log("Fetching portfolios for user:", user.username);
        }
    }, [user]);

    const handleRemove = (id: number) => {
        console.log(`Removing portfolio with id: ${id}`);
    };


    if (loading) {
        return <div>Loading...</div>;
    }
    if (!user) {
        return <div>Please log in to access the watchlist.</div>;
    }
    const handleOnClick = () => {
        console.log("Adding new portfolio");
        router.push("/portfolio/create");
    }

    return (
        <div className="flex flex-col min-h-screen bg-gray-100">
            <TabBar />
            <div className="flex-grow justify-center pt-4 px-20">
                <div className="bg-white p-6 rounded shadow-md w-full text-center">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-2xl font-bold mb-4">{user.username}'s Watchlist</h2>
                        <button onClick={handleOnClick} className="ml-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors">
                            Add New Portfolio
                        </button>
                    </div>
                    {portfolios.length > 0 ? (
                        <PortfolioList portfolios={portfolios} handleAction={handleRemove} />
                    ) : (
                            <p className="mb-4">No Portfolios Found</p>
                        )
                    }
                    {/* <p className="mb-4">Your watchlist is empty.</p> */}
                    {/* <StockList stocks={stocks} handleAction={() => { }} /> */}
                </div>
            </div>
        </div>
    )
}