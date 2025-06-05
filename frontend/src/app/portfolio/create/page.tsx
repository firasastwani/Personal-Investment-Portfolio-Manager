"use client";
import TabBar from "@/components/TabBar"
import { useAuth } from "../../AuthContext/AuthContext";
import { useRouter } from "next/navigation";
import { useState, useEffect } from "react";
import axios from "axios";

type User = {
    userId: number;
    username: string;
}

interface Portfolio {
    user: User;
    name: string;
    description: string;
}

export default function CreatePortfolio() {
    const { user, loading, refreshUser } = useAuth();
    const router = useRouter();
    const [name, setName] = useState("");
    const [description, setDescription] = useState("");
    const [isSubmitting, setIsSubmitting] = useState(false);
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        if (!loading && !user) {
            router.push("/login");
        }
    }, [loading, user, router]);

    if (loading) {
        return <div>Loading...</div>;
    }

    if (!user) {
        return <div>Please log in to access the create portfolio page.</div>;
    }

    const handleSubmit = async (event: React.FormEvent) => {
        event.preventDefault();
        setError(null);
        setIsSubmitting(true);

        try {
            const portfolio = {
                name: name,
                description: description
            };

            const response = await axios.post("/api/portfolios", portfolio);
            console.log("Portfolio created:", response.data);
            router.push("/dashboard");
        } catch (error) {
            console.error("Error creating portfolio:", error);
            if (axios.isAxiosError(error)) {
                if (error.response?.status === 401) {
                    setError("Your session has expired. Please log in again.");
                    await refreshUser();
                } else {
                    setError("Failed to create portfolio. Please try again.");
                }
            } else {
                setError("An unexpected error occurred. Please try again.");
            }
        } finally {
            setIsSubmitting(false);
        }
    };

    return (
        <div className="flex-col min-h-screen bg-gray-100">
            <TabBar />
            <div className="flex-grow flex justify-center pt-4">
                <div className="bg-white p-6 rounded shadow-md w-96 text-center">
                    <h2 className="text-2xl font-bold mb-4">Create Portfolio</h2>
                    {error && (
                        <div className="mb-4 p-2 bg-red-100 text-red-700 rounded">
                            {error}
                        </div>
                    )}
                    <form onSubmit={handleSubmit} className="space-y-4">
                        <div className="mb-4">
                            <label htmlFor="name" className="block text-sm font-medium text-gray-700">Portfolio Name</label>
                            <input 
                                type="text" 
                                id="name" 
                                name="name" 
                                value={name}
                                onChange={(e) => setName(e.target.value)} 
                                required 
                                className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" 
                            />
                        </div>
                        <div className="mb-4">
                            <label htmlFor="description" className="block text-sm font-medium text-gray-700">Description</label>
                            <textarea 
                                id="description" 
                                name="description" 
                                value={description}
                                rows={3} 
                                onChange={(e) => setDescription(e.target.value)} 
                                required 
                                className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"
                            ></textarea>
                        </div>
                        <button 
                            type="submit" 
                            disabled={isSubmitting}
                            className={`w-full bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors ${isSubmitting ? 'opacity-50 cursor-not-allowed' : ''}`}
                        >
                            {isSubmitting ? 'Creating...' : 'Create Portfolio'}
                        </button>
                    </form>
                </div>
            </div>
        </div>
    );
}