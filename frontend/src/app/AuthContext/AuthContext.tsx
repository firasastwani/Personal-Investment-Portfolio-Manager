"use client";

import { createContext, useContext, useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import axios from "axios";

type User = {
    userId: number;
    username: string;
}

type AuthContextType = {
    user: User | null;
    loading: boolean;
    isAuthenticated: boolean;
    refreshUser: () => Promise<void>;
};

const AuthContext = createContext<AuthContextType | null>(null);

export const AuthProvider = ({ children} : { children: React.ReactNode }) => {
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState(true);
    const router = useRouter();

    const publicRoutes = ["/login", "/register"];
    
    useEffect(() => {

        const path = window.location.pathname;

        if (publicRoutes.includes(path)) {
            setLoading(false);
            return;
        }

        const fetchUser = async () => {
        try {
            const response = await axios.get("http://localhost:8080/api/auth/check", { withCredentials: true });
            if (response.data.authenticated) {
                console.log("User authenticated:", response.data.user);
                setUser(response.data.user);
            } else {
                console.log("User not authenticated");
                console.log("Response data:", response.data);
                router.push("/login"); // Redirect to login if not authenticated
            }
        } catch (error) {
            console.error("Error fetching user:", error);
            setUser(null);
        } finally {
            setLoading(false);
        }
        };
    
        fetchUser();
    }, []);

    const refreshUser = async () => {
        try {
            const response = await axios.get("http://localhost:8080/api/auth/check", { withCredentials: true });
            if (response.data.authenticated) {
                setUser(response.data.user);
            } else {
                setUser(null);
            }
        } catch (error) {
            console.error("Error refreshing user:", error);
            setUser(null);
        }
    };
    
    return (
        <AuthContext.Provider value={{ user, loading , isAuthenticated: !!user, refreshUser }}>
        {children}
        </AuthContext.Provider>
    );
}

export function useAuth() {
    const context = useContext(AuthContext);
    if (!context) {
        throw new Error("useAuth must be used within an AuthProvider");
    }
    return context;
}
