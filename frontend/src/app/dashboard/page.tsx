"use client";

import TabBar from "@/components/TabBar";
import { useAuth } from "../AuthContext/AuthContext";
import { useRouter } from "next/navigation";
import PortfolioList from "@/components/PortfolioList";
import { useEffect, useState } from "react";
import axios from "axios";

interface Stock {
    id: number;
    name: string;
    symbol: string;
    staticPrice: number;
}

interface Portfolio {
    portfolioId: number;
    name: string;
    description: string;
    createdAt: string;
}

export default function Dashboard() {
    const { user, loading, refreshUser } = useAuth();
    const router = useRouter();
    const [portfolios, setPortfolios] = useState<Portfolio[]>([]);
    const [fetching, setFetching] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchPortfolios = async () => {
        if (!user || !user.username) {
            console.error("Username is not available");
            setFetching(false);
            return;
        }
        try {
            const response = await axios.post("/api/portfolios/getPortfoliosForUser", 
                { username: user.username }
            );
            setPortfolios(response.data || []);
            setError(null);
        } catch (error) {
            console.error("Error fetching portfolios:", error);
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else if (error.response?.status === 404) {
                    setPortfolios([]);
                    setError(null);
                } else {
                    setError("Failed to fetch portfolios. Please try again.");
                }
            }
        } finally {
            setFetching(false);
        }
    };

    useEffect(() => {
        if (user) {
            fetchPortfolios();
        }
    }, [user]);

    const handleRemove = async (id: number) => {
        try {
            await axios.delete(`/api/portfolios/${id}`);
            setPortfolios(prevPortfolios => 
                prevPortfolios.filter(portfolio => portfolio.portfolioId !== id)
            );
        } catch (error) {
            console.error("Error removing portfolio:", error);
            if (axios.isAxiosError(error) && error.response?.status === 401) {
                await refreshUser();
            }
        }
    };

    if (loading) {
        return <div>Loading...</div>;
    }
    if (!user) {
        return <div>Please log in to access the dashboard.</div>;
    }

    const handleOnClick = () => {
        router.push("/portfolio/create");
    };

    return (
        <div className="flex flex-col min-h-screen bg-gray-100">
            <TabBar />
            <div className="flex-grow justify-center pt-4 px-20">
                <div className="bg-white p-6 rounded shadow-md w-full text-center">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-2xl font-bold mb-4">{user.username}'s Dashboard</h2>
                        <button
                            onClick={handleOnClick}
                            className="ml-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors"
                        >
                            Add New Portfolio
                        </button>
                    </div>
                    {error && (
                        <div className="mb-4 p-2 bg-red-100 text-red-700 rounded">
                            {error}
                        </div>
                    )}
                    {fetching ? (
                        <p>Loading portfolios...</p>
                    ) : portfolios.length > 0 ? (
                        <div>
                            {portfolios.map((portfolio) => (
                                <div key={portfolio.portfolioId} className="border-b py-4">
                                    <h3 className="text-xl font-semibold">{portfolio.name}</h3>
                                    <p className="text-gray-600">{portfolio.description}</p>
                                    <p className="text-sm text-gray-400">
                                        Created at: {new Date(portfolio.createdAt).toLocaleString()}
                                    </p>
                                    <div className="flex-col w-full">
                                        <button
                                            onClick={() => router.push(`/portfolio/${portfolio.portfolioId}?name=${portfolio.name}`)}
                                            className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors"
                                        >
                                            View Portfolio
                                        </button>
                                        <button
                                            onClick={() => handleRemove(portfolio.portfolioId)}
                                            className="text-red-500 border border-red-300 rounded py-2 hover:text-red-600"
                                        >
                                            Remove Portfolio
                                        </button>
                                    </div>
                                </div>
                            ))}
                        </div>
                    ) : (
                        <p className="mb-4">No Portfolios Found</p>
                    )}
                </div>
            </div>
        </div>
    );
}
