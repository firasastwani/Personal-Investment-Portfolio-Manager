"use client";
import TabBar from "@/components/TabBar";
import { useAuth } from "../AuthContext/AuthContext";
import { useBalance } from "../context/BalanceContext";
import { useState } from "react";
import axios from "axios";
import TAVChart from "@/components/TAVChart";

export default function Profile() {
    const { user, loading } = useAuth();
    const { balance, refreshBalances } = useBalance();
    const [amount, setAmount] = useState("");
    const [error, setError] = useState("");
    const [success, setSuccess] = useState("");

    if (loading) {
        return <div>Loading...</div>;
    }

    if (!user) {
        return <div>Please log in to access profile.</div>;
    }

    const handleDeposit = async () => {
        try {
            setError("");
            setSuccess("");
            const depositAmount = parseFloat(amount);
            
            if (isNaN(depositAmount) || depositAmount <= 0) {
                setError("Please enter a valid positive amount");
                return;
            }

            await axios.post("/api/balance/add", null, {
                params: {
                    id: user.userId,
                    amount: depositAmount
                }
            });
            
            setSuccess("Deposit successful!");
            setAmount("");
            refreshBalances();
        } catch (error) {
            setError("Failed to process deposit. Please try again.");
        }
    };

    const handleWithdraw = async () => {
        try {
            setError("");
            setSuccess("");
            const withdrawAmount = parseFloat(amount);
            
            if (isNaN(withdrawAmount) || withdrawAmount <= 0) {
                setError("Please enter a valid positive amount");
                return;
            }

            if (withdrawAmount > balance) {
                setError("Insufficient balance for withdrawal");
                return;
            }

            await axios.post("/api/balance/subtract", null, {
                params: {
                    id: user.userId,
                    amount: withdrawAmount
                }
            });
            
            setSuccess("Withdrawal successful!");
            setAmount("");
            refreshBalances();
        } catch (error) {
            setError("Failed to process withdrawal. Please try again.");
        }
    };

    return (
        <>
            <div className="flex flex-col min-h-screen bg-gray-100">
                <TabBar />
                <div className="container mx-auto px-4 py-8">
                    <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
                        {/* User Profile Section */}
                        <div className="bg-white p-6 rounded shadow-md">
                            <h2 className="text-2xl font-bold mb-4 text-center">User Profile</h2>
                            <div className="space-y-4">
                                <p className="text-lg">Hello, <span className="font-semibold">{user.username}</span></p>
                                <p className="text-gray-600">User ID: <span className="font-mono">{user.userId}</span></p>
                                <p className="text-lg">Current Balance: <span className="font-bold text-blue-600">${balance.toFixed(2)}</span></p>
                                
                                <div className="mt-6 border-t pt-4">
                                    <h3 className="text-lg font-semibold mb-4">Account Actions</h3>
                                    <div className="space-y-4">
                                        <div>
                                            <input
                                                type="number"
                                                value={amount}
                                                onChange={(e) => setAmount(e.target.value)}
                                                placeholder="Enter amount"
                                                className="w-full p-3 border rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                                                min="0"
                                                step="0.01"
                                            />
                                        </div>
                                        
                                        <div className="flex gap-4">
                                            <button
                                                onClick={handleDeposit}
                                                className="flex-1 bg-green-500 text-white px-4 py-3 rounded-lg hover:bg-green-600 transition-colors font-medium"
                                            >
                                                Deposit
                                            </button>
                                            <button
                                                onClick={handleWithdraw}
                                                className="flex-1 bg-red-500 text-white px-4 py-3 rounded-lg hover:bg-red-600 transition-colors font-medium"
                                            >
                                                Withdraw
                                            </button>
                                        </div>

                                        {error && (
                                            <p className="text-red-500 text-sm">{error}</p>
                                        )}
                                        {success && (
                                            <p className="text-green-500 text-sm">{success}</p>
                                        )}
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* TAV Chart Section */}
                        <div className="bg-white p-6 rounded shadow-md">
                            <TAVChart days={7} />
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}