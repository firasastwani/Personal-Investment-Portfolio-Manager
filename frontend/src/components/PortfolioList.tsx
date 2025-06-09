'use client';

import React, { useCallback } from "react";
import axios from "axios";
import PortfolioRow from "./PortfolioRow";
import { useBalance } from '@/app/context/BalanceContext';

interface Stock {
    id: number;
    name: string;
    symbol: string;
    quantity: number;
    staticPrice: number;
}

interface StockListProps {
    portfolios: Stock[];
    handleAction: (symbol: string) => Promise<void>;
}

const PortfolioList: React.FC<StockListProps> = ({ portfolios, handleAction }) => {
    const { refreshBalances } = useBalance();

    const handleTableClick = useCallback(async (event: React.MouseEvent<HTMLTableElement>) => {
        const target = event.target as HTMLElement;
        const button = target.closest("button[data-action='sell']");
        if (button) {
            const row = button.closest("tr");
            const symbol = row?.getAttribute('data-symbol');
            if (symbol) {
                try {
                    await handleAction(symbol);
                    await refreshBalances();
                } catch (error) {
                    console.error('Error selling stock:', error);
                }
            }
        }
    }, [handleAction, refreshBalances]);

    const handleAddToWatchList = (symbol: string) => {
        console.log(`Adding ${symbol} to watchlist`);
        try {
            const response = fetch(`http://localhost:8080/api/watchlist/${symbol}`, {
                method: "POST",
                credentials: "include",
            });
        } catch (error) {
            console.error("Error adding to watchlist:", error);
        }
    }

    return (
        <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200" onClick={handleTableClick}>
                <thead>
                    <tr>
                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Name
                        </th>
                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Symbol
                        </th>
                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Quantity
                        </th>
                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Price
                        </th>
                        <th scope="col" className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Action
                        </th>
                    </tr>
                </thead>
                <tbody className="bg-white divide-y divide-gray-200">
                    {portfolios.map((portfolio) => (
                        <PortfolioRow
                            key={portfolio.id}
                            portfolio={portfolio}
                        />
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default PortfolioList;