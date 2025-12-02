"""
Black-Litterman Model - Complete implementation

- Coveriance calculation (with optional shrinkage)
- Market equilibirum returns
- Bayesian posterior calculation
"""


import pandas as pd
import numpy as np

from typing import List, Optional, Dict, Any, Tuple
from sklearn.covariance import LedoitWolf

from get_stock_data import get_returns_for_covariance


start_date = "2023-01-01"
min_periods = 252


"""
Returns the covariance matrix for the provided portfolio using a defualt of 252 days 
"""
def calculate_covariance_matrix(
        tickers: List[str], 
        start_date = start_date,
        min_periods = min_periods,
        shrinkage: bool = False
        ):
    
    try:
        returns = get_returns_for_covariance(tickers, start_date= start_date, min_periods=min_periods)

    except Exception as e:
        print(f"Error loading returns: {e}")
        raise

    try:
        if shrinkage: 
            print("Using Ledoit-Wolf shrinkage")
            lw = LedoitWolf()
            cov_array = lw.fit(returns).covariance_
            cov_matrix = pd.DataFrame(
                cov_array,
                index = returns.columns,
                columns = returns.columns
            )
            
            print(f"Shrinkage intensity: {lw.shrinkage_:.4f}")
        else: 
            cov_matrix = returns.cov()
    except Exception as e:
        print(f"Erorr calculating covariance {e}")
        raise 

    return cov_matrix



"""
    Equal weightings for now, can adjust to Market cap seperation in the future
"""
def calculate_market_wieghts(tickers):

    n = len(tickers)
    return np.ones(n)/n


"""
Calculate implied equilibrium returns using reverse optimization

formula: π = λ × Σ × w_mkt

params:
    - cov_matrix: the covariance matrix
    - market_weights: the market weights
    - risk_aversion: the risk aversion param, higher = more risk averse
"""
def calculate_equilibrium_returns(
        cov_matrix: pd.DataFrame, 
        market_weights: np.ndarray,
        risk_aversion: float = 2.5):
    
    if isinstance(cov_matrix, pd.DataFrame):
        cov_array = cov_matrix.values
        tickers = cov_matrix.columns
    else: 
        cov_array = cov_matrix
        tickers = None

    # @ is the matrix multiplication operator in numpy
    equilibrium_returns = risk_aversion * cov_array @ market_weights

    if tickers is not None: 
        equilibrium_returns = pd.Series(equilibrium_returns, index=tickers)


    return equilibrium_returns




"""
Calculates Black-Litterman posterior expected returns and covariance

formulas: 
μ_BL = [(τΣ)^(-1) + P'Ω^(-1)P]^(-1) × [(τΣ)^(-1)π + P'Ω^(-1)Q]
Σ_BL = Σ + [(τΣ)^(-1) + P'Ω^(-1)P]^(-1)

params: 
    - pi: Implied equilibirum returns
    - cov_matrix: The covariance matrix (assets x assets)
    - P: Pick matrix linking views to assets (views x assets)
    - Q: View expected returns
    - omega: Uncertinty in views (viwes x views)
    - tau: Scaling factor for uncertainty in prior (defaults to 0.05)

Returns: 
Tuple[np.ndarray, np.ndarray]
    - mu_bl: Posterior expected returns
    - sigmma_bl: Posterior covariance matrix
"""
def calculate_black_litterman(
        pi: np.ndarray, 
        cov_matrix: np.ndarray,
        P: np.ndarray,
        Q: np.ndarray,
        omega: np.ndarray,
        tau: float = 0.05):
    

    # make sure all of the inputs are numpy arrays
    pi = np.asarray(pi).flatten()
    cov_matrix = np.asarray(cov_matrix)
    P = np.asanyarray(P)
    Q = np.asanyarray(Q)
    omega = np.asanyarray(omega)

    # Scale covariance by tau
    tau_sigma = tau * cov_matrix

    # Find inverse matricies
    tau_sigma_inv = np.linalg.inv(tau_sigma)
    omega_inv = np.linalg.inv(omega)

    # Calculate posterior expected returns
    # μ_BL = [(τΣ)^(-1) + P'Ω^(-1)P]^(-1) × [(τΣ)^(-1)π + P'Ω^(-1)Q]

    # Middle term: (τΣ)^(-1) + P'Ω^(-1)P

    middle = tau_sigma_inv + P.T @ omega_inv @ P
    middle_inv = np.linalg.inv(middle)

    # right hand side: (τΣ)^(-1)π + P'Ω^(-1)Q
    rhs = tau_sigma_inv @ pi + P.T @ omega_inv @ Q

    # Posterior mean
    mu_bl = middle_inv @ rhs

    # Calculate posterior covariance
    # Σ_BL = Σ + [(τΣ)^(-1) + P'Ω^(-1)P]^(-1)
    sigma_bl = cov_matrix + middle_inv

    print(f"Black-Litterman posterior calculated")
    print(f"  Mean return: {mu_bl.mean():.6f}")
    print(f"  Avg volatility: {np.sqrt(np.diag(sigma_bl)).mean():.6f}")

    return mu_bl, sigma_bl




"""
Complete end to end Black-Litterman portfolio optimization

params: Mentioned above

Returns: 
Dict[str, Any] complete optimization results
"""
def black_litterman_optimization(
    tickers: List[str],
    views: List[Dict[str, Any]],
    risk_aversion: float = 2.5,
    tau: float = 0.05,
    start_date: str = "2023-01-01",
    min_periods: int = 252,
    shrinkage: bool = False):

    # Step 1, covariance matrix
    print('\nCalculating covariance matrix...')
    cov_matrix = calculate_covariance_matrix(
        tickers=tickers,
        start_date=start_date,
        min_periods=min_periods,
        shrinkage=shrinkage
    )

    #Step 2, get market weights (currently just even)
    print('\nCalculating market weights')
    market_weights = calculate_market_wieghts(tickers)

    #Step 3, calculate equilibrium returns
    print('\n Calculating equilbirum returns...')
    pi = calculate_equilibrium_returns(cov_matrix, market_weights, risk_aversion)

    
    #Step 4, build views matricies (P, Q, Ω)
    print('\n Processing investor views')




