"use client";

import { createContext, useContext, useEffect, useState } from "react";
import { useRouter, usePathname } from "next/navigation";
import axios from "axios";
import Cookies from 'js-cookie';

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
    const pathname = usePathname();

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
                
                // If the error is 401 and we haven't tried to refresh the token yet
                if (error.response?.status === 401 && 
                    !originalRequest._retry && 
                    !originalRequest.url?.includes('/api/auth/refresh')) {
                    
                    originalRequest._retry = true;
                    try {
                        const refreshToken = localStorage.getItem('refreshToken');
                        if (!refreshToken) {
                            throw new Error('No refresh token available');
                        }

                        const response = await axios.post('/api/auth/refresh', { refreshToken });
                        const { token, refreshToken: newRefreshToken } = response.data;
                        
                        if (!token || !newRefreshToken) {
                            throw new Error('Invalid token response');
                        }

                        // Update tokens
                        localStorage.setItem('token', token);
                        localStorage.setItem('refreshToken', newRefreshToken);
                        
                        // Update the original request's authorization header
                        originalRequest.headers.Authorization = `Bearer ${token}`;
                        
                        // Retry the original request
                        return axios(originalRequest);
                    } catch (refreshError) {
                        console.error('Token refresh failed:', refreshError);
                        await handleLogout();
                        return Promise.reject(refreshError);
                    }
                }
                return Promise.reject(error);
            }
        );
    }, [router]);

    const handleLogout = async () => {
        try {
            const token = localStorage.getItem('token');
            if (token) {
                await axios.post("/api/auth/logout", {}, {
                    headers: { Authorization: `Bearer ${token}` }
                });
            }
        } catch (error) {
            console.error("Logout failed:", error);
        } finally {
            localStorage.removeItem('token');
            localStorage.removeItem('refreshToken');
            setUser(null);
            router.push("/login");
        }
    };

    // Handle authentication and redirection
    useEffect(() => {
        const checkAuth = async () => {
            // Don't check auth for public routes
            if (publicRoutes.includes(pathname)) {
                setLoading(false);
                return;
            }

            try {
                const response = await axios.get("/api/auth/check");
                if (response.data.authenticated) {
                    setUser(response.data.user);
                } else {
                    await handleLogout();
                }
            } catch (error) {
                console.error("Error checking authentication:", error);
                await handleLogout();
            } finally {
                setLoading(false);
            }
        };

        checkAuth();
    }, [pathname]);

    const login = async (username: string, password: string) => {
        try {
            const response = await axios.post("/api/auth/login", { username, password });
            const { token, refreshToken, user } = response.data;
            
            if (!token || !refreshToken) {
                throw new Error('Invalid response from server');
            }

            // Store tokens
            localStorage.setItem('token', token);
            localStorage.setItem('refreshToken', refreshToken);
            
            setUser(user);
            router.push("/dashboard");
        } catch (error) {
            console.error("Login failed:", error);
            throw error;
        }
    };

    const logout = handleLogout;

    const refreshUser = async () => {
        try {
            const response = await axios.get("/api/auth/check");
            if (response.data.authenticated) {
                setUser(response.data.user);
            } else {
                await handleLogout();
            }
        } catch (error) {
            console.error("Error refreshing user:", error);
            await handleLogout();
        }
    };
    
    // Show loading state while checking authentication
    if (loading) {
        return <div>Loading...</div>;
    }

    // Redirect to login if not authenticated and not on a public route
    if (!user && !publicRoutes.includes(pathname)) {
        router.push("/login");
        return null;
    }
    
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
