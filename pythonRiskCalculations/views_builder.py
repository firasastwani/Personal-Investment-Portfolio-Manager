"""
Investor views builder to pass to Black-Litterman Model

Converts investor views into P, Q, Ω matrices


TODO: add relative views (ticker1 vs ticker2)
"""

import numpy as np
from typing import List, Dict, Any, Tuple




"""
Build P, Q, Ω matricies from investor views

Views format will be passed like: 
{
    'ticker': 'AAPL'
    'return': 0.15,
    'confidence': 0.8
}

Returns: (P, Q, omega)
"""
def build_views_matrix(
        views: List[Dict[str, Any]],
        tickers: List[str]):
    
    if not views: 
        raise ValueError("views are not present")
    
    # make sure views are in a valid format 
    for i, view in enumerate(views):
        if 'ticker' not in view or 'return' not in view or 'confidence' not in view:
            raise ValueError(f"View {i+1}: must have 'ticker', 'return', and 'confidence'")
        
        if view['ticker'] not in tickers:
            raise ValueError(f"View {i+1}: ticker '{view['ticker']}' not in portfolio")
        
        if not 0 < view['confidence'] <= 1:
            raise ValueError(f"View {i+1}: confidence must be between 0 and 1")
        
    # build matricies
    n_views = len(views)
    n_assets = len(tickers)

    # P matrix: identity matrix for each view
    P = np.zeros((n_views, n_assets))
    for i, view in enumerate(views):
        asset_idx = tickers.index(view['ticker'])
        P[i, asset_idx] = 1.0
    
    # Q vector: expected returns
    Q = np.array([view['return'] for view in views])
    
    # Omega matrix: uncertainty (diagonal)
    omega = np.zeros((n_views, n_views))
    for i, view in enumerate(views):
        confidence = view['confidence']
        omega[i, i] = (1 - confidence) / confidence
    
    return P, Q, omega
 

# Testing
if __name__ == "__main__":
    tickers = ['AAPL', 'MSFT', 'GOOGL', 'META', 'AMZN']
    
    views = [
        {'ticker': 'AAPL', 'return': 0.15, 'confidence': 0.8},
        {'ticker': 'MSFT', 'return': 0.12, 'confidence': 0.7},
        {'ticker': 'META', 'return': 0.20, 'confidence': 0.6}
    ]
    
    P, Q, omega = build_views_matrix(views, tickers)
    
    print("P Matrix:")
    print(P)
    print("\nQ Vector:")
    print(Q)
    print("\nΩ Diagonal:")
    print(np.diag(omega))
