'use client';

import { useBalance } from '../context/BalanceContext';

export default function BalanceDisplay() {
    const { balance, totalAccountValue } = useBalance();

    return (
        <div className="fixed top-16 right-4 bg-white/80 backdrop-blur-sm rounded-lg shadow-sm p-2 text-sm z-40">
            <div className="flex flex-col items-end space-y-1">
                <div className="text-gray-600">
                    Balance: <span className="font-medium">${balance.toFixed(2)}</span>
                </div>
                <div className="text-gray-600">
                    TAV: <span className="font-medium">${totalAccountValue.toFixed(2)}</span>
                </div>
            </div>
        </div>
    );
} 