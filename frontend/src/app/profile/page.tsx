"use client";
import TabBar from "@/components/TabBar";
import { useAuth } from "../AuthContext/AuthContext";

export default function Profile() {
    const { user, loading } = useAuth();

    if (loading) {
        return <div>Loading...</div>;
    }

    if (!user) {
        return <div>Please log in to access profile.</div>;
    }

    return (
        <>
            <div className="flex flex-col min-h-screen bg-gray-100">
                <TabBar />
                <div className="flex-grow flex items-center justify-center">
                    <div className="bg-white p-6 rounded shadow-md w-96 text-center">
                        <h2 className="text-2xl font-bold mb-4">User Profile</h2>
                        <p className="mb-4">Hello, {user.username}!</p>
                        <p>Your user ID is: {user.userId}</p>
                    </div>
                </div>
            </div>
        </>
    );
}