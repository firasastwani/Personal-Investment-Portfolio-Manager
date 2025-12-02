from black_litterman import (
    calculate_covariance_matrix,
    calculate_market_wieghts,
    calculate_equilibrium_returns
)

import pandas as pd
import numpy as np

samplePortfolio = [
    'AAPL',
    'MSFT',
    'META',
    'ED',
    'EOG',
    'TAP',
    'GOOG'
]

market_weights = calculate_market_wieghts(samplePortfolio)


cov_matrix = calculate_covariance_matrix(samplePortfolio)


eq_ret = calculate_equilibrium_returns(cov_matrix, market_weights)

print(eq_ret)


