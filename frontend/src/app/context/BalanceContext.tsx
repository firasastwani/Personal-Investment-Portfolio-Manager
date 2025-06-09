'use client';

import { createContext, useContext, useState, useEffect, ReactNode } from 'react';
import axios from 'axios';
import { useAuth } from '../AuthContext/AuthContext';

interface BalanceContextType {
    balance: number;
    totalAccountValue: number;
    refreshBalances: () => Promise<void>;
}

const BalanceContext = createContext<BalanceContextType | null>(null);

export const useBalance = () => {
    const context = useContext(BalanceContext);
    if (!context) {
        throw new Error('useBalance must be used within a BalanceProvider');
    }
    return context;
};

export const BalanceProvider = ({ children }: { children: ReactNode }) => {
    const [balance, setBalance] = useState<number>(0);
    const [totalAccountValue, setTotalAccountValue] = useState<number>(0);
    const { user } = useAuth();

    const refreshBalances = async () => {
        if (!user) return;
        
        try {
            const [balanceRes, tavRes] = await Promise.all([
                axios.get(`/api/balance/${user.userId}`),
                axios.get('/api/analytics/total-account-value')
            ]);
            
            setBalance(balanceRes.data);
            setTotalAccountValue(tavRes.data);
        } catch (error) {
            console.error('Error fetching balances:', error);
        }
    };

    useEffect(() => {
        if (user) {
            refreshBalances();
            // Refresh balances every minute
            const interval = setInterval(refreshBalances, 60000);
            return () => clearInterval(interval);
        }
    }, [user]);

    return (
        <BalanceContext.Provider value={{ balance, totalAccountValue, refreshBalances }}>
            {children}
        </BalanceContext.Provider>
    );
}; 