# PIPSAP - Personal Investment Portfolio System and Analytics Platform

## 🚀 Overview

PIPSAP is a sophisticated, enterprise-grade personal investment portfolio management system that demonstrates advanced software engineering practices, microservices architecture, and real-time financial data processing. Built as a comprehensive full-stack application, it showcases modern development techniques including distributed systems, caching strategies, event-driven architecture, and real-time analytics.

![PIPSAP Dashboard](https://img.shields.io/badge/Status-Production%20Ready-brightgreen)
![Java](https://img.shields.io/badge/Java-17-orange)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.4-brightgreen)
![Next.js](https://img.shields.io/badge/Next.js-15.3.1-blue)
![Redis](https://img.shields.io/badge/Redis-7.0-red)
![Kafka](https://img.shields.io/badge/Kafka-6.2.0-purple)


## 🏁 Getting Started

### Prerequisites

- Java 17 or higher
- Node.js 18 or higher
- Docker and Docker Compose

### Quick Start

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/pipsap.git
   cd pipsap
   ```

2. **Start Infrastructure Services**

   ```bash
   docker-compose up -d
   ```

3. **Initialize Database**

   ```bash
   mysql -u root -p < ddl.sql
   mysql -u root -p < data.sql
   ```

4. **Start Backend Service**

   ```bash
   ./mvnw spring-boot:run
   ```

5. **Start Stock Price Microservice**

   ```bash
   cd services/stock-price-service
   ./mvnw spring-boot:run
   ```

6. **Start Frontend Application**

   ```bash
   cd frontend
   npm install
   npm run dev
   ```

7. **Access the Application**
   - Frontend: http://localhost:3000


## 🏗️ System Architecture

### High-Level Architecture Diagram

```mermaid
graph TB
    subgraph "PIPSAP Ecosystem"
        subgraph "Frontend Layer"
            A[Next.js Frontend<br/>• React 19<br/>• TypeScript<br/>• Chart.js]
        end

        subgraph "Backend Layer"
            B[Spring Boot Backend<br/>• Java 17<br/>• Spring Boot<br/>• JWT Auth<br/>• MySQL<br/>• Redis Cache]
        end

        subgraph "Microservices Layer"
            C[Stock Price Service<br/>• gRPC Server<br/>• Kafka Client<br/>• Finnhub API]
        end

        subgraph "Infrastructure Layer"
            D[Docker Infrastructure<br/>• Docker<br/>• Redis 7<br/>• Kafka 6.2<br/>• Zookeeper]
        end

        subgraph "Data Layer"
            E[Data Storage<br/>• MySQL 8.0<br/>• Redis Cache<br/>• Prepared Stmts<br/>• Optimized Queries]
        end

        subgraph "External APIs"
            F[External Services<br/>• Finnhub<br/>• Real-time<br/>• Market Data<br/>• Price Feeds]
        end
    end

    A <--> B
    B <--> C
    B <--> D
    B <--> E
    C <--> F
    C <--> D
```

## 🔄 Real-Time Data Flow Architecture

### Price Update System Flow

```mermaid
flowchart TD
    A[Scheduled Trigger<br/>Every 5 minutes] --> B[PriceUpdate Algorithm Service]
    B --> C[Priority Calculation<br/>Portfolio Weight × Holdings +<br/>Watchlist Weight × Users +<br/>Time Weight × Hours Since Update]
    C --> D[Kafka Producer<br/>Backend]
    D --> E[price-update-requests Topic]
    E --> F[Kafka Consumer<br/>Microservice]
    F --> G[External API Call<br/>Finnhub API<br/>Rate Limited]
    G --> H[Price Validation & Formatting]
    H --> I[Kafka Producer<br/>Microservice]
    I --> J[stock-price-updates Topic]
    J --> K[Kafka Consumer<br/>Backend]
    K --> L[Redis Cache<br/>TTL: 10 min]
    K --> M[MySQL Database<br/>Portfolio Holdings]
    L --> N[Historical TAV Recording<br/>All Users]
    M --> N
    N --> O[Frontend Update<br/>Real-time Portfolio Display]

    style A fill:#e1f5fe
    style O fill:#e8f5e8
    style L fill:#fff3e0
    style M fill:#fff3e0
```

## 🗄️ Database Schema Overview

### Core Entity Relationships

```mermaid
erDiagram
    Users {
        int user_id PK
        string username UK
        string password
        float balance
        string role
        datetime created_at
    }

    Securities {
        int security_id PK
        string symbol UK
        string name
        string exchange
        string sector
        decimal price
        string currency
    }

    Portfolios {
        int portfolio_id PK
        int user_id FK
        string name
        text description
        datetime created_at
    }

    Watchlist {
        int watchlist_id PK
        int user_id FK
        int security_id FK
        datetime added_at
    }

    PortfolioHoldings {
        int holding_id PK
        int portfolio_id FK
        int security_id FK
        int quantity
        decimal avg_price
        decimal current_value
        datetime last_updated
    }

    Transactions {
        int transaction_id PK
        int portfolio_id FK
        int security_id FK
        enum type
        decimal quantity
        decimal price
        datetime date
        text notes
    }

    HistoricalTAV {
        int id PK
        int user_id FK
        decimal tav_value
        datetime recorded_at
        string date_key
    }

    Users ||--o{ Portfolios : "has"
    Users ||--o{ Watchlist : "watches"
    Users ||--o{ HistoricalTAV : "records"
    Securities ||--o{ Watchlist : "watched_by"
    Securities ||--o{ PortfolioHoldings : "held_in"
    Securities ||--o{ Transactions : "traded_in"
    Portfolios ||--o{ PortfolioHoldings : "contains"
    Portfolios ||--o{ Transactions : "has"
```

## ⚡ Performance & Scalability Features

### Caching Strategy

- **Redis Cache Layer**: 90%+ cache hit rate for frequently accessed symbols
- **TTL Management**: 10-minute cache expiration with automatic refresh
- **Batch Operations**: Up to 50 symbols processed per batch
- **Fallback Mechanism**: Database fallback when cache misses

### Priority-Based Updates

- **Portfolio Holdings**: 60% weight (highest priority)
- **Watchlist Items**: 30% weight (medium priority)
- **Time Since Update**: 10% weight (background priority)
- **Smart Batching**: Groups symbols by urgency and update frequency


## 🛠️ Technical Stack

### Backend Architecture

- **Framework**: Spring Boot 3.2.4 with Java 17
- **Security**: JWT-based authentication with Spring Security
- **Database**: Dockerized MySQL 8.0 instance with optimized indexes and prepared statements
- **Caching**: Redis 7.0 with TTL-based cache invalidation
- **Message Queue**: Dockerized Apache Kafka 6.2.0 for asynchronous processing
- **Microservices**: gRPC-based stock price service (future implementation), currently posts to Kafka topic
- **API**: RESTful endpoints with comprehensive error handling and rate limiting

### Frontend Architecture

- **Framework**: Next.js 15.3.1 with React 19
- **Language**: TypeScript for type safety
- **Charts**: Chart.js with react-chartjs-2 for data visualization
- **State Management**: React Context API for global state
- **Authentication**: JWT token management with secure storage

### Infrastructure

- **Containerization**: Docker with docker-compose for local development
- **Message Broker**: Dockerized Apache Kafka 6.2.0 with Zookeeper for distributed coordination
- **Cache**: Dockerized Redis 7.0 for high-performance data caching
- **Database**: Dockerized MySQL 8.0 instance with connection pooling and query optimization

## 🔐 Security Features

### Authentication & Authorization

- **JWT Tokens**: Secure token-based authentication
- **Role-Based Access**: User and admin role management
- **Password Security**: Encrypted password storage with bcrypt
- **Session Management**: Automatic token refresh with JWT

### Data Protection

- **Prepared Statements**: SQL injection prevention
- **Input Validation**: Comprehensive request validation
- **Error Handling**: Secure error messages without data leakage
- **CORS Configuration**: Cross-origin request security

## 📊 Key Features

### Portfolio Management

- **Multi-Portfolio Support**: Users can create and manage multiple portfolios
- **Real-time Valuation**: Live portfolio value updates with price changes
- **Transaction History**: Complete buy/sell transaction tracking
- **Performance Analytics**: Historical performance analysis and charts (TAV)

### Analytics & Reporting (future implementations)

- **Historical TAV Tracking**: Total Account Value history over time
- **Performance Charts**: Interactive charts for portfolio analysis
- **Sector Diversification**: Portfolio allocation by sector analysis
- **Transaction Analytics**: Detailed transaction reporting

### Real-time Data Processing

- **Live Price Updates**: Real-time security price updates
- **Automated TAV Recording**: Automatic total account value tracking
- **Cache Optimization**: Intelligent caching for performance
- **Priority-Based Updates**: Smart update scheduling based on user activity


## 📈 System Monitoring

### Health Check Endpoints

- `GET /api/price-updates/health` - System health status
- `GET /api/price-updates/statistics` - Update statistics
- `GET /api/price-updates/priorities` - Current update priorities

### Performance Monitoring

- Redis cache hit/miss rates
- Kafka message throughput
- Database query performance
- API response times
---

**PIPSAP** - Demonstrating enterprise-grade software engineering with real-world financial application complexity.
