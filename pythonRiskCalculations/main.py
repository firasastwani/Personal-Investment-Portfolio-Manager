from turtle import st
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from typing import List, Dict, Any, Optional

from black_litterman import black_litterman_optimization

app = FastAPI(
    title = "Black-Littermen Portfolio Optimization API"
)

# Request/Response models

class ViewInput(BaseModel):
    ticker: str
    return_: float = Field(..., alias="return")
    confidence: float = Field(..., ge=0.01, le=0.99)

    class Config:
        populate_by_name = True


class OptimizationRequest(BaseModel):
    tickers: List[str]
    views: List[ViewInput]


class WeightResult(BaseModel):
    ticker: str
    weight: float
    percentage: str


class OptimizationResponse(BaseModel):
    success: bool
    optimal_weights: List[WeightResult]
    expected_return: float
    volatility: float
    sharpe_ratio: float
    expected_return_pct: str
    volatility_pct: str


"""
Run Black-Litterman portfolio optimization

Input: 
    - tickers: list of tickers in the investors portfolio
    - viwes: List of investors views (ticker, return, confidence)

Output:
    - optimal_weights: recommended portfolio allocation
    - expected_returns: annualized expected return
    - volatility: annualized volatility
    - sharpe_ratio: risk-adjusted return metric
"""
@app.post("/api/optimization/black-litterman", response_model = OptimizationResponse)
async def optimize_portfolio(request: OptimizationRequest):

    try: 

        # convert views to internal format
        views = [
            {
                "ticker": v.ticker, 
                "return": v.return_, 
                "confidence": v.confidence
            }
            for v in request.views
        ]

        # run the black-litterman optimization
        result = black_litterman_optimization(
            tickers = request.tickers,
            views = views
        )

        # format weights for response
        weights_list = [
            WeightResult(
                ticker=ticker,
                weight=round(weight, 4),
                percentage=f"{weight:.2%}"
            )
            for ticker, weight in result['optimal_weights'].items()
        ]
 
        return OptimizationResponse(
                    success=True,
                    optimal_weights=weights_list,
                    expected_return=round(result['expected_return'], 4),
                    volatility=round(result['volatility'], 4),
                    sharpe_ratio=round(result['sharpe_ratio'], 4),
                    expected_return_pct=f"{result['expected_return']:.2%}",
                    volatility_pct=f"{result['volatility']:.2%}"
                )
            
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Optimization failed: {str(e)}")



if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)


    """
    Example request: 
    curl -X POST "http://localhost:8000/api/optimization/black-litterman" \
        -H "Content-Type: application/json" \
        -d '{
            "tickers": ["AAPL", "MSFT", "GOOGL", "META", "AMZN"],
            "views": [
            {"ticker": "AAPL", "return": 0.15, "confidence": 0.8},
            {"ticker": "MSFT", "return": 0.12, "confidence": 0.7},
            {"ticker": "GOOGL", "return": 0.10, "confidence": 0.6}
            ]
        }'
    """