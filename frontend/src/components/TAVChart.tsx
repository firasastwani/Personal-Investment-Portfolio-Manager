'use client';

import React, { useEffect, useState } from 'react';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  Filler,
} from 'chart.js';
import { Line } from 'react-chartjs-2';
import axios from 'axios';

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  Title,
  Tooltip,
  Legend,
  Filler
);

interface TAVDataPoint {
  date: string;
  tav: number;
  pnl: number;
  pnlPercentage: number;
}

interface TAVChartProps {
  days?: number;
}

const TAVChart: React.FC<TAVChartProps> = ({ days = 7 }) => {
  const [data, setData] = useState<TAVDataPoint[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchHistoricalData = async () => {
      try {
        setLoading(true);
        setError(null);
        
        // Get the token from localStorage (assuming it's stored there)
        const token = localStorage.getItem('token');
        
        const response = await axios.get(`/api/analytics/historical-tav?days=${days}`, {
          headers: {
            'Authorization': `Bearer ${token}`,
            'Content-Type': 'application/json'
          }
        });
        setData(response.data);
      } catch (error) {
        console.error('Error fetching historical TAV data:', error);
        setError('Failed to load historical data');
      } finally {
        setLoading(false);
      }
    };

    fetchHistoricalData();
  }, [days]);

  if (loading) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="text-gray-500">Loading chart...</div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="text-red-500">{error}</div>
      </div>
    );
  }

  if (data.length === 0) {
    return (
      <div className="flex justify-center items-center h-64">
        <div className="text-gray-500">No data available</div>
      </div>
    );
  }

  const chartData = {
    labels: data.map(point => {
      const date = new Date(point.date);
      return date.toLocaleDateString('en-US', { 
        month: 'short', 
        day: 'numeric' 
      });
    }),
    datasets: [
      {
        label: 'Total Account Value ($)',
        data: data.map(point => point.tav),
        borderColor: 'rgb(59, 130, 246)',
        backgroundColor: 'rgba(59, 130, 246, 0.1)',
        fill: true,
        tension: 0.4,
        pointBackgroundColor: 'rgb(59, 130, 246)',
        pointBorderColor: '#fff',
        pointBorderWidth: 2,
        pointRadius: 4,
      },
    ],
  };

  const options = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        display: true,
        position: 'top' as const,
      },
      title: {
        display: true,
        text: `TAV Performance (Last ${days} Days)`,
        font: {
          size: 16,
          weight: 'bold' as const,
        },
      },
      tooltip: {
        callbacks: {
          label: function(context: any) {
            const dataPoint = data[context.dataIndex];
            return [
              `TAV: $${dataPoint.tav.toFixed(2)}`,
              `Daily PnL: $${dataPoint.pnl.toFixed(2)} (${dataPoint.pnlPercentage.toFixed(2)}%)`,
            ];
          },
        },
      },
    },
    scales: {
      y: {
        beginAtZero: false,
        ticks: {
          callback: function(value: any) {
            return '$' + value.toLocaleString();
          },
        },
      },
    },
    interaction: {
      intersect: false,
      mode: 'index' as const,
    },
  };

  // Calculate summary statistics
  const currentTAV = data[data.length - 1]?.tav || 0;
  const previousTAV = data[data.length - 2]?.tav || currentTAV;
  const dailyChange = currentTAV - previousTAV;
  const dailyChangePercentage = previousTAV > 0 ? (dailyChange / previousTAV) * 100 : 0;
  
  const totalChange = data.length > 1 ? currentTAV - data[0].tav : 0;
  const totalChangePercentage = data[0]?.tav > 0 ? (totalChange / data[0].tav) * 100 : 0;

  return (
    <div className="bg-white p-6 rounded-lg shadow-md">
      <div className="mb-4">
        <h3 className="text-lg font-semibold text-gray-800 mb-2">Portfolio Performance</h3>
        
        {/* Summary Cards */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
          <div className="bg-blue-50 p-4 rounded-lg">
            <div className="text-sm text-blue-600 font-medium">Current TAV</div>
            <div className="text-2xl font-bold text-blue-800">
              ${currentTAV.toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}
            </div>
          </div>
          
          <div className={`p-4 rounded-lg ${dailyChange >= 0 ? 'bg-green-50' : 'bg-red-50'}`}>
            <div className={`text-sm font-medium ${dailyChange >= 0 ? 'text-green-600' : 'text-red-600'}`}>
              Daily Change
            </div>
            <div className={`text-xl font-bold ${dailyChange >= 0 ? 'text-green-800' : 'text-red-800'}`}>
              {dailyChange >= 0 ? '+' : ''}${dailyChange.toFixed(2)} ({dailyChangePercentage.toFixed(2)}%)
            </div>
          </div>
          
          <div className={`p-4 rounded-lg ${totalChange >= 0 ? 'bg-green-50' : 'bg-red-50'}`}>
            <div className={`text-sm font-medium ${totalChange >= 0 ? 'text-green-600' : 'text-red-600'}`}>
              {days}-Day Change
            </div>
            <div className={`text-xl font-bold ${totalChange >= 0 ? 'text-green-800' : 'text-red-800'}`}>
              {totalChange >= 0 ? '+' : ''}${totalChange.toFixed(2)} ({totalChangePercentage.toFixed(2)}%)
            </div>
          </div>
        </div>
      </div>
      
      {/* Chart */}
      <div className="h-80">
        <Line data={chartData} options={options} />
      </div>
    </div>
  );
};

export default TAVChart; 