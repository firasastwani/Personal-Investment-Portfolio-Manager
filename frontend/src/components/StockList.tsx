import React, { useCallback } from "react";
import StockRow from "./StockRow";

interface Stock {
    id: number;
    symbol: string;
    name: string;
    price: number;
}

interface StockListProps {
    stocks: Stock[];
}

const StockList: React.FC<StockListProps> = ({ stocks }) => {
    const handleTableClick = useCallback((event: React.MouseEvent<HTMLTableElement>) => {
        const target = event.target as HTMLElement;
        const button = target.closest("button[data-action='add-to-watchlist']");
        if (button) {
            const row = button.closest("tr");
            const symbol = row?.getAttribute('data-symbol');

            if (symbol) {
                handleAddToWatchList(symbol);
            }
        }
    }, []);

    const handleAddToWatchList = (symbol: string) => {
        console.log(`Adding ${symbol} to watchlist`);
    }

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
                        <StockRow
                            key={stock.id}
                            stock={stock}
                            onAddToWatchList={handleAddToWatchList}
                            onRemoveFromWatchList={() => {}}
                        />
                    ))}
                </tbody>
            </table>
        </div>
    )

}

export default StockList;