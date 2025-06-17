import React, { useState } from 'react';

interface Stock {
    id: number
    symbol: string;
    name: string;
    price: number;
}

interface StockRowProps {
    stock: Stock;
    onBuy: (symbol: string, quantity: number) => void;
}

const BuyRow: React.FC<StockRowProps> = ({ stock, onBuy }) => {
    const [quantity, setQuantity] = useState(1);

    const handleQuantityChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const value = parseInt(e.target.value);
        if (!isNaN(value) && value > 0) {
            setQuantity(value);
        }
    };

    const incrementQuantity = () => {
        setQuantity(prev => prev + 1);
    };

    const decrementQuantity = () => {
        setQuantity(prev => Math.max(1, prev - 1));
    };

    return (
        <tr className="hover:bg-gray-50" key={stock.id} data-symbol={stock.symbol}>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">{stock.name}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">{stock.symbol}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">${stock.price.toFixed(2)}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap text-right">
                <div className="flex items-center justify-end space-x-2">
                    <div className="flex items-center border rounded">
                        <button
                            onClick={decrementQuantity}
                            className="px-2 py-1 text-gray-600 hover:bg-gray-100"
                        >
                            -
                        </button>
                        <input
                            type="number"
                            min="1"
                            value={quantity}
                            onChange={handleQuantityChange}
                            className="w-16 text-center border-x py-1"
                        />
                        <button
                            onClick={incrementQuantity}
                            className="px-2 py-1 text-gray-600 hover:bg-gray-100"
                        >
                            +
                        </button>
                    </div>
                    <button
                        onClick={() => onBuy(stock.symbol, quantity)}
                        className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors"
                    >
                        Buy
                    </button>
                </div>
            </td>
        </tr>
    );
};

export default BuyRow;