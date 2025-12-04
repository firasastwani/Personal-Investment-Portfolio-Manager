<!-- b8a45a9f-366c-45f4-8852-8ef2d93da6d8 a8abaeb9-f2e2-4fb5-8eec-07cbc48d69a0 -->
# Black-Litterman Portfolio Optimization - MVP Implementation Plan

## Timeline: 1-2 Weeks

## Architecture Decision: Python Service Extension

**Rationale**: Your existing `pythonRiskCalculations/main.py` FastAPI service already handles risk metrics. Extending it with Black-Litterman keeps all quantitative finance logic in one place, leverages NumPy/SciPy for matrix operations, and avoids Java numerical computation complexity.**

## Implementation Strategy

### Phase 1: Data Infrastructure (Days 1-2)

#### 1.1 Historical Returns Service

- **Location**: `pythonRiskCalculations/historical_data.py`
- **Function**: Fetch historical price data from Finnhub API (you already have this integration)
- **Storage**: In-memory cache (Redis optional, not required for MVP)
- **Returns Calculation**: Daily returns from price history (252 trading days minimum)

#### 1.2 Covariance Matrix Calculator

- **Location**: `pythonRiskCalculations/covariance.py`
- **Function**: Compute sample covariance matrix from historical returns
- **Method**: Standard sample covariance with shrinkage option (Ledoit-Wolf for stability)
- **Output**: N×N covariance matrix (Σ)

### Phase 2: Market Equilibrium Module (Days 2-3)

#### 2.1 Market Equilibrium Returns

- **Location**: `pythonRiskCalculations/market_equilibrium.py`
- **Inputs**: 
  - Market weights (w_mkt): Equal weights OR market cap from Finnhub if available
  - Risk aversion parameter (λ): Default 2.5-3.0 (configurable)
  - Covariance matrix (Σ)
- **Formula**: π = λ × Σ × w_mkt
- **Output**: Implied equilibrium returns vector (π)

**Note**: For MVP, use equal weights if market cap unavailable. This is mathematically valid and commonly used.

### Phase 3: Investor Views Module (Days 3-4)

#### 3.1 Views Data Model

- **Location**: `pythonRiskCalculations/models.py` (extend existing)
- **Structure**:
```python
class InvestorView(BaseModel):
    view_type: str  # "absolute" or "relative"
    symbols: List[str]  # For relative: [symbol1, symbol2]
    expected_return: float  # Absolute return or spread
    confidence: float  # 0-1 scale
```


#### 3.2 Views Matrix Builder

- **Location**: `pythonRiskCalculations/views_builder.py`
- **Functions**:
  - Build P matrix (picking matrix)
  - Build Q vector (expected returns from views)
  - Build Ω matrix (confidence/uncertainty diagonal)

### Phase 4: Black-Litterman Core Algorithm (Days 4-5)

#### 4.1 Bayesian Posterior Calculation

- **Location**: `pythonRiskCalculations/black_litterman.py`
- **Key Functions**:
  - `calculate_posterior_returns(π, P, Q, Σ, τ, Ω)`
  - Formula: μ_BL = [(τΣ)^(-1) + P'Ω^(-1)P]^(-1) × [(τΣ)^(-1)π + P'Ω^(-1)Q]
  - `calculate_posterior_covariance(Σ, P, Ω, τ)`
  - Formula: Σ_BL = Σ + [(τΣ)^(-1) + P'Ω^(-1)P]^(-1)

#### 4.2 Parameter Configuration

- **τ (tau)**: Default 0.05 (scaling factor for uncertainty)
- **Ω (omega)**: Diagonal matrix from user confidence levels
- **Validation**: Ensure matrix invertibility, handle edge cases

### Phase 5: Optimization Engine (Days 5-6)

#### 5.1 Markowitz Optimization

- **Location**: `pythonRiskCalculations/optimizer.py`
- **Function**: Quadratic programming solver using `scipy.optimize`
- **Constraints**: 
  - Weights sum to 1
  - No short selling (weights ≥ 0)
  - Optional: Sector/position limits
- **Objective**: Maximize Sharpe ratio or minimize variance for target return

#### 5.2 Black-Litterman Optimization

- **Same optimizer**, but uses μ_BL and Σ_BL instead of sample estimates
- **Output**: Optimal portfolio weights

### Phase 6: API Integration (Days 6-7)

#### 6.1 FastAPI Endpoints

- **Location**: `pythonRiskCalculations/main.py` (extend)
- **Endpoints**:
  - `POST /api/optimization/black-litterman`
    - Input: portfolio_id, views[], risk_aversion, tau
    - Output: optimal_weights, expected_return, volatility, sharpe_ratio
  - `POST /api/optimization/markowitz` (for comparison)
  - `GET /api/optimization/market-equilibrium/{portfolio_id}`

#### 6.2 Java Backend Integration

- **Location**: `src/main/java/com/pipsap/pipsap/service/PortfolioOptimizationService.java` (new)
- **Function**: HTTP client to Python service
- **Integration**: Call Python API from existing `PortfolioController` or new `OptimizationController`

### Phase 7: Frontend UI (Days 7-8)

#### 7.1 Views Input Component

- **Location**: `frontend/src/components/InvestorViewsInput.tsx`
- **Features**:
  - Add/remove views
  - View type selector (absolute/relative)
  - Confidence slider (0-100%)
  - Expected return input

#### 7.2 Optimization Results Display

- **Location**: `frontend/src/components/OptimizationResults.tsx`
- **Features**:
  - Side-by-side comparison: Current vs BL vs Markowitz
  - Weight allocation table
  - Risk-return metrics
  - Simple chart (weights bar chart)

#### 7.3 Integration Point

- **Location**: `frontend/src/app/portfolio/[id]/page.tsx`
- **Add**: "Optimize Portfolio" button/tab
- **Flow**: User inputs views → API call → Display results

### Phase 8: Testing & Polish (Days 8-10)

#### 8.1 Unit Tests

- Test covariance calculation
- Test BL posterior formulas
- Test optimizer with known inputs

#### 8.2 Integration Tests

- End-to-end: Portfolio → Views → Optimization → Results

#### 8.3 Error Handling

- Invalid views (conflicting, impossible)
- Matrix singularity
- API failures
- Empty portfolios

## Technical Decisions

### Data Source

- **Historical Prices**: Fetch on-demand from Finnhub (you have API access)
- **Market Weights**: Equal weights for MVP (can enhance later with market cap)
- **Risk-Free Rate**: Use 10-year Treasury yield from Finnhub or hardcode 0.02-0.03

### Dependencies to Add

```python
# pythonRiskCalculations/requirements.txt
numpy>=1.24.0
pandas>=2.0.0
scipy>=1.10.0
scikit-learn>=1.3.0  # For Ledoit-Wolf shrinkage
```

### Database Changes

**None required for MVP** - All calculations are on-demand from current portfolio state

## What's Out of Scope (For Now)

- Historical price storage (fetch on-demand)
- Market cap-based weights (use equal weights)
- Advanced constraint optimization (sector limits, etc.)
- Backtesting framework
- Multiple optimization objectives
- Real-time rebalancing suggestions

## Success Criteria

1. User can input investor views for their portfolio
2. System calculates Black-Litterman optimal weights
3. Results show comparison: Current vs BL vs Markowitz
4. All calculations complete in <5 seconds for portfolios with <20 securities
5. UI is functional and clear

## File Structure

```
pythonRiskCalculations/
├── main.py (extend with optimization endpoints)
├── models.py (extend with InvestorView)
├── historical_data.py (new)
├── covariance.py (new)
├── market_equilibrium.py (new)
├── views_builder.py (new)
├── black_litterman.py (new)
├── optimizer.py (new)
└── requirements.txt (update)

src/main/java/com/pipsap/pipsap/
├── service/
│   └── PortfolioOptimizationService.java (new)
└── controller/
    └── OptimizationController.java (new)

frontend/src/
├── components/
│   ├── InvestorViewsInput.tsx (new)
│   └── OptimizationResults.tsx (new)
└── app/portfolio/[id]/
    └── page.tsx (extend with optimization tab)
```

## Implementation Difficulty Assessment

**Overall: Medium (6/10)**

- **Easy**: API endpoints, basic UI
- **Medium**: BL math implementation, matrix operations
- **Hard**: Edge case handling, numerical stability

**Time Estimate**: 40-60 hours total

- Backend (Python): 20-25 hours
- Backend (Java integration): 5-8 hours  
- Frontend: 10-15 hours
- Testing: 5-10 hours

This is achievable in 1-2 weeks with focused effort.

### To-dos

- [ ] Create historical_data.py to fetch price history from Finnhub and calculate daily returns
- [ ] Implement covariance.py with sample covariance and optional Ledoit-Wolf shrinkage
- [ ] Build market_equilibrium.py to calculate implied equilibrium returns (π = λΣw_mkt)
- [ ] Extend models.py with InvestorView Pydantic model for absolute/relative views
- [ ] Create views_builder.py to construct P, Q, and Ω matrices from user views
- [ ] Implement black_litterman.py with posterior return and covariance calculations
- [ ] Build optimizer.py using scipy.optimize for Markowitz and BL portfolio optimization
- [ ] Add FastAPI endpoints in main.py for /black-litterman and /markowitz optimization
- [ ] Create PortfolioOptimizationService.java to call Python API from Java backend
- [ ] Create OptimizationController.java with REST endpoints for frontend
- [ ] Build InvestorViewsInput.tsx component for user to input views and confidence
- [ ] Create OptimizationResults.tsx to show comparison of Current/BL/Markowitz portfolios
- [ ] Add optimization tab/button to portfolio/[id]/page.tsx and wire up API calls
- [ ] Add unit tests for BL calculations and integration tests for full flow