import React, { useCallback } from "react";
import StockRow from "./StockRow";

interface Stock {
    id: number;
    symbol: string;
    name: string;
    price: number;
}

interface SuccessMessage {
    symbol: string;
    message: string;
    timestamp: number;
}

interface StockListProps {
    stocks: Stock[];
    handleAction: (symbol: string) => void;
    successMessages: SuccessMessage[];
}

const StockList: React.FC<StockListProps> = ({ stocks, handleAction, successMessages }) => {
    const handleTableClick = useCallback((event: React.MouseEvent<HTMLTableElement>) => {
        const target = event.target as HTMLElement;
        const button = target.closest("button[data-action='add-to-watchlist']");
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
                        <React.Fragment key={stock.id}>
                            <StockRow stock={stock} />
                            {successMessages.find(msg => msg.symbol === stock.symbol) && (
                                <tr>
                                    <td colSpan={4} className="px-6 py-2">
                                        <div className="bg-green-100 text-green-700 rounded p-2 text-sm">
                                            {successMessages.find(msg => msg.symbol === stock.symbol)?.message}
                                        </div>
                                    </td>
                                </tr>
                            )}
                        </React.Fragment>
                    ))}
                </tbody>
            </table>
        </div>
    );
};

export default StockList;