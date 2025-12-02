"""
Historical Stock Data Retrieval for Covariance Matrix Calculation

- Load historical stock price data from CSV files
- Prepare returns data for covariance matrix calculation
- Quality checks and data cleaning
"""


import pandas as pd
import numpy as np
from pathlib import Path
from typing import List, Optional, Dict, Any, Tuple


start_date = "2023-01-01"
min_periods = 252


"""
Get historical returns data formatted for covariance matrix calculation

This is the primary function for preparing data for Black-Litterman optimization.
Loads historical prices, calculates returns, and ensures data quality.

params:
    - tickers: List of stock ticker symbols in the portfolio
    - data_dir: Directory containing CSV files (default: 'data')
    - start_date: Start date in 'YYYY-MM-DD' format
    - end_date: End date in 'YYYY-MM-DD' format
    - min_periods: Minimum number of return observations required (default: 252)
    - price_column: Which price column to use (default: 'Adj Close')

Returns: Returns matrix with dates as index and tickers as columns
"""
def get_returns_for_covariance(
    tickers: List[str],
    data_dir: str = "data",
    start_date: Optional[str] = None,
    end_date: Optional[str] = None,
    min_periods: int = 252,
    price_column: str = "Adj Close"):
    
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
            f"Got {len(returns)} periods, need at least {min_periods}."
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


"""
Load price data for multiple tickers and align by date

Returns: DataFrame with dates as index and tickers as columns
"""
def _load_aligned_prices(
    tickers: List[str],
    data_dir: str,
    start_date: Optional[str],
    end_date: Optional[str],
    price_column: str):

    price_data = {}
    failed_tickers = []
    data_path = Path(__file__).parent / data_dir
    
    for ticker in tickers:
        file_path = data_path / f"{ticker}.csv"
        
        if not file_path.exists():
            failed_tickers.append(ticker)
            print(f"Warning: No data file found for {ticker}")
            continue
        
        try:
            df = pd.read_csv(file_path, parse_dates=['Date'])
            
            # Filter by date range
            if start_date:
                df = df[df['Date'] >= pd.to_datetime(start_date)]
            if end_date:
                df = df[df['Date'] <= pd.to_datetime(end_date)]
            
            if df.empty:
                failed_tickers.append(ticker)
                print(f"Warning: No data in date range for {ticker}")
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
        print(f"Loaded {len(price_data)}/{len(tickers)} tickers")
        print(f"Failed: {', '.join(failed_tickers)}")
    
    return prices_df


"""
Calculate log returns from price data

Returns: DataFrame with log returns (first row removed due to differencing)
"""
def _calculate_log_returns(prices: pd.DataFrame) -> pd.DataFrame:

    # Log returns: ln(P_t / P_{t-1})
    shifted = prices.shift(1)
    log_returns = np.log(prices / shifted)
    
    if isinstance(log_returns, pd.DataFrame):
        return log_returns.dropna()
    
    return pd.DataFrame(log_returns).dropna()


"""
Clean returns data by removing assets with excessive missing data

Returns: DataFrame with clean returns (problematic assets removed)
"""
def _clean_returns_data(returns: pd.DataFrame) -> pd.DataFrame:

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
        print(f"Dropped {dropped_rows} rows with missing data")
    
    if returns.empty:
        raise ValueError("No valid return data available after cleaning")
    
    return returns


"""
Print a summary of the prepared returns data
"""
def _print_data_summary(returns: pd.DataFrame) -> None:

    n_periods, n_assets = returns.shape
    date_start = returns.index.min()
    date_end = returns.index.max()
    asset_list = ', '.join(returns.columns[:5])
    more = '...' if n_assets > 5 else ''
    
    print(f"\n{'='*60}")
    print(f"Returns Data Prepared for Covariance Calculation")
    print(f"{'='*60}")
    print(f"  Periods:    {n_periods} trading days")
    print(f"  Assets:     {n_assets} stocks")
    print(f"  Date Range: {date_start.strftime('%Y-%m-%d')} to {date_end.strftime('%Y-%m-%d')}")
    print(f"  Tickers:    {asset_list}{more}")
    print(f"{'='*60}\n")


# Testing
if __name__ == "__main__":
    print("Testing Historical Data Retrieval for Covariance Matrix\n")
    
    portfolio = ['AAPL', 'MSFT', 'GOOGL', 'META', 'AMZN']
    
    try:
        returns = get_returns_for_covariance(
            tickers=portfolio,
            start_date="2023-01-01",
            min_periods=100
        )
        
        print(f"Successfully loaded returns: {returns.shape}")
        print(f" Mean daily returns:\n{returns.mean()}\n")
        
        # Calculate covariance and correlation matrices
        print("\nCalculating covariance matrix...")
        cov_matrix = returns.cov()
        print("Covariance Matrix:")
        print(cov_matrix)
        
        print("\nCorrelation Matrix:")
        corr_matrix = returns.corr()
        print(corr_matrix)
        
    except Exception as e:
        print(f"Error: {e}")
    
    print("\n" + "="*60)
    print("All tests completed ✓")
    print("="*60)
