
interface Portfolio {
    id: number;
    name: string;
    symbol: string;
    quantity: number
    staticPrice: number;
}

interface PortfolioRowProps {
    portfolio: Portfolio;
}


const WatchRow: React.FC<PortfolioRowProps> = ({ portfolio }) => {
    return (
        <tr className="hover:bg-gray-50" key={portfolio.id} data-id={portfolio.symbol}>
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
                <div className="font-medium">{portfolio.staticPrice}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrapo text-right">
                <button
                    className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors"
                    data-action="action"
                >
                    Sell
                </button>
            </td>
        </tr>
    )
}

export default WatchRow;