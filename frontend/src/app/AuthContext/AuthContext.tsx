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
    login: (username: string, password: string) => Promise<void>;
    logout: () => Promise<void>;
};

const AuthContext = createContext<AuthContextType | null>(null);

export const AuthProvider = ({ children} : { children: React.ReactNode }) => {
    const [user, setUser] = useState<User | null>(null);
    const [loading, setLoading] = useState(true);
    const router = useRouter();

    const publicRoutes = ["/login", "/register"];
    
    // Configure axios defaults
    useEffect(() => {
        axios.defaults.baseURL = 'http://localhost:8080';
        
        // Add request interceptor to add token to all requests
        axios.interceptors.request.use((config) => {
            const token = localStorage.getItem('token');
            if (token) {
                config.headers.Authorization = `Bearer ${token}`;
            }
            return config;
        });

        // Add response interceptor to handle token refresh
        axios.interceptors.response.use(
            (response) => response,
            async (error) => {
                const originalRequest = error.config;
                if (error.response?.status === 401 && !originalRequest._retry) {
                    originalRequest._retry = true;
                    try {
                        const refreshToken = localStorage.getItem('refreshToken');
                        if (refreshToken) {
                            const response = await axios.post('/api/auth/refresh', { refreshToken });
                            const { token } = response.data;
                            localStorage.setItem('token', token);
                            originalRequest.headers.Authorization = `Bearer ${token}`;
                            return axios(originalRequest);
                        }
                    } catch (refreshError) {
                        console.error('Token refresh failed:', refreshError);
                        await logout();
                    }
                }
                return Promise.reject(error);
            }
        );
    }, []);

    useEffect(() => {
        const path = window.location.pathname;

        if (publicRoutes.includes(path)) {
            setLoading(false);
            return;
        }

        const fetchUser = async () => {
            try {
                const response = await axios.get("/api/auth/check");
                if (response.data.authenticated) {
                    console.log("User authenticated:", response.data.user);
                    setUser(response.data.user);
                } else {
                    console.log("User not authenticated");
                    console.log("Response data:", response.data);
                    router.push("/login");
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

    const login = async (username: string, password: string) => {
        try {
            const response = await axios.post("/api/auth/login", { username, password });
            const { token, refreshToken, user } = response.data;
            localStorage.setItem('token', token);
            localStorage.setItem('refreshToken', refreshToken);
            setUser(user);
            router.push("/dashboard");
        } catch (error) {
            console.error("Login failed:", error);
            throw error;
        }
    };

    const logout = async () => {
        try {
            await axios.post("/api/auth/logout");
        } catch (error) {
            console.error("Logout failed:", error);
        } finally {
            localStorage.removeItem('token');
            localStorage.removeItem('refreshToken');
            setUser(null);
            router.push("/login");
        }
    };

    const refreshUser = async () => {
        try {
            const response = await axios.get("/api/auth/check");
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
        <AuthContext.Provider value={{ user, loading, isAuthenticated: !!user, refreshUser, login, logout }}>
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
