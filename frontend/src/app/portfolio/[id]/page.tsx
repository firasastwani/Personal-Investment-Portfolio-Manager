"use client";

import TabBar from "@/components/TabBar"
import PortfolioList from "@/components/PortfolioList"
import { useAuth } from "../../AuthContext/AuthContext";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { useParams, useSearchParams } from "next/navigation";
import axios from "axios";
import SectorDiversification from "@/components/SectorDiversification";
import React from "react";

interface Stock {
    id: number;
    symbol: string;
    name: string;
    price: number;
}

interface portfolioData {
    id: number;
    name: string;
    symbol: string;
    quantity: number
    price: number;
}

export default function PortfolioPage() {
    const { user, loading, refreshUser } = useAuth();
    const router = useRouter();
    const [stocks, setStocks] = useState<portfolioData[]>([]);
    const [fetching, setFetching] = useState(true);
    const [totalValue, setTotalValue] = useState(0);
    const [error, setError] = useState<string | null>(null);
    const [success, setSuccess] = useState<string | null>(null);
    const [sectorData, setSectorData] = useState<any[]>([]);
    const [sectorLoading, setSectorLoading] = useState(true);
    const [sectorError, setSectorError] = useState<string | null>(null);
    const [showSectorModal, setShowSectorModal] = useState(false);

    const params = useParams();
    const id = params.id as string;

    const searchParams = useSearchParams();
    const name = searchParams.get("name") as string;

    const handleOnClick = () => {
        console.log("Add stock button clicked")
        router.push(`/buy/${id}`)
    }

    const handleRemove = async (symbol: string, quantity: number) => {
        try {
            setError(null);
            setSuccess(null);
            await axios.post(`/api/holdings/sell/${id}/${symbol}?quantity=${quantity}`);
            setSuccess(`Successfully sold ${quantity} of ${symbol}`);
            setStocks(prevStocks =>
                prevStocks.flatMap(stock => {
                    if (stock.symbol === symbol) {
                        if (stock.quantity > quantity) {
                            return [{ ...stock, quantity: stock.quantity - quantity }];
                        } else {
                            return []; // Remove stock if all sold
                        }
                    }
                    return [stock];
                })
            );
            await fetchTotal(); // Refresh total value after selling
        } catch (error) {
            console.error("Error removing stock:", error);
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else {
                    setError("Failed to remove stock. Please try again.");
                }
            } else {
                setError("An unexpected error occurred. Please try again.");
            }
        }
    }

    const fetchTotal = async () => {
        try {
            setError(null);
            const response = await axios.get(`/api/analytics/portfolio/${id}/total-value`);
            setTotalValue(response.data);
        } catch (error) {
            console.error("Error fetching totals:", error);
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else {
                    setError("Failed to fetch portfolio value. Please try again.");
                }
            } else {
                setError("An unexpected error occurred. Please try again.");
            }
        }
    }

    const fetchStocks = async () => {
        try {
            setError(null);
            const response = await axios.get(`/api/holdings/portfolio/${id}`);
            const stocksData = response.data.map((stock: any) => ({
                id: stock.id,
                name: stock.security.name,
                symbol: stock.security.symbol,
                quantity: stock.quantity,
                price: stock.security.price,
            }));
            setStocks(stocksData);
        } catch (error) {
            console.error("Error fetching stocks:", error);
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else {
                    setError("Failed to fetch portfolio stocks. Please try again.");
                }
            } else {
                setError("An unexpected error occurred. Please try again.");
            }
        } finally {
            setFetching(false);
        }
    };

    const fetchSectorDiversification = async () => {
        try {
            setSectorError(null);
            setSectorLoading(true);
            const response = await axios.get(`/api/analytics/portfolio/${id}/sector-diversification`);
            setSectorData(response.data);
        } catch (error) {
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setSectorError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else {
                    setSectorError("Failed to fetch sector diversification. Please try again.");
                }
            } else {
                setSectorError("An unexpected error occurred. Please try again.");
            }
        } finally {
            setSectorLoading(false);
        }
    };

    useEffect(() => {
        if (user) {
            console.log("Fetching stocks for user:", user.username);
            fetchStocks();
            fetchSectorDiversification();
        }
    }, [user]);

    useEffect(() => {
        fetchTotal();
    }, [stocks])

    if (loading) {
        return <div>Loading...</div>;
    }

    if (!user) {
        return <div>Please log in to view your portfolio.</div>;
    }

    return (
        <div className="flex flex-col min-h-screen bg-gray-100">
            <TabBar />
            <div className="flex-grow justify-center pt-4 px-20">
                <div className="bg-white p-6 rounded shadow-md w-full text-center">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-2xl font-bold mb-4">Portfolio: {name}</h2>
                        <h3 className="text-xl mb-4">Total Value: ${totalValue.toFixed(2)}</h3>
                        <div className="flex space-x-2">
                            <button
                                onClick={handleOnClick}
                                className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors"
                            >
                                Buy Stock
                            </button>
                            <button
                                onClick={() => setShowSectorModal(true)}
                                className="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition-colors"
                            >
                                Sector Diversification
                            </button>
                        </div>
                    </div>
                    {error && (
                        <div className="mb-4 p-4 bg-red-100 text-red-700 rounded">
                            {error}
                        </div>
                    )}
                    {success && (
                        <div className="mb-4 p-4 bg-green-100 text-green-700 rounded">
                            {success}
                        </div>
                    )}
                    {fetching ? (
                        <p className="mb-4">Fetching stocks...</p>
                    ) : stocks.length > 0 ? (
                        <PortfolioList portfolios={stocks} handleAction={handleRemove} />
                    ) : (
                        <p className="mb-4">Your portfolio is empty.</p>
                    )}
                    {/* Modal for Sector Diversification */}
                    {showSectorModal && (
                        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40">
                            <div className="bg-white rounded-lg shadow-lg p-6 w-full max-w-2xl relative">
                                <button
                                    onClick={() => setShowSectorModal(false)}
                                    className="absolute top-2 right-2 text-gray-500 hover:text-gray-800 text-2xl font-bold"
                                    aria-label="Close"
                                >
                                    &times;
                                </button>
                                <SectorDiversification data={sectorData} loading={sectorLoading} error={sectorError} />
                            </div>
                        </div>
                    )}
                </div>
            </div>
        </div>
    )
}