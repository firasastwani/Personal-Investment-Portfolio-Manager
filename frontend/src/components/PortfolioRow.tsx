import React, { useState } from "react";

interface Portfolio {
    id: number;
    name: string;
    symbol: string;
    quantity: number
    price: number;
}

interface Stock {
    id: number;
    symbol: string;
    name: string;
    price: number;
}

interface PortfolioRowProps {
    portfolio: {
        id: number;
        name: string;
        symbol: string;
        quantity: number;
        price: number;
    };
}

const PortfolioRow: React.FC<PortfolioRowProps> = ({ portfolio }) => {
    const [sellQty, setSellQty] = useState(1);
    return (
        <tr className="hover:bg-gray-50" key={portfolio.id} data-symbol={portfolio.symbol}>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">{portfolio.name}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">{portfolio.symbol}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">{portfolio.quantity}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">${portfolio.price.toFixed(2)}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap text-right">
                <div className="flex items-center space-x-2 justify-end">
                    <input
                        type="range"
                        min={1}
                        max={portfolio.quantity}
                        value={sellQty}
                        onChange={e => setSellQty(Number(e.target.value))}
                        className="w-24"
                        disabled={portfolio.quantity <= 1}
                    />
                    <span className="w-6 text-center">{sellQty}</span>
                    <button
                        className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition-colors"
                        data-action="sell"
                        data-quantity={sellQty}
                        disabled={portfolio.quantity === 0}
                    >
                        Sell
                    </button>
                </div>
            </td>
        </tr>
    );
};

export default PortfolioRow;