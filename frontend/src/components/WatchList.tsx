import React, { useCallback } from "react";
import axios from "axios";

interface Stock {
    id: number;
    symbol: string;
    name: string;
    staticPrice: number;
}

interface StockListProps {
    stocks: Stock[];
    handleAction: (symbol: string) => void;
}

const WatchList: React.FC<StockListProps> = ({ stocks, handleAction }) => {
    const handleTableClick = useCallback((event: React.MouseEvent<HTMLTableElement>) => {
        const target = event.target as HTMLElement;
        const button = target.closest("button[data-action='remove-from-watchlist']");
        if (button) {
            const row = button.closest("tr");
            const symbol = row?.getAttribute('data-symbol');
            if (symbol) {
                handleAction(symbol);
            }
        }
    }, [handleAction]);

    return (
        <div className="overflow-x-auto">
            <table className="min-w-full divide-y divide-gray-200"
                onClick={handleTableClick}
            >
                <thead>
                    <tr>
                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Name
                        </th>
                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Symbol
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
                    {stocks.map((stock) => (
                        <tr key={stock.id} data-symbol={stock.symbol}>
                            <td className="px-6 py-4 whitespace-nowrap">
                                <div className="font-medium">{stock.name}</div>
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap">
                                <div className="font-medium">{stock.symbol}</div>
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap">
                                <div className="font-medium">${stock.staticPrice.toFixed(2)}</div>
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap text-right">
                                <button
                                    className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors"
                                    data-action="remove-from-watchlist"
                                >
                                    Remove
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default WatchList;