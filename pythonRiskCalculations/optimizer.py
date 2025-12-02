"""
Portfolio optimizer for Black-Litterman model

Finds optimal portfolio weights given expected returns and covariance matrix.
Maximizes Sharpe ratio with no short selling.
"""

import numpy as np
from scipy.optimize import minimize
from typing import List


def optimize_portfolio(
        expected_returns: np.ndarray,
        cov_matrix: np.ndarray,
        tickers: List[str], 
        risk_free_rate: float = 0.00008):  # Daily rate: ~2% annual / 252
    """
    Optimize portfolio weights by maximizing Sharpe ratio.
    
    Constraints:
    - Weights sum to 1 (fully invested)
    - No short selling (weights >= 0)
    
    Returns: Optimal portfolio weights
    """
    n_assets = len(expected_returns)

    expected_returns = np.asarray(expected_returns).flatten()
    cov_matrix = np.asarray(cov_matrix)

    # Initial guess: equal weights
    x0 = np.ones(n_assets) / n_assets

    # Constraint: weights sum to 1
    constraints = {'type': 'eq', 'fun': lambda x: np.sum(x) - 1}

    # Bounds: 0 to 1 for each weight (no short selling, no max limit)
    bounds = tuple((0, 1) for _ in range(n_assets))

    # Maximize Sharpe by minimizing negative Sharpe
    def negative_sharpe(weights):
        portfolio_return = weights @ expected_returns
        portfolio_vol = np.sqrt(weights @ cov_matrix @ weights)
        if portfolio_vol == 0: 
            return 1e10
        return -(portfolio_return - risk_free_rate) / portfolio_vol

    result = minimize(
        negative_sharpe,
        x0,
        method='SLSQP',
        bounds=bounds,
        constraints=constraints
    )

    optimal_weights = result.x
    optimal_weights = optimal_weights / optimal_weights.sum()

    print(f"Portfolio optimized (max Sharpe)")
    print(f"  Non-zero positions: {np.sum(optimal_weights > 0.01)}/{n_assets}")

    return optimal_weights


# Testing
if __name__ == "__main__":
    tickers = ['AAPL', 'MSFT', 'GOOGL', 'META', 'AMZN']
    
    expected_returns = np.array([0.0015, 0.0012, 0.0010, 0.0018, 0.0013])
    cov_matrix = np.array([
        [0.0002, 0.0001, 0.0001, 0.0001, 0.0001],
        [0.0001, 0.0003, 0.0001, 0.0002, 0.0001],
        [0.0001, 0.0001, 0.0004, 0.0002, 0.0002],
        [0.0001, 0.0002, 0.0002, 0.0006, 0.0003],
        [0.0001, 0.0001, 0.0002, 0.0003, 0.0004]
    ])
    
    weights = optimize_portfolio(expected_returns, cov_matrix, tickers)
    
    print("\nOptimal Weights:")
    for ticker, weight in zip(tickers, weights):
        print(f"  {ticker}: {weight:.2%}")
