"""
Historical Stock Data Retrieval for Covariance Matrix Calculation

This module provides functions to load historical stock price data from CSV files
and prepare returns data for covariance matrix calculation in Black-Litterman optimization.

"""

import pandas as pd
import numpy as np
from pathlib import Path
from typing import List, Optional, Dict, Any, Tuple
from datetime import datetime


def get_returns_for_covariance(
    tickers: List[str],
    data_dir: str = "data",
    start_date: Optional[str] = None,
    end_date: Optional[str] = None,
    min_periods: int = 252,
    price_column: str = "Adj Close"
) -> pd.DataFrame:
    """
    Get historical returns data formatted for covariance matrix calculation.
    
    This is the primary function for preparing data for Black-Litterman optimization.
    It loads historical prices, calculates returns, and ensures data quality.
    
    Parameters:
    -----------
    tickers : List[str]
        List of stock ticker symbols in the portfolio
    data_dir : str
        Directory containing CSV files (default: 'data')
    start_date : str, optional
        Start date in 'YYYY-MM-DD' format
    end_date : str, optional
        End date in 'YYYY-MM-DD' format
    min_periods : int
        Minimum number of return observations required (default: 252 = ~1 year)
    price_column : str
        Which price column to use (default: 'Adj Close')
    
    Returns:
    --------
    pd.DataFrame
        Returns matrix with dates as index and tickers as columns
        Shape: (n_periods, n_assets)
        Ready for: cov_matrix = returns.cov()
    
    Raises:
    -------
    ValueError: If insufficient data available or no valid tickers
    FileNotFoundError: If data files don't exist for tickers
    
    Example:
    --------
    >>> returns = get_returns_for_covariance(['AAPL', 'MSFT', 'GOOGL'])
    >>> cov_matrix = returns.cov()
    """
    # Load and align price data
    prices = _load_aligned_prices(
        tickers=tickers,
        data_dir=data_dir,
        start_date=start_date,
        end_date=end_date,
        price_column=price_column
    )
    
    # Calculate log returns
    returns = _calculate_log_returns(prices)
    
    # Validate minimum data requirement
    if len(returns) < min_periods:
        raise ValueError(
            f"Insufficient data for covariance calculation. "
            f"Got {len(returns)} periods, need at least {min_periods}. "
            f"Consider using a longer date range or reducing min_periods."
        )
    
    # Quality checks and cleanup
    returns = _clean_returns_data(returns)
    
    # Final validation
    if len(returns) < min_periods:
        raise ValueError(
            f"After data cleaning, only {len(returns)} periods remain. "
            f"Need at least {min_periods}."
        )
    
    # Print summary
    _print_data_summary(returns)
    
    return returns



# ============================================================================
# Private Helper Functions
# ============================================================================

def _load_aligned_prices(
    tickers: List[str],
    data_dir: str,
    start_date: Optional[str],
    end_date: Optional[str],
    price_column: str
) -> pd.DataFrame:
    """
    Load price data for multiple tickers and align by date.
    
    Returns:
    --------
    pd.DataFrame with dates as index and tickers as columns
    """
    price_data = {}
    failed_tickers = []
    data_path = Path(__file__).parent / data_dir
    
    for ticker in tickers:
        file_path = data_path / f"{ticker}.csv"
        
        if not file_path.exists():
            failed_tickers.append(ticker)
            print(f"⚠️  Warning: No data file found for {ticker}")
            continue
        
        try:
            # Read CSV
            df = pd.read_csv(file_path, parse_dates=['Date'])
            
            # Filter by date range
            if start_date:
                df = df[df['Date'] >= pd.to_datetime(start_date)]
            if end_date:
                df = df[df['Date'] <= pd.to_datetime(end_date)]
            
            if df.empty:
                failed_tickers.append(ticker)
                print(f"⚠️  Warning: No data in date range for {ticker}")
                continue
            
            # Extract price column
            df = df.sort_values('Date')
            price_data[ticker] = df.set_index('Date')[price_column]
            
        except Exception as e:
            failed_tickers.append(ticker)
            print(f"Warning: Error loading {ticker}: {e}")
    
    if not price_data:
        raise ValueError("No valid stock data could be loaded")
    
    # Combine into single DataFrame
    prices_df = pd.DataFrame(price_data)
    
    # Handle missing values (forward fill then backward fill)
    prices_df = prices_df.ffill().bfill()
    
    if failed_tickers:
        print(f"✓ Loaded {len(price_data)}/{len(tickers)} tickers")
        print(f"  Failed: {', '.join(failed_tickers)}")
    
    return prices_df


def _calculate_log_returns(prices: pd.DataFrame) -> pd.DataFrame:
    """
    Calculate log returns from price data.
    
    Returns:
    --------
    pd.DataFrame with log returns (first row removed due to differencing)
    """
    # Log returns: ln(P_t / P_{t-1})
    shifted = prices.shift(1)
    log_returns = np.log(prices / shifted)
    
    # Convert to DataFrame explicitly if needed and drop NaN
    if isinstance(log_returns, pd.DataFrame):
        return log_returns.dropna()
    
    # Should not reach here, but handle gracefully
    return pd.DataFrame(log_returns).dropna()


def _clean_returns_data(returns: pd.DataFrame) -> pd.DataFrame:
    """
    Clean returns data by removing assets with excessive missing data.
    
    Returns:
    --------
    pd.DataFrame with clean returns (problematic assets removed)
    """
    max_nan_pct = 0.05  # Allow up to 5% missing values
    
    # Check for missing data in each column
    nan_counts = returns.isna().sum()
    nan_pct = nan_counts / len(returns)
    bad_series = nan_pct[nan_pct > max_nan_pct]
    bad_tickers = bad_series.index.tolist() if len(bad_series) > 0 else []
    
    if bad_tickers:
        print(f"Removing tickers with >{max_nan_pct*100}% missing data: {bad_tickers}")
        returns = returns.drop(columns=bad_tickers)
    
    # Drop any remaining rows with NaN
    initial_rows = len(returns)
    returns = returns.dropna()
    dropped_rows = initial_rows - len(returns)
    
    if dropped_rows > 0:
        print(f"⚠️  Dropped {dropped_rows} rows with missing data")
    
    if returns.empty:
        raise ValueError("No valid return data available after cleaning")
    
    return returns


def _print_data_summary(returns: pd.DataFrame) -> None:
    """Print a summary of the prepared returns data."""
    n_periods, n_assets = returns.shape
    date_start = returns.index.min()
    date_end = returns.index.max()
    asset_list = ', '.join(returns.columns[:5])
    more = '...' if n_assets > 5 else ''
    
    print(f"\n{'='*60}")
    print(f"✓ Returns Data Prepared for Covariance Calculation")
    print(f"{'='*60}")
    print(f"  Periods:    {n_periods} trading days")
    print(f"  Assets:     {n_assets} stocks")
    print(f"  Date Range: {date_start.strftime('%Y-%m-%d')} to {date_end.strftime('%Y-%m-%d')}")
    print(f"  Tickers:    {asset_list}{more}")
    print(f"{'='*60}\n")


# ============================================================================
# Testing and Examples
# ============================================================================

if __name__ == "__main__":
    print("Testing Historical Data Retrieval for Covariance Matrix\n")
    
    # Test 1: Load returns for a portfolio
    print("Test 1: Loading portfolio returns...")
    print("-" * 60)
    portfolio = ['AAPL', 'MSFT', 'GOOGL', 'META', 'AMZN']
    
    try:
        returns = get_returns_for_covariance(
            tickers=portfolio,
            start_date="2023-01-01",
            min_periods=100  # Lower for testing
        )
        
        print(f"✓ Successfully loaded returns: {returns.shape}")
        print(f"  Mean daily returns:\n{returns.mean()}\n")
        
    except Exception as e:
        print(f" Error: {e}\n")
    
    # Test 2: Calculate covariance and correlation matrices
    print("\nTest 2: Calculating covariance matrix...")
    print("-" * 60)
    
    try:
        # Covariance matrix
        cov_matrix = returns.cov()
        print("Covariance Matrix:")
        print(cov_matrix)
        
        # Correlation matrix  
        print("\nCorrelation Matrix:")
        corr_matrix = returns.corr()
        print(corr_matrix)
        
    except Exception as e:
        print(f"Error: {e}")
    
    
    print("\n" + "="*60)
    print("All tests completed ✓")
    print("="*60)
