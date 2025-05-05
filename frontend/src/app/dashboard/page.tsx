"use client";

import TabBar from "@/components/TabBar";
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

interface Portfolio {
    portfolioId: number;
    name: string;
    description: string;
    createdAt: string;
}

export default function Dashboard() {
    const { user, loading } = useAuth();
    const router = useRouter();
    const [portfolios, setPortfolios] = useState<Portfolio[]>([]);
    const [fetching, setFetching] = useState(true);

    const fetchPortfolios = async () => {
        if (!user || !user.username) {
            console.error("Username is not available");
            setFetching(false); // ← important!
            return;
        }
        try {
            const response = await fetch("http://localhost:8080/api/portfolios/getPortfoliosForUser", {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ username: user.username }),
                credentials: 'include'
            });

            if (!response.ok) {
                console.error("Failed to fetch portfolios");
                setFetching(false); // ← mark fetch done even if failed
                return;
            }

            const data = await response.json();
            setPortfolios(data);
        } catch (error) {
            console.error("Error fetching portfolios:", error);
        } finally {
            setFetching(false); // ← always stop fetching
        }
    };



    useEffect(() => {
        if (user) {
            fetchPortfolios();
        }
    }, [user]);

    const handleRemove = (id: number) => {
        console.log(`Removing portfolio with id: ${id}`);
        try {
            const response = fetch(`http://localhost:8080/api/portfolios/${id}`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json',
                },
                credentials: 'include'
            });
        } catch (error) {
            console.error("Error removing portfolio:", error);
        } finally {
            setPortfolios((prevPortfolios) => prevPortfolios.filter((portfolio) => portfolio.portfolioId !== id));
        }
        // Add logic here to remove the portfolio if necessary
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
    };

    return (
        <div className="flex flex-col min-h-screen bg-gray-100">
            <TabBar />
            <div className="flex-grow justify-center pt-4 px-20">
                <div className="bg-white p-6 rounded shadow-md w-full text-center">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-2xl font-bold mb-4">{user.username}'s Watchlist</h2>
                        <button
                            onClick={handleOnClick}
                            className="ml-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors"
                        >
                            Add New Portfolio
                        </button>
                    </div>
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
                                            onClick={() => router.push(`/portfolio/${portfolio.portfolioId}`)}
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
