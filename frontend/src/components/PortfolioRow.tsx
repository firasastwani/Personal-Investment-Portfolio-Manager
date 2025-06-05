interface Portfolio {
    id: number;
    name: string;
    symbol: string;
    quantity: number
    staticPrice: number;
}

interface PortfolioRowProps {
    portfolio: {
        id: number;
        name: string;
        symbol: string;
        quantity: number;
        staticPrice: number;
    };
}

const PortfolioRow: React.FC<PortfolioRowProps> = ({ portfolio }) => {
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
                <div className="font-medium">${portfolio.staticPrice.toFixed(2)}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap text-right">
                <button
                    className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition-colors"
                    data-action="sell"
                >
                    Sell
                </button>
            </td>
        </tr>
    );
};

export default PortfolioRow;