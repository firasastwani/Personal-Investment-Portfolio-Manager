import React, { useState, useEffect } from 'react';

interface Stock {
    id: number;
    name: string;
    symbol: string;
    price: number;
}

interface StockSearchProps {
    stocks: Stock[];
    onSearch: (filteredStocks: Stock[]) => void;
}

const StockSearch: React.FC<StockSearchProps> = ({ stocks, onSearch }) => {
    const [searchTerm, setSearchTerm] = useState('');

    useEffect(() => {
        const filteredStocks = stocks.filter(stock => {
            const searchLower = searchTerm.toLowerCase();
            return (
                stock.name.toLowerCase().includes(searchLower) ||
                stock.symbol.toLowerCase().includes(searchLower)
            );
        });
        onSearch(filteredStocks);
    }, [searchTerm, stocks, onSearch]);

    return (
        <div className="mb-4">
            <input
                type="text"
                placeholder="Search by stock name or symbol..."
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                className="w-full p-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
        </div>
    );
};

export default StockSearch; 