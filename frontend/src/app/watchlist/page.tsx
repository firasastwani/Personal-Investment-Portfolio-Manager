"use client";

import TabBar from "@/components/TabBar"
import { useAuth } from "../AuthContext/AuthContext";
import { useRouter } from "next/navigation";

export default function Watchlist() {
    const { user, loading } = useAuth();
    const router = useRouter();

    if (loading) {
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
            <div className="flex-grow justify-center pt-4 px-50">
                <div className="bg-white p-6 rounded shadow-md text-center">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-2xl font-bold mb-4">{user.username}'s Watchlist</h2>
                        <button onClick={handleOnClick} className="ml-2 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors">
                            Add Stock
                        </button>
                    </div>
                    <p className="mb-4">Your watchlist is empty.</p>
                </div>
            </div>
        </div>
    )
}