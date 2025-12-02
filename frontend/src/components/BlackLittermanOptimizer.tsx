"use client";

import React, { useState, useEffect } from "react";
import axios from "axios";

interface Stock {
  id: number;
  symbol: string;
  name: string;
  quantity: number;
  price: number;
}

interface ViewInput {
  ticker: string;
  expectedReturn: number;
  confidence: number;
  enabled: boolean;
}

interface WeightResult {
  ticker: string;
  weight: number;
  percentage: string;
}

interface OptimizationResult {
  success: boolean;
  optimalWeights: WeightResult[];
  expectedReturn: number;
  volatility: number;
  sharpeRatio: number;
  expectedReturnPct: string;
  volatilityPct: string;
  error?: string;
}

interface BlackLittermanOptimizerProps {
  portfolioId: string;
  stocks: Stock[];
  onClose: () => void;
}

const BlackLittermanOptimizer: React.FC<BlackLittermanOptimizerProps> = ({
  portfolioId,
  stocks,
  onClose,
}) => {
  const [views, setViews] = useState<ViewInput[]>([]);
  const [loading, setLoading] = useState(false);
  const [result, setResult] = useState<OptimizationResult | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [step, setStep] = useState<"input" | "result">("input");

  // Initialize views for each stock
  useEffect(() => {
    const initialViews: ViewInput[] = stocks.map((stock) => ({
      ticker: stock.symbol,
      expectedReturn: 0.1, // Default 10%
      confidence: 0.5, // Default 50%
      enabled: false,
    }));
    setViews(initialViews);
  }, [stocks]);

  const handleViewChange = (
    index: number,
    field: keyof ViewInput,
    value: number | boolean
  ) => {
    setViews((prev) => {
      const updated = [...prev];
      updated[index] = { ...updated[index], [field]: value };
      return updated;
    });
  };

  const handleSubmit = async () => {
    setLoading(true);
    setError(null);

    // Filter only enabled views
    const enabledViews = views
      .filter((v) => v.enabled)
      .map((v) => ({
        ticker: v.ticker,
        expectedReturn: v.expectedReturn,
        confidence: v.confidence,
      }));

    try {
      const response = await axios.post(
        `/api/optimization/portfolio/${portfolioId}/black-litterman`,
        { views: enabledViews }
      );

      if (response.data.success) {
        setResult(response.data);
        setStep("result");
      } else {
        setError(response.data.error || "Optimization failed");
      }
    } catch (err) {
      if (axios.isAxiosError(err)) {
        setError(
          err.response?.data?.error ||
            "Failed to connect to optimization service"
        );
      } else {
        setError("An unexpected error occurred");
      }
    } finally {
      setLoading(false);
    }
  };

  const enabledViewsCount = views.filter((v) => v.enabled).length;

  const getConfidenceColor = (confidence: number) => {
    if (confidence >= 0.7) return "bg-emerald-500";
    if (confidence >= 0.4) return "bg-amber-500";
    return "bg-rose-500";
  };

  const getReturnColor = (expectedReturn: number) => {
    if (expectedReturn >= 0.15) return "text-emerald-600";
    if (expectedReturn >= 0.05) return "text-amber-600";
    if (expectedReturn >= 0) return "text-slate-600";
    return "text-rose-600";
  };

  const getWeightBarColor = (weight: number) => {
    const hue = Math.min(weight * 360, 120); // 0 = red, 120 = green
    return `hsl(${hue}, 70%, 50%)`;
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center">
      {/* Backdrop with blur */}
      <div
        className="absolute inset-0 bg-slate-900/60 backdrop-blur-sm"
        onClick={onClose}
      />

      {/* Modal */}
      <div className="relative bg-white rounded-2xl shadow-2xl w-full max-w-4xl max-h-[90vh] overflow-hidden flex flex-col">
        {/* Header */}
        <div className="bg-gradient-to-r from-indigo-600 via-purple-600 to-pink-500 px-8 py-6">
          <div className="flex justify-between items-center">
            <div>
              <h2 className="text-2xl font-bold text-white tracking-tight">
                Black-Litterman Portfolio Optimizer
              </h2>
              <p className="text-indigo-100 mt-1 text-sm">
                {step === "input"
                  ? "Express your views on expected returns for each stock"
                  : "Optimized portfolio allocation based on your views"}
              </p>
            </div>
            <button
              onClick={onClose}
              className="text-white/80 hover:text-white hover:bg-white/20 rounded-full p-2 transition-all"
              aria-label="Close"
            >
              <svg
                className="w-6 h-6"
                fill="none"
                stroke="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeWidth={2}
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>
        </div>

        {/* Content */}
        <div className="flex-1 overflow-y-auto p-8">
          {error && (
            <div className="mb-6 p-4 bg-rose-50 border border-rose-200 text-rose-700 rounded-xl flex items-center gap-3">
              <svg
                className="w-5 h-5 flex-shrink-0"
                fill="currentColor"
                viewBox="0 0 20 20"
              >
                <path
                  fillRule="evenodd"
                  d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                  clipRule="evenodd"
                />
              </svg>
              <span>{error}</span>
            </div>
          )}

          {step === "input" && (
            <>
              {/* Info Card */}
              <div className="mb-6 p-4 bg-gradient-to-r from-indigo-50 to-purple-50 border border-indigo-100 rounded-xl">
                <div className="flex items-start gap-3">
                  <div className="p-2 bg-indigo-100 rounded-lg">
                    <svg
                      className="w-5 h-5 text-indigo-600"
                      fill="none"
                      stroke="currentColor"
                      viewBox="0 0 24 24"
                    >
                      <path
                        strokeLinecap="round"
                        strokeLinejoin="round"
                        strokeWidth={2}
                        d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                      />
                    </svg>
                  </div>
                  <div>
                    <h4 className="font-semibold text-indigo-900">
                      How it works
                    </h4>
                    <p className="text-sm text-indigo-700 mt-1">
                      Toggle on the stocks you have views about, set your
                      expected annual return and confidence level. The
                      Black-Litterman model will blend your views with market
                      equilibrium to suggest optimal portfolio weights.
                    </p>
                  </div>
                </div>
              </div>

              {/* Views Input Table */}
              <div className="space-y-3">
                {views.map((view, index) => {
                  const stock = stocks.find((s) => s.symbol === view.ticker);
                  return (
                    <div
                      key={view.ticker}
                      className={`p-4 rounded-xl border-2 transition-all duration-200 ${
                        view.enabled
                          ? "border-indigo-300 bg-indigo-50/50 shadow-md"
                          : "border-slate-200 bg-slate-50/50 hover:border-slate-300"
                      }`}
                    >
                      <div className="flex items-center gap-4">
                        {/* Toggle */}
                        <button
                          onClick={() =>
                            handleViewChange(index, "enabled", !view.enabled)
                          }
                          className={`relative w-12 h-6 rounded-full transition-colors duration-200 ${
                            view.enabled ? "bg-indigo-500" : "bg-slate-300"
                          }`}
                        >
                          <span
                            className={`absolute top-0.5 left-0.5 w-5 h-5 bg-white rounded-full shadow transition-transform duration-200 ${
                              view.enabled ? "translate-x-6" : "translate-x-0"
                            }`}
                          />
                        </button>

                        {/* Stock Info */}
                        <div className="flex-1 min-w-0">
                          <div className="flex items-center gap-2">
                            <span className="font-bold text-slate-900 text-lg">
                              {view.ticker}
                            </span>
                            <span className="text-slate-500 text-sm truncate">
                              {stock?.name}
                            </span>
                          </div>
                          <div className="text-xs text-slate-400">
                            {stock?.quantity} shares @ ${stock?.price.toFixed(2)}
                          </div>
                        </div>

                        {/* Expected Return */}
                        <div
                          className={`transition-opacity duration-200 ${
                            view.enabled ? "opacity-100" : "opacity-40"
                          }`}
                        >
                          <label className="block text-xs font-medium text-slate-500 mb-1">
                            Expected Return
                          </label>
                          <div className="flex items-center gap-2">
                            <input
                              type="range"
                              min="-0.3"
                              max="0.5"
                              step="0.01"
                              value={view.expectedReturn}
                              onChange={(e) =>
                                handleViewChange(
                                  index,
                                  "expectedReturn",
                                  parseFloat(e.target.value)
                                )
                              }
                              disabled={!view.enabled}
                              className="w-24 h-2 bg-slate-200 rounded-lg appearance-none cursor-pointer accent-indigo-600"
                            />
                            <span
                              className={`w-16 text-right font-mono font-bold ${getReturnColor(
                                view.expectedReturn
                              )}`}
                            >
                              {(view.expectedReturn * 100).toFixed(0)}%
                            </span>
                          </div>
                        </div>

                        {/* Confidence */}
                        <div
                          className={`transition-opacity duration-200 ${
                            view.enabled ? "opacity-100" : "opacity-40"
                          }`}
                        >
                          <label className="block text-xs font-medium text-slate-500 mb-1">
                            Confidence
                          </label>
                          <div className="flex items-center gap-2">
                            <input
                              type="range"
                              min="0.1"
                              max="0.99"
                              step="0.01"
                              value={view.confidence}
                              onChange={(e) =>
                                handleViewChange(
                                  index,
                                  "confidence",
                                  parseFloat(e.target.value)
                                )
                              }
                              disabled={!view.enabled}
                              className="w-24 h-2 bg-slate-200 rounded-lg appearance-none cursor-pointer accent-indigo-600"
                            />
                            <span
                              className={`w-14 text-center text-xs font-bold text-white px-2 py-0.5 rounded-full ${getConfidenceColor(
                                view.confidence
                              )}`}
                            >
                              {(view.confidence * 100).toFixed(0)}%
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>
                  );
                })}
              </div>

              {stocks.length === 0 && (
                <div className="text-center py-12 text-slate-500">
                  <svg
                    className="w-16 h-16 mx-auto mb-4 text-slate-300"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={1.5}
                      d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"
                    />
                  </svg>
                  <p>No stocks in portfolio to optimize</p>
                </div>
              )}
            </>
          )}

          {step === "result" && result && (
            <>
              {/* Metrics Summary */}
              <div className="grid grid-cols-3 gap-4 mb-8">
                <div className="bg-gradient-to-br from-emerald-50 to-teal-50 border border-emerald-200 rounded-xl p-5">
                  <div className="text-sm font-medium text-emerald-600 mb-1">
                    Expected Return
                  </div>
                  <div className="text-3xl font-bold text-emerald-700">
                    {result.expectedReturnPct}
                  </div>
                  <div className="text-xs text-emerald-500 mt-1">
                    Annualized
                  </div>
                </div>
                <div className="bg-gradient-to-br from-amber-50 to-orange-50 border border-amber-200 rounded-xl p-5">
                  <div className="text-sm font-medium text-amber-600 mb-1">
                    Volatility
                  </div>
                  <div className="text-3xl font-bold text-amber-700">
                    {result.volatilityPct}
                  </div>
                  <div className="text-xs text-amber-500 mt-1">
                    Annualized Risk
                  </div>
                </div>
                <div className="bg-gradient-to-br from-indigo-50 to-purple-50 border border-indigo-200 rounded-xl p-5">
                  <div className="text-sm font-medium text-indigo-600 mb-1">
                    Sharpe Ratio
                  </div>
                  <div className="text-3xl font-bold text-indigo-700">
                    {result.sharpeRatio.toFixed(2)}
                  </div>
                  <div className="text-xs text-indigo-500 mt-1">
                    Risk-Adjusted Return
                  </div>
                </div>
              </div>

              {/* Optimal Weights */}
              <h3 className="text-lg font-bold text-slate-800 mb-4">
                Recommended Allocation
              </h3>
              <div className="space-y-3">
                {result.optimalWeights
                  .sort((a, b) => b.weight - a.weight)
                  .map((weight) => {
                    const stock = stocks.find((s) => s.symbol === weight.ticker);
                    const maxWeight = Math.max(
                      ...result.optimalWeights.map((w) => w.weight)
                    );
                    const barWidth = (weight.weight / maxWeight) * 100;

                    return (
                      <div
                        key={weight.ticker}
                        className="bg-white border border-slate-200 rounded-xl p-4 hover:shadow-md transition-shadow"
                      >
                        <div className="flex items-center justify-between mb-2">
                          <div className="flex items-center gap-3">
                            <div
                              className="w-10 h-10 rounded-lg flex items-center justify-center text-white font-bold text-sm"
                              style={{
                                backgroundColor: getWeightBarColor(weight.weight),
                              }}
                            >
                              {weight.ticker.slice(0, 2)}
                            </div>
                            <div>
                              <div className="font-bold text-slate-900">
                                {weight.ticker}
                              </div>
                              <div className="text-xs text-slate-500">
                                {stock?.name}
                              </div>
                            </div>
                          </div>
                          <div className="text-right">
                            <div className="text-2xl font-bold text-slate-900">
                              {weight.percentage}
                            </div>
                          </div>
                        </div>
                        {/* Weight Bar */}
                        <div className="h-2 bg-slate-100 rounded-full overflow-hidden">
                          <div
                            className="h-full rounded-full transition-all duration-500"
                            style={{
                              width: `${barWidth}%`,
                              backgroundColor: getWeightBarColor(weight.weight),
                            }}
                          />
                        </div>
                      </div>
                    );
                  })}
              </div>

              {/* Disclaimer */}
              <div className="mt-6 p-4 bg-slate-50 border border-slate-200 rounded-xl">
                <div className="flex items-start gap-3">
                  <svg
                    className="w-5 h-5 text-slate-400 flex-shrink-0 mt-0.5"
                    fill="currentColor"
                    viewBox="0 0 20 20"
                  >
                    <path
                      fillRule="evenodd"
                      d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z"
                      clipRule="evenodd"
                    />
                  </svg>
                  <p className="text-sm text-slate-500">
                    These recommendations are based on the Black-Litterman model
                    using your stated views. This is not financial advice. Past
                    performance does not guarantee future results.
                  </p>
                </div>
              </div>
            </>
          )}
        </div>

        {/* Footer */}
        <div className="border-t border-slate-200 px-8 py-4 bg-slate-50">
          <div className="flex justify-between items-center">
            {step === "input" ? (
              <>
                <div className="text-sm text-slate-500">
                  {enabledViewsCount} of {stocks.length} stocks selected
                </div>
                <div className="flex gap-3">
                  <button
                    onClick={onClose}
                    className="px-5 py-2.5 text-slate-600 hover:text-slate-800 font-medium transition-colors"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={handleSubmit}
                    disabled={loading || stocks.length === 0}
                    className="px-6 py-2.5 bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-700 hover:to-purple-700 text-white font-semibold rounded-xl shadow-lg shadow-indigo-500/30 disabled:opacity-50 disabled:cursor-not-allowed transition-all flex items-center gap-2"
                  >
                    {loading ? (
                      <>
                        <svg
                          className="animate-spin h-4 w-4"
                          viewBox="0 0 24 24"
                        >
                          <circle
                            className="opacity-25"
                            cx="12"
                            cy="12"
                            r="10"
                            stroke="currentColor"
                            strokeWidth="4"
                            fill="none"
                          />
                          <path
                            className="opacity-75"
                            fill="currentColor"
                            d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                          />
                        </svg>
                        Optimizing...
                      </>
                    ) : (
                      <>
                        <svg
                          className="w-4 h-4"
                          fill="none"
                          stroke="currentColor"
                          viewBox="0 0 24 24"
                        >
                          <path
                            strokeLinecap="round"
                            strokeLinejoin="round"
                            strokeWidth={2}
                            d="M13 10V3L4 14h7v7l9-11h-7z"
                          />
                        </svg>
                        Run Optimization
                      </>
                    )}
                  </button>
                </div>
              </>
            ) : (
              <>
                <button
                  onClick={() => setStep("input")}
                  className="px-5 py-2.5 text-indigo-600 hover:text-indigo-800 font-medium transition-colors flex items-center gap-2"
                >
                  <svg
                    className="w-4 h-4"
                    fill="none"
                    stroke="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M10 19l-7-7m0 0l7-7m-7 7h18"
                    />
                  </svg>
                  Adjust Views
                </button>
                <button
                  onClick={onClose}
                  className="px-6 py-2.5 bg-gradient-to-r from-indigo-600 to-purple-600 hover:from-indigo-700 hover:to-purple-700 text-white font-semibold rounded-xl shadow-lg shadow-indigo-500/30 transition-all"
                >
                  Done
                </button>
              </>
            )}
          </div>
        </div>
      </div>
    </div>
  );
};

export default BlackLittermanOptimizer;

