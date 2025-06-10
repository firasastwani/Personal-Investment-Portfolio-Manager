"use client";
import TabBar from "@/components/TabBar";
import { useAuth } from "../AuthContext/AuthContext";
import { useBalance } from "../context/BalanceContext";
import { useState } from "react";
import axios from "axios";

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
                <div className="flex justify-center my-8">
                    <div className="bg-white p-6 rounded shadow-md w-96 text-center">
                        <h2 className="text-2xl font-bold mb-4">User Profile</h2>
                        <p className="mb-4">Hello, {user.username}</p>
                        <p className="mb-4">Your user ID is: {user.userId}</p>
                        <p className="mb-4">Current Balance: ${balance.toFixed(2)}</p>
                        
                        <div className="mt-6">
                            <div className="mb-4">
                                <input
                                    type="number"
                                    value={amount}
                                    onChange={(e) => setAmount(e.target.value)}
                                    placeholder="Enter amount"
                                    className="w-full p-2 border rounded"
                                    min="0"
                                    step="0.01"
                                />
                            </div>
                            
                            <div className="flex gap-4 justify-center">
                                <button
                                    onClick={handleDeposit}
                                    className="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600"
                                >
                                    Deposit
                                </button>
                                <button
                                    onClick={handleWithdraw}
                                    className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
                                >
                                    Withdraw
                                </button>
                            </div>

                            {error && (
                                <p className="text-red-500 mt-2">{error}</p>
                            )}
                            {success && (
                                <p className="text-green-500 mt-2">{success}</p>
                            )}
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}