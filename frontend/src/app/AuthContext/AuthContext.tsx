"use client";

import { createContext, useContext, useEffect, useState } from "react";
import axios from "axios";

type User = {
    userId: number;
    username: string;
}

type AuthContextType = {
    user: User | null;
    loading: boolean;
    isAuthenticated: boolean;
};

const AuthContext = createContext<AuthContextType | null>(null);

export const AuthProvider = ({ children} : { children: React.ReactNode }) => {
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState(true);
    
    useEffect(() => {
        const fetchUser = async () => {
        try {
            const response = await axios.get("http://localhost:8080/api/auth/check", { withCredentials: true });
            if (response.data.authenticated) {
                setUser(response.data.user);
            } else {
                setUser(null);
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
    
    return (
        <AuthContext.Provider value={{ user, loading , isAuthenticated: !!user }}>
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
