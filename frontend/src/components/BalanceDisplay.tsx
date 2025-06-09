'use client';

import { useBalance } from '@/app/context/BalanceContext';
import { usePathname } from 'next/navigation';

export default function BalanceDisplay() {
    const { balance, totalAccountValue } = useBalance();
    const pathname = usePathname();
    const publicRoutes = ["/login", "/register"];

    // Don't show balance on public routes
    if (publicRoutes.includes(pathname)) {
        return null;
    }

    return (
        <div className="fixed top-16 right-4 bg-white p-4 rounded-lg shadow-md z-40">
            <div className="text-sm font-medium text-gray-500">Balance</div>
            <div className="text-lg font-bold text-gray-900">${balance.toFixed(2)}</div>
            <div className="text-sm font-medium text-gray-500 mt-2">Total Account Value</div>
            <div className="text-lg font-bold text-gray-900">${totalAccountValue.toFixed(2)}</div>
        </div>
    );
} 