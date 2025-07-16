import React from "react";

interface SectorDiversificationProps {
  data: Array<{
    sector: string;
    numberOfSecurities: number;
    totalValue: number;
    percentageOfPortfolio: number;
  }>;
  loading: boolean;
  error: string | null;
}

const SectorDiversification: React.FC<SectorDiversificationProps> = ({ data, loading, error }) => {
  if (loading) return <div>Loading sector diversification...</div>;
  if (error) return <div className="text-red-500">{error}</div>;
  if (!data || data.length === 0) return <div>No sector diversification data available.</div>;

  return (
    <div className="overflow-x-auto my-6">
      <h2 className="text-xl font-bold mb-2">Sector Diversification</h2>
      <table className="min-w-full bg-white border rounded shadow">
        <thead>
          <tr>
            <th className="px-4 py-2">Sector</th>
            <th className="px-4 py-2"># Securities</th>
            <th className="px-4 py-2">Total Value</th>
            <th className="px-4 py-2">% of Portfolio</th>
          </tr>
        </thead>
        <tbody>
          {data.map((row, idx) => (
            <tr key={idx} className="border-t">
              <td className="px-4 py-2">{row.sector}</td>
              <td className="px-4 py-2">{row.numberOfSecurities}</td>
              <td className="px-4 py-2">${row.totalValue.toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 })}</td>
              <td className="px-4 py-2">{row.percentageOfPortfolio}%</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default SectorDiversification; 