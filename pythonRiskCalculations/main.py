from black_litterman import (
    black_litterman_optimization
)

import pandas as pd
import numpy as np

samplePortfolio = [
    'AAPL',
    'MSFT',
    'GOOGL',
    'META',
    'AMZN'
]

tickers = ['AAPL', 'MSFT', 'GOOGL', 'META', 'AMZN']
    
views = [
    {"ticker": "AAPL",   "return": 0.99,   "confidence": 0.99},
    {"ticker": "MSFT",   "return": 0.12,  "confidence": 0.7},
    {"ticker": "GOOGL",  "return": 0.3,   "confidence": 0.8},
    {"ticker": "META",   "return": 0.20,  "confidence": 0.6},
    {"ticker": "AMZN",   "return": -0.20, "confidence": 0.99}
]


black_litterman_optimization(samplePortfolio, views)

