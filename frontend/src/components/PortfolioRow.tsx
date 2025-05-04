
interface Portfolio {
    id: number
    name: string;
    description: string;
    created_at: Date;
}

interface PortfolioRowProps {
    portfolio: Portfolio;
}


const WatchRow: React.FC<PortfolioRowProps> = ({ portfolio }) => {
    return (
        <tr className="hover:bg-gray-50" key={portfolio.id} data-id={portfolio.id}>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">{portfolio.name}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">{portfolio.description}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium">{portfolio.created_at.toLocaleDateString()}</div>
            </td>
            <td className="px-6 py-4 whitespace-nowrapo text-right">
                <button
                    className="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition-colors"
                    data-action="view-portfolio"
                >
                    View Portfolio
                </button>
            </td>
        </tr>
    )
}

export default WatchRow;