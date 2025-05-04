"use client";
import TabBar from "@/components/TabBar"
import { useAuth } from "../../AuthContext/AuthContext";
import { useRouter } from "next/navigation";
import { useState } from "react";

type User = {
    userId: number;
    username: string;
}

export default function CreatePortfolio() {
    const { user, loading } = useAuth();
    const router = useRouter();

    const [name, setName] = useState("");
    const [description, setDescription] = useState("");

    if (loading) {
        return <div>Loading...</div>;
    }
    if (!user) {
        return <div>Please log in to access the create portfolio page.</div>;
    }

    interface Portfolio {
        user: User;
        name: string;
        description: string;
    }



    const handleSubmit = async (event: React.FormEvent) => {
        event.preventDefault();
        console.log("Creating portfolio with name:", name, "and description:", description);
        const portfolio: Portfolio = {
            user: user,
            name: name,
            description: description,
        }

        try {
            const response = await fetch("http://localhost:8080/api/portfolios", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(portfolio),
                credentials: "include",
            });
            if (!response.ok) {
                throw new Error("Network response was not ok");
            }
            const data = await response.json();
            console.log("Portfolio created:", data);
            router.push("/dashboard");
        } catch (error) {
            console.error("Error creating portfolio:", error);
        }

    }

    return (
        <div className=" flex-col min-h-screen bg-gray-100">
            <TabBar />
            <div className="flex-grow flex justify-center pt-4">
                <div className="bg-white p-6 rounded shadow-md w-96 text-center">
                    <h2 className="text-2xl font-bold mb-4">Create Portfolio</h2>
                    <form onSubmit={handleSubmit} className="space-y-4">
                        <div className="mb-4">
                            <label htmlFor="name" className="block text-sm font-medium text-gray-700">Portfolio Name</label>
                            <input type="text" id="name" name="name" onChange={(e) => setName(e.target.value)} required className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500" />
                        </div>
                        <div className="mb-4">
                            <label htmlFor="description" className="block text-sm font-medium text-gray-700">Description</label>
                            <textarea id="description" name="description" rows={3} onChange={(e) => setDescription(e.target.value)} required className="mt-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-blue-500 focus:border-blue-500"></textarea>
                        </div>
                        <button type="submit" className="w-full bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors">Create Portfolio</button>
                    </form>
                </div>
            </div>
        </div>
    );
}