CREATE TABLE IF NOT EXISTS securities (
    security_id INT AUTO_INCREMENT PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(100),
    exchange VARCHAR(50),
    sector VARCHAR(100),
    static_price DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'USD'
);

-- Run this after creating database to boost securities performance
CREATE INDEX idx_symbol ON securities(symbol);
CREATE INDEX idx_name ON securities(name);


INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AAPL',
    'APPLE INC',
    'NASDAQ',
    'Information Technology',
    212.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MSFT',
    'MICROSOFT CORP',
    'NASDAQ',
    'Information Technology',
    395.26,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NVDA',
    'NVIDIA CORP',
    'NASDAQ',
    'Information Technology',
    108.92,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMZN',
    'AMAZON COM INC',
    'NASDAQ',
    'Consumer Discretionary',
    184.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'META',
    'META PLATFORMS INC CLASS A',
    'NASDAQ',
    'Communication',
    549.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BRKB',
    'BERKSHIRE HATHAWAY INC CLASS B',
    'New York Stock Exchange Inc.',
    'Financials',
    533.25,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GOOGL',
    'ALPHABET INC CLASS A',
    'NASDAQ',
    'Communication',
    158.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AVGO',
    'BROADCOM INC',
    'NASDAQ',
    'Information Technology',
    192.47,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TSLA',
    'TESLA INC',
    'NASDAQ',
    'Consumer Discretionary',
    282.16,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GOOG',
    'ALPHABET INC CLASS C',
    'NASDAQ',
    'Communication',
    160.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LLY',
    'ELI LILLY',
    'New York Stock Exchange Inc.',
    'Health Care',
    898.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JPM',
    'JPMORGAN CHASE & CO',
    'New York Stock Exchange Inc.',
    'Financials',
    244.62,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'V',
    'VISA INC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    345.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NFLX',
    'NETFLIX INC',
    'NASDAQ',
    'Communication',
    1131.72,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'XOM',
    'EXXON MOBIL CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    105.63,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MA',
    'MASTERCARD INC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    548.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COST',
    'COSTCO WHOLESALE CORP',
    'NASDAQ',
    'Consumer Staples',
    994.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WMT',
    'WALMART INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    97.25,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PG',
    'PROCTER & GAMBLE',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    162.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UNH',
    'UNITEDHEALTH GROUP INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    411.44,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JNJ',
    'JOHNSON & JOHNSON',
    'New York Stock Exchange Inc.',
    'Health Care',
    156.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HD',
    'HOME DEPOT INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    360.49,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ABBV',
    'ABBVIE INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    195.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KO',
    'COCA-COLA',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    72.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PM',
    'PHILIP MORRIS INTERNATIONAL INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    171.36,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BAC',
    'BANK OF AMERICA CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    39.88,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CRM',
    'SALESFORCE INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    268.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PLTR',
    'PALANTIR TECHNOLOGIES INC CLASS A',
    'NASDAQ',
    'Information Technology',
    118.44,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WFC',
    'WELLS FARGO',
    'New York Stock Exchange Inc.',
    'Financials',
    71.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CSCO',
    'CISCO SYSTEMS INC',
    'NASDAQ',
    'Information Technology',
    57.73,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MCD',
    'MCDONALDS CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    319.65,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ABT',
    'ABBOTT LABORATORIES',
    'New York Stock Exchange Inc.',
    'Health Care',
    130.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ORCL',
    'ORACLE CORP',
    'New York Stock Exchange Inc.',
    'Information Technology',
    140.72,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CVX',
    'CHEVRON CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    136.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IBM',
    'INTERNATIONAL BUSINESS MACHINES CO',
    'New York Stock Exchange Inc.',
    'Information Technology',
    241.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LIN',
    'LINDE PLC',
    'NASDAQ',
    'Materials',
    453.23,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GE',
    'GE AEROSPACE',
    'New York Stock Exchange Inc.',
    'Industrials',
    201.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MRK',
    'MERCK & CO INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    85.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'T',
    'AT&T INC',
    'New York Stock Exchange Inc.',
    'Communication',
    27.7,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NOW',
    'SERVICENOW INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    955.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ACN',
    'ACCENTURE PLC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    299.15,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PEP',
    'PEPSICO INC',
    'NASDAQ',
    'Consumer Staples',
    135.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VZ',
    'VERIZON COMMUNICATIONS INC',
    'New York Stock Exchange Inc.',
    'Communication',
    44.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ISRG',
    'INTUITIVE SURGICAL INC',
    'NASDAQ',
    'Health Care',
    515.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'INTU',
    'INTUIT INC',
    'NASDAQ',
    'Information Technology',
    627.47,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BKNG',
    'BOOKING HOLDINGS INC',
    'NASDAQ',
    'Consumer Discretionary',
    5099.28,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RTX',
    'RTX CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    126.13,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'QCOM',
    'QUALCOMM INC',
    'NASDAQ',
    'Information Technology',
    148.46,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DIS',
    'WALT DISNEY',
    'New York Stock Exchange Inc.',
    'Communication',
    90.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GS',
    'GOLDMAN SACHS GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    547.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UBER',
    'UBER TECHNOLOGIES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    81.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PGR',
    'PROGRESSIVE CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    281.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TMO',
    'THERMO FISHER SCIENTIFIC INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    429.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ADBE',
    'ADOBE INC',
    'NASDAQ',
    'Information Technology',
    374.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMD',
    'ADVANCED MICRO DEVICES INC',
    'NASDAQ',
    'Information Technology',
    97.35,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SPGI',
    'S&P GLOBAL INC',
    'New York Stock Exchange Inc.',
    'Financials',
    500.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMGN',
    'AMGEN INC',
    'NASDAQ',
    'Health Care',
    290.92,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BSX',
    'BOSTON SCIENTIFIC CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    102.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CAT',
    'CATERPILLAR INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    309.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AXP',
    'AMERICAN EXPRESS',
    'New York Stock Exchange Inc.',
    'Financials',
    266.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TJX',
    'TJX INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    128.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TXN',
    'TEXAS INSTRUMENT INC',
    'NASDAQ',
    'Information Technology',
    160.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PFE',
    'PFIZER INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    24.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NEE',
    'NEXTERA ENERGY INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    66.88,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HON',
    'HONEYWELL INTERNATIONAL INC',
    'NASDAQ',
    'Industrials',
    210.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BA',
    'BOEING',
    'New York Stock Exchange Inc.',
    'Industrials',
    183.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SYK',
    'STRYKER CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    373.92,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BLK',
    'BLACKROCK INC',
    'New York Stock Exchange Inc.',
    'Financials',
    914.26,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SCHW',
    'CHARLES SCHWAB CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    81.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GILD',
    'GILEAD SCIENCES INC',
    'NASDAQ',
    'Health Care',
    106.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MS',
    'MORGAN STANLEY',
    'New York Stock Exchange Inc.',
    'Financials',
    115.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VRTX',
    'VERTEX PHARMACEUTICALS INC',
    'NASDAQ',
    'Health Care',
    509.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UNP',
    'UNION PACIFIC CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    215.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'C',
    'CITIGROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    68.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DHR',
    'DANAHER CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    199.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CMCSA',
    'COMCAST CORP CLASS A',
    'NASDAQ',
    'Communication',
    34.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LOW',
    'LOWES COMPANIES INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    223.56,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ADP',
    'AUTOMATIC DATA PROCESSING INC',
    'NASDAQ',
    'Industrials',
    300.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMAT',
    'APPLIED MATERIAL INC',
    'NASDAQ',
    'Information Technology',
    150.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PANW',
    'PALO ALTO NETWORKS INC',
    'NASDAQ',
    'Information Technology',
    186.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TMUS',
    'T MOBILE US INC',
    'NASDAQ',
    'Communication',
    246.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ETN',
    'EATON PLC',
    'New York Stock Exchange Inc.',
    'Industrials',
    294.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CB',
    'CHUBB LTD',
    'New York Stock Exchange Inc.',
    'Financials',
    286.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COP',
    'CONOCOPHILLIPS',
    'New York Stock Exchange Inc.',
    'Energy',
    89.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DE',
    'DEERE',
    'New York Stock Exchange Inc.',
    'Industrials',
    463.56,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MMC',
    'MARSH & MCLENNAN INC',
    'New York Stock Exchange Inc.',
    'Financials',
    225.47,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MDT',
    'MEDTRONIC PLC',
    'New York Stock Exchange Inc.',
    'Health Care',
    84.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMT',
    'AMERICAN TOWER REIT CORP',
    'New York Stock Exchange Inc.',
    'Real Estate',
    225.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FI',
    'FISERV INC',
    'New York Stock Exchange Inc.',
    'Financials',
    184.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BMY',
    'BRISTOL MYERS SQUIBB',
    'New York Stock Exchange Inc.',
    'Health Care',
    50.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GEV',
    'GE VERNOVA INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    370.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LMT',
    'LOCKHEED MARTIN CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    477.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SO',
    'SOUTHERN',
    'New York Stock Exchange Inc.',
    'Utilities',
    91.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MO',
    'ALTRIA GROUP INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    59.15,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CME',
    'CME GROUP INC CLASS A',
    'NASDAQ',
    'Financials',
    277.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CRWD',
    'CROWDSTRIKE HOLDINGS INC CLASS A',
    'NASDAQ',
    'Information Technology',
    428.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ELV',
    'ELEVANCE HEALTH INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    420.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ADI',
    'ANALOG DEVICES INC',
    'NASDAQ',
    'Information Technology',
    194.92,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ICE',
    'INTERCONTINENTAL EXCHANGE INC',
    'New York Stock Exchange Inc.',
    'Financials',
    167.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BX',
    'BLACKSTONE INC',
    'New York Stock Exchange Inc.',
    'Financials',
    131.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PLD',
    'PROLOGIS REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    102.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WELL',
    'WELLTOWER INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    152.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DUK',
    'DUKE ENERGY CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    122.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WM',
    'WASTE MANAGEMENT INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    233.36,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KLAC',
    'KLA CORP',
    'NASDAQ',
    'Information Technology',
    702.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LRCX',
    'LAM RESEARCH CORP',
    'NASDAQ',
    'Information Technology',
    71.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CI',
    'CIGNA',
    'New York Stock Exchange Inc.',
    'Health Care',
    340.04,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MDLZ',
    'MONDELEZ INTERNATIONAL INC CLASS A',
    'NASDAQ',
    'Consumer Staples',
    68.13,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SBUX',
    'STARBUCKS CORP',
    'NASDAQ',
    'Consumer Discretionary',
    80.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'APH',
    'AMPHENOL CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    76.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MCK',
    'MCKESSON CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    712.79,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SPOT',
    'SPOTIFY TECHNOLOGY SA',
    'New York Stock Exchange Inc.',
    'Communication',
    613.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MSTR',
    'MICROSTRATEGY INC CLASS A',
    'NASDAQ',
    'Information Technology',
    380.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'INTC',
    'INTEL CORPORATION CORP',
    'NASDAQ',
    'Information Technology',
    20.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TT',
    'TRANE TECHNOLOGIES PLC',
    'New York Stock Exchange Inc.',
    'Industrials',
    383.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ANET',
    'ARISTA NETWORKS INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    82.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MU',
    'MICRON TECHNOLOGY INC',
    'NASDAQ',
    'Information Technology',
    76.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CVS',
    'CVS HEALTH CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    66.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EQIX',
    'EQUINIX REIT INC',
    'NASDAQ',
    'Real Estate',
    860.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SHW',
    'SHERWIN WILLIAMS',
    'New York Stock Exchange Inc.',
    'Materials',
    352.92,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ORLY',
    'OREILLY AUTOMOTIVE INC',
    'NASDAQ',
    'Consumer Discretionary',
    1415.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CDNS',
    'CADENCE DESIGN SYSTEMS INC',
    'NASDAQ',
    'Information Technology',
    297.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AJG',
    'ARTHUR J GALLAGHER',
    'New York Stock Exchange Inc.',
    'Financials',
    320.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PH',
    'PARKER-HANNIFIN CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    605.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KKR',
    'KKR AND CO INC',
    'New York Stock Exchange Inc.',
    'Financials',
    114.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TDG',
    'TRANSDIGM GROUP INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    1413.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MMM',
    '3M',
    'New York Stock Exchange Inc.',
    'Industrials',
    138.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CL',
    'COLGATE-PALMOLIVE',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    92.19,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GD',
    'GENERAL DYNAMICS CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    272.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CTAS',
    'CINTAS CORP',
    'NASDAQ',
    'Industrials',
    211.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MSI',
    'MOTOROLA SOLUTIONS INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    440.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MCO',
    'MOODYS CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    453.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'APO',
    'APOLLO GLOBAL MANAGEMENT INC',
    'New York Stock Exchange Inc.',
    'Financials',
    136.48,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WMB',
    'WILLIAMS INC',
    'New York Stock Exchange Inc.',
    'Energy',
    58.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SNPS',
    'SYNOPSYS INC',
    'NASDAQ',
    'Information Technology',
    459.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'APP',
    'APPLOVIN CORP CLASS A',
    'NASDAQ',
    'Information Technology',
    269.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ZTS',
    'ZOETIS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Health Care',
    156.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CEG',
    'CONSTELLATION ENERGY CORP',
    'NASDAQ',
    'Utilities',
    223.44,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ITW',
    'ILLINOIS TOOL INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    239.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AON',
    'AON PLC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    354.79,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UPS',
    'UNITED PARCEL SERVICE INC CLASS B',
    'New York Stock Exchange Inc.',
    'Industrials',
    95.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CMG',
    'CHIPOTLE MEXICAN GRILL INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    50.52,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COF',
    'CAPITAL ONE FINANCIAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    180.26,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DASH',
    'DOORDASH INC CLASS A',
    'NASDAQ',
    'Consumer Discretionary',
    192.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'XTSLA',
    'BLK CSH FND TREASURY SL AGENCY',
    '--',
    'Cash and/or Derivatives',
    1.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NKE',
    'NIKE INC CLASS B',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    56.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NOC',
    'NORTHROP GRUMMAN CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    486.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PYPL',
    'PAYPAL HOLDINGS INC',
    'NASDAQ',
    'Financials',
    65.84,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CRH',
    'CRH PUBLIC LIMITED PLC',
    'New York Stock Exchange Inc.',
    'Materials',
    95.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FTNT',
    'FORTINET INC',
    'NASDAQ',
    'Information Technology',
    103.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PNC',
    'PNC FINANCIAL SERVICES GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    160.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HCA',
    'HCA HEALTHCARE INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    345.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AZO',
    'AUTOZONE INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    3762.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'USB',
    'US BANCORP',
    'New York Stock Exchange Inc.',
    'Financials',
    40.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ECL',
    'ECOLAB INC',
    'New York Stock Exchange Inc.',
    'Materials',
    251.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'REGN',
    'REGENERON PHARMACEUTICALS INC',
    'NASDAQ',
    'Health Care',
    598.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EOG',
    'EOG RESOURCES INC',
    'New York Stock Exchange Inc.',
    'Energy',
    110.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'APD',
    'AIR PRODUCTS AND CHEMICALS INC',
    'New York Stock Exchange Inc.',
    'Materials',
    271.09,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NEM',
    'NEWMONT',
    'New York Stock Exchange Inc.',
    'Materials',
    52.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AFL',
    'AFLAC INC',
    'New York Stock Exchange Inc.',
    'Financials',
    108.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EMR',
    'EMERSON ELECTRIC',
    'New York Stock Exchange Inc.',
    'Industrials',
    105.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ROP',
    'ROPER TECHNOLOGIES INC',
    'NASDAQ',
    'Information Technology',
    560.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BDX',
    'BECTON DICKINSON',
    'New York Stock Exchange Inc.',
    'Health Care',
    207.09,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TRV',
    'TRAVELERS COMPANIES INC',
    'New York Stock Exchange Inc.',
    'Financials',
    264.13,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ADSK',
    'AUTODESK INC',
    'NASDAQ',
    'Information Technology',
    274.25,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BK',
    'BANK OF NEW YORK MELLON CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    80.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AEP',
    'AMERICAN ELECTRIC POWER INC',
    'NASDAQ',
    'Utilities',
    108.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HWM',
    'HOWMET AEROSPACE INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    138.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JCI',
    'JOHNSON CONTROLS INTERNATIONAL PLC',
    'New York Stock Exchange Inc.',
    'Industrials',
    83.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CSX',
    'CSX CORP',
    'NASDAQ',
    'Industrials',
    28.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HLT',
    'HILTON WORLDWIDE HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    225.48,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MAR',
    'MARRIOTT INTERNATIONAL INC CLASS A',
    'NASDAQ',
    'Consumer Discretionary',
    238.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DLR',
    'DIGITAL REALTY TRUST REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    160.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CPRT',
    'COPART INC',
    'NASDAQ',
    'Industrials',
    61.03,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CARR',
    'CARRIER GLOBAL CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    62.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ABNB',
    'AIRBNB INC CLASS A',
    'NASDAQ',
    'Consumer Discretionary',
    121.92,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALL',
    'ALLSTATE CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    198.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WDAY',
    'WORKDAY INC CLASS A',
    'NASDAQ',
    'Information Technology',
    245.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FCX',
    'FREEPORT MCMORAN INC',
    'New York Stock Exchange Inc.',
    'Materials',
    36.03,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LNG',
    'CHENIERE ENERGY INC',
    'New York Stock Exchange Inc.',
    'Energy',
    231.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RSG',
    'REPUBLIC SERVICES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    250.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TFC',
    'TRUIST FINANCIAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    38.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OKE',
    'ONEOK INC',
    'New York Stock Exchange Inc.',
    'Energy',
    82.16,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RCL',
    'ROYAL CARIBBEAN GROUP LTD',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    214.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KMI',
    'KINDER MORGAN INC',
    'New York Stock Exchange Inc.',
    'Energy',
    26.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SPG',
    'SIMON PROPERTY GROUP REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    157.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AIG',
    'AMERICAN INTERNATIONAL GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    81.52,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COR',
    'CENCORA INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    292.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'O',
    'REALTY INCOME REIT CORP',
    'New York Stock Exchange Inc.',
    'Real Estate',
    57.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NSC',
    'NORFOLK SOUTHERN CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    224.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MRVL',
    'MARVELL TECHNOLOGY INC',
    'NASDAQ',
    'Information Technology',
    58.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SNOW',
    'SNOWFLAKE INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    159.49,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KR',
    'KROGER',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    72.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PSA',
    'PUBLIC STORAGE REIT',
    'New York Stock Exchange Inc.',
    'Real Estate',
    300.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PAYX',
    'PAYCHEX INC',
    'NASDAQ',
    'Industrials',
    147.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FICO',
    'FAIR ISAAC CORP',
    'New York Stock Exchange Inc.',
    'Information Technology',
    1989.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SRE',
    'SEMPRA',
    'New York Stock Exchange Inc.',
    'Utilities',
    74.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SLB',
    'SCHLUMBERGER NV',
    'New York Stock Exchange Inc.',
    'Energy',
    33.25,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EXC',
    'EXELON CORP',
    'NASDAQ',
    'Utilities',
    46.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FDX',
    'FEDEX CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    210.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PCAR',
    'PACCAR INC',
    'NASDAQ',
    'Industrials',
    90.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FAST',
    'FASTENAL',
    'NASDAQ',
    'Industrials',
    80.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CCI',
    'CROWN CASTLE INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    105.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DFS',
    'DISCOVER FINANCIAL SERVICES',
    'New York Stock Exchange Inc.',
    'Financials',
    182.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'D',
    'DOMINION ENERGY INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    54.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMP',
    'AMERIPRISE FINANCE INC',
    'New York Stock Exchange Inc.',
    'Financials',
    471.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ROST',
    'ROSS STORES INC',
    'NASDAQ',
    'Consumer Discretionary',
    139.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KVUE',
    'KENVUE INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    23.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TGT',
    'TARGET CORP',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    96.7,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GM',
    'GENERAL MOTORS',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    45.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AXON',
    'AXON ENTERPRISE INC',
    'NASDAQ',
    'Industrials',
    613.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GWW',
    'WW GRAINGER INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    1024.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EW',
    'EDWARDS LIFESCIENCES CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    75.49,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MPC',
    'MARATHON PETROLEUM CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    137.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VST',
    'VISTRA CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    129.63,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KMB',
    'KIMBERLY CLARK CORP',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    131.78,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MET',
    'METLIFE INC',
    'New York Stock Exchange Inc.',
    'Financials',
    75.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PSX',
    'PHILLIPS',
    'New York Stock Exchange Inc.',
    'Energy',
    104.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FIS',
    'FIDELITY NATIONAL INFORMATION SERV',
    'New York Stock Exchange Inc.',
    'Financials',
    78.88,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CTVA',
    'CORTEVA INC',
    'New York Stock Exchange Inc.',
    'Materials',
    61.99,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MNST',
    'MONSTER BEVERAGE CORP',
    'NASDAQ',
    'Consumer Staples',
    60.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PWR',
    'QUANTA SERVICES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    292.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'YUM',
    'YUM BRANDS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    150.44,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VRSK',
    'VERISK ANALYTICS INC',
    'NASDAQ',
    'Industrials',
    296.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LHX',
    'L3HARRIS TECHNOLOGIES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    220.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MSCI',
    'MSCI INC',
    'New York Stock Exchange Inc.',
    'Financials',
    545.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KDP',
    'KEURIG DR PEPPER INC',
    'NASDAQ',
    'Consumer Staples',
    34.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'URI',
    'UNITED RENTALS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    631.45,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COIN',
    'COINBASE GLOBAL INC CLASS A',
    'NASDAQ',
    'Financials',
    202.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'XEL',
    'XCEL ENERGY INC',
    'NASDAQ',
    'Utilities',
    70.7,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TTWO',
    'TAKE TWO INTERACTIVE SOFTWARE INC',
    'NASDAQ',
    'Communication',
    233.32,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CMI',
    'CUMMINS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    293.84,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NU',
    'NU HOLDINGS LTD CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    12.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PEG',
    'PUBLIC SERVICE ENTERPRISE GROUP IN',
    'New York Stock Exchange Inc.',
    'Utilities',
    79.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AME',
    'AMETEK INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    169.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'F',
    'FORD MOTOR CO',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    10.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ED',
    'CONSOLIDATED EDISON INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    112.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OTIS',
    'OTIS WORLDWIDE CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    96.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EA',
    'ELECTRONIC ARTS INC',
    'NASDAQ',
    'Communication',
    145.09,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CBRE',
    'CBRE GROUP INC CLASS A',
    'New York Stock Exchange Inc.',
    'Real Estate',
    122.18,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TRGP',
    'TARGA RESOURCES CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    170.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TEAM',
    'ATLASSIAN CORP CLASS A',
    'NASDAQ',
    'Information Technology',
    228.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PRU',
    'PRUDENTIAL FINANCIAL INC',
    'New York Stock Exchange Inc.',
    'Financials',
    102.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NET',
    'CLOUDFLARE INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    120.78,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VLO',
    'VALERO ENERGY CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    116.09,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CTSH',
    'COGNIZANT TECHNOLOGY SOLUTIONS COR',
    'NASDAQ',
    'Information Technology',
    73.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CHTR',
    'CHARTER COMMUNICATIONS INC CLASS A',
    'NASDAQ',
    'Communication',
    391.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HES',
    'HESS CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    129.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PCG',
    'PG&E CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    16.52,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DHI',
    'D R HORTON INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    126.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HIG',
    'HARTFORD INSURANCE GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    122.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ETR',
    'ENTERGY CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    83.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BKR',
    'BAKER HUGHES CLASS A',
    'NASDAQ',
    'Energy',
    35.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RBLX',
    'ROBLOX CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Communication',
    67.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IDXX',
    'IDEXX LABORATORIES INC',
    'NASDAQ',
    'Health Care',
    432.65,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SYY',
    'SYSCO CORP',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    71.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VMC',
    'VULCAN MATERIALS',
    'New York Stock Exchange Inc.',
    'Materials',
    262.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WEC',
    'WEC ENERGY GROUP INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    109.52,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RMD',
    'RESMED INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    236.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VEEV',
    'VEEVA SYSTEMS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Health Care',
    233.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CAH',
    'CARDINAL HEALTH INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    141.29,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GLW',
    'CORNING INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    44.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALNY',
    'ALNYLAM PHARMACEUTICALS INC',
    'NASDAQ',
    'Health Care',
    263.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FERG',
    'FERGUSON ENTERPRISES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    169.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VICI',
    'VICI PPTYS INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    32.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HOOD',
    'ROBINHOOD MARKETS INC CLASS A',
    'NASDAQ',
    'Financials',
    49.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EBAY',
    'EBAY INC',
    'NASDAQ',
    'Consumer Discretionary',
    68.16,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'XYZ',
    'BLOCK INC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    58.47,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ACGL',
    'ARCH CAPITAL GROUP LTD',
    'NASDAQ',
    'Financials',
    90.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MLM',
    'MARTIN MARIETTA MATERIALS INC',
    'New York Stock Exchange Inc.',
    'Materials',
    523.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GEHC',
    'GE HEALTHCARE TECHNOLOGIES INC',
    'NASDAQ',
    'Health Care',
    70.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EFX',
    'EQUIFAX INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    260.13,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IT',
    'GARTNER INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    421.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HUM',
    'HUMANA INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    262.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WAB',
    'WESTINGHOUSE AIR BRAKE TECHNOLOGIE',
    'New York Stock Exchange Inc.',
    'Industrials',
    184.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LULU',
    'LULULEMON ATHLETICA INC',
    'NASDAQ',
    'Consumer Discretionary',
    270.77,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NDAQ',
    'NASDAQ INC',
    'NASDAQ',
    'Financials',
    76.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GIS',
    'GENERAL MILLS INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    56.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WTW',
    'WILLIS TOWERS WATSON PLC',
    'NASDAQ',
    'Financials',
    307.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DDOG',
    'DATADOG INC CLASS A',
    'NASDAQ',
    'Information Technology',
    102.16,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'A',
    'AGILENT TECHNOLOGIES INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    107.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CSGP',
    'COSTAR GROUP INC',
    'NASDAQ',
    'Real Estate',
    74.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EXR',
    'EXTRA SPACE STORAGE REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    146.52,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VRT',
    'VERTIV HOLDINGS CLASS A',
    'New York Stock Exchange Inc.',
    'Industrials',
    85.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IR',
    'INGERSOLL RAND INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    75.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HUBS',
    'HUBSPOT INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    611.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CNC',
    'CENTENE CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    59.85,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'USD',
    'USD CASH',
    '--',
    'Cash and/or Derivatives',
    100.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AVB',
    'AVALONBAY COMMUNITIES REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    209.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ODFL',
    'OLD DOMINION FREIGHT LINE INC',
    'NASDAQ',
    'Industrials',
    153.28,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'STZ',
    'CONSTELLATION BRANDS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    187.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VTR',
    'VENTAS REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    70.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'XYL',
    'XYLEM INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    120.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EQT',
    'EQT CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    49.44,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GRMN',
    'GARMIN LTD',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    186.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AWK',
    'AMERICAN WATER WORKS INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    147.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DTE',
    'DTE ENERGY',
    'New York Stock Exchange Inc.',
    'Utilities',
    137.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ARES',
    'ARES MANAGEMENT CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    152.53,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BR',
    'BROADRIDGE FINANCIAL SOLUTIONS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    242.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MTB',
    'M&T BANK CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    169.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ANSS',
    'ANSYS INC',
    'NASDAQ',
    'Information Technology',
    321.88,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ROK',
    'ROCKWELL AUTOMATION INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    247.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NUE',
    'NUCOR CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    119.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IQV',
    'IQVIA HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    155.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DXCM',
    'DEXCOM INC',
    'NASDAQ',
    'Health Care',
    71.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MPWR',
    'MONOLITHIC POWER SYSTEMS INC',
    'NASDAQ',
    'Information Technology',
    593.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RJF',
    'RAYMOND JAMES INC',
    'New York Stock Exchange Inc.',
    'Financials',
    137.04,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DD',
    'DUPONT DE NEMOURS INC',
    'New York Stock Exchange Inc.',
    'Materials',
    65.99,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CPNG',
    'COUPANG INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    23.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PPL',
    'PPL CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    36.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DAL',
    'DELTA AIR LINES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    41.63,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TSCO',
    'TRACTOR SUPPLY',
    'NASDAQ',
    'Consumer Discretionary',
    50.62,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OXY',
    'OCCIDENTAL PETROLEUM CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    39.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BRO',
    'BROWN & BROWN INC',
    'New York Stock Exchange Inc.',
    'Financials',
    110.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EQR',
    'EQUITY RESIDENTIAL REIT',
    'New York Stock Exchange Inc.',
    'Real Estate',
    70.26,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CVNA',
    'CARVANA CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    244.35,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GDDY',
    'GODADDY INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    188.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AEE',
    'AMEREN CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    99.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SBAC',
    'SBA COMMUNICATIONS REIT CORP CLASS',
    'NASDAQ',
    'Real Estate',
    243.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IRM',
    'IRON MOUNTAIN INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    89.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'STT',
    'STATE STREET CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    88.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KHC',
    'KRAFT HEINZ',
    'NASDAQ',
    'Consumer Staples',
    29.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KEYS',
    'KEYSIGHT TECHNOLOGIES INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    145.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DELL',
    'DELL TECHNOLOGIES INC CLASS C',
    'New York Stock Exchange Inc.',
    'Information Technology',
    91.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LPLA',
    'LPL FINANCIAL HOLDINGS INC',
    'NASDAQ',
    'Financials',
    319.79,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CNP',
    'CENTERPOINT ENERGY INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    38.78,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PPG',
    'PPG INDUSTRIES INC',
    'New York Stock Exchange Inc.',
    'Materials',
    108.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FANG',
    'DIAMONDBACK ENERGY INC',
    'NASDAQ',
    'Energy',
    132.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LEN',
    'LENNAR A CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    108.61,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ATO',
    'ATMOS ENERGY CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    160.63,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FE',
    'FIRSTENERGY CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    42.88,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MCHP',
    'MICROCHIP TECHNOLOGY INC',
    'NASDAQ',
    'Information Technology',
    46.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HSY',
    'HERSHEY FOODS',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    167.19,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TPL',
    'TEXAS PACIFIC LAND CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    1288.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CHD',
    'CHURCH AND DWIGHT INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    99.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FITB',
    'FIFTH THIRD BANCORP',
    'NASDAQ',
    'Financials',
    35.94,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FTV',
    'FORTIVE CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    69.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EXE',
    'EXPAND ENERGY CORP',
    'NASDAQ',
    'Energy',
    103.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TTD',
    'TRADE DESK INC CLASS A',
    'NASDAQ',
    'Communication',
    53.63,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IP',
    'INTERNATIONAL PAPER',
    'New York Stock Exchange Inc.',
    'Materials',
    45.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HPQ',
    'HP INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    25.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VLTO',
    'VERALTO CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    95.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DRI',
    'DARDEN RESTAURANTS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    200.64,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CBOE',
    'CBOE GLOBAL MARKETS INC',
    'Cboe BZX',
    'Financials',
    221.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VRSN',
    'VERISIGN INC',
    'NASDAQ',
    'Information Technology',
    282.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DOV',
    'DOVER CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    170.65,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TYL',
    'TYLER TECHNOLOGIES INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    543.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MKL',
    'MARKEL GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    1818.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ADM',
    'ARCHER DANIELS MIDLAND',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    47.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UAL',
    'UNITED AIRLINES HOLDINGS INC',
    'NASDAQ',
    'Industrials',
    68.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'STE',
    'STERIS',
    'New York Stock Exchange Inc.',
    'Health Care',
    224.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MTD',
    'METTLER TOLEDO INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    1070.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CPAY',
    'CORPAY INC',
    'New York Stock Exchange Inc.',
    'Financials',
    325.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NRG',
    'NRG ENERGY INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    109.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CMS',
    'CMS ENERGY CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    73.65,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ES',
    'EVERSOURCE ENERGY',
    'New York Stock Exchange Inc.',
    'Utilities',
    59.48,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SW',
    'SMURFIT WESTROCK PLC',
    'New York Stock Exchange Inc.',
    'Materials',
    42.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'K',
    'KELLANOVA',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    82.77,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TDY',
    'TELEDYNE TECHNOLOGIES INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    466.03,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CDW',
    'CDW CORP',
    'NASDAQ',
    'Information Technology',
    160.56,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DOW',
    'DOW INC',
    'New York Stock Exchange Inc.',
    'Materials',
    30.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CINF',
    'CINCINNATI FINANCIAL CORP',
    'NASDAQ',
    'Financials',
    139.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HPE',
    'HEWLETT PACKARD ENTERPRISE',
    'New York Stock Exchange Inc.',
    'Information Technology',
    16.22,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WRB',
    'WR BERKLEY CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    71.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ZS',
    'ZSCALER INC',
    'NASDAQ',
    'Information Technology',
    226.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HBAN',
    'HUNTINGTON BANCSHARES INC',
    'NASDAQ',
    'Financials',
    14.53,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMCR',
    'AMCOR PLC',
    'New York Stock Exchange Inc.',
    'Materials',
    9.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LYV',
    'LIVE NATION ENTERTAINMENT INC',
    'New York Stock Exchange Inc.',
    'Communication',
    132.45,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WBD',
    'WARNER BROS. DISCOVERY INC SERIES',
    'NASDAQ',
    'Communication',
    8.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PHM',
    'PULTEGROUP INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    102.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'INVH',
    'INVITATION HOMES INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    34.19,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DG',
    'DOLLAR GENERAL CORP',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    93.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WAT',
    'WATERS CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    347.73,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ZM',
    'ZOOM COMMUNICATIONS INC CLASS A',
    'NASDAQ',
    'Information Technology',
    77.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ZBH',
    'ZIMMER BIOMET HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    103.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EIX',
    'EDISON INTERNATIONAL',
    'New York Stock Exchange Inc.',
    'Utilities',
    53.51,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FCNCA',
    'FIRST CITIZENS BANCSHARES INC CLAS',
    'NASDAQ',
    'Financials',
    1779.14,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LH',
    'LABCORP HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    241.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NVR',
    'NVR INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    7125.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SYF',
    'SYNCHRONY FINANCIAL',
    'New York Stock Exchange Inc.',
    'Financials',
    51.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IFF',
    'INTERNATIONAL FLAVORS & FRAGRANCES',
    'New York Stock Exchange Inc.',
    'Materials',
    78.46,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LDOS',
    'LEIDOS HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    147.18,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DGX',
    'QUEST DIAGNOSTICS INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    178.22,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GPN',
    'GLOBAL PAYMENTS INC',
    'New York Stock Exchange Inc.',
    'Financials',
    76.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HUBB',
    'HUBBELL INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    363.18,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MKC',
    'MCCORMICK & CO NON-VOTING INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    76.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EXPE',
    'EXPEDIA GROUP INC',
    'NASDAQ',
    'Consumer Discretionary',
    156.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TROW',
    'T ROWE PRICE GROUP INC',
    'NASDAQ',
    'Financials',
    88.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CCL',
    'CARNIVAL CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    18.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DVN',
    'DEVON ENERGY CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    30.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WSM',
    'WILLIAMS SONOMA INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    154.47,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WY',
    'WEYERHAEUSER REIT',
    'New York Stock Exchange Inc.',
    'Real Estate',
    25.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RF',
    'REGIONS FINANCIAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    20.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MAA',
    'MID AMERICA APARTMENT COMMUNITIES',
    'New York Stock Exchange Inc.',
    'Real Estate',
    159.65,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FWONK',
    'LIBERTY MEDIA FORMULA ONE CORP SER',
    'NASDAQ',
    'Communication',
    88.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MOH',
    'MOLINA HEALTHCARE INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    327.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RBA',
    'RB GLOBAL INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    100.7,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ULTA',
    'ULTA BEAUTY INC',
    'NASDAQ',
    'Consumer Discretionary',
    395.64,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'STLD',
    'STEEL DYNAMICS INC',
    'NASDAQ',
    'Materials',
    129.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PTC',
    'PTC INC',
    'NASDAQ',
    'Information Technology',
    154.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OKTA',
    'OKTA INC CLASS A',
    'NASDAQ',
    'Information Technology',
    112.16,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NI',
    'NISOURCE INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    39.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EME',
    'EMCOR GROUP INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    400.7,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NTRS',
    'NORTHERN TRUST CORP',
    'NASDAQ',
    'Financials',
    93.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NTAP',
    'NETAPP INC',
    'NASDAQ',
    'Information Technology',
    89.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IBKR',
    'INTERACTIVE BROKERS GROUP INC CLAS',
    'NASDAQ',
    'Financials',
    171.85,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CTRA',
    'COTERRA ENERGY INC',
    'New York Stock Exchange Inc.',
    'Energy',
    24.56,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ESS',
    'ESSEX PROPERTY TRUST REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    279.15,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BIIB',
    'BIOGEN INC',
    'NASDAQ',
    'Health Care',
    121.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PODD',
    'INSULET CORP',
    'NASDAQ',
    'Health Care',
    252.29,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CLX',
    'CLOROX',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    142.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HAL',
    'HALLIBURTON',
    'New York Stock Exchange Inc.',
    'Energy',
    19.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TSN',
    'TYSON FOODS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    61.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NTRA',
    'NATERA INC',
    'NASDAQ',
    'Health Care',
    150.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LII',
    'LENNOX INTERNATIONAL INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    546.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NTNX',
    'NUTANIX INC CLASS A',
    'NASDAQ',
    'Information Technology',
    68.7,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CSL',
    'CARLISLE COMPANIES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    379.48,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CASY',
    'CASEYS GENERAL STORES INC',
    'NASDAQ',
    'Consumer Staples',
    462.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DPZ',
    'DOMINOS PIZZA INC',
    'NASDAQ',
    'Consumer Discretionary',
    490.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ON',
    'ON SEMICONDUCTOR CORP',
    'NASDAQ',
    'Information Technology',
    39.7,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PFG',
    'PRINCIPAL FINANCIAL GROUP INC',
    'NASDAQ',
    'Financials',
    74.15,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GWRE',
    'GUIDEWIRE SOFTWARE INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    204.77,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DECK',
    'DECKERS OUTDOOR CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    110.83,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LUV',
    'SOUTHWEST AIRLINES',
    'New York Stock Exchange Inc.',
    'Industrials',
    27.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FNF',
    'FIDELITY NATIONAL FINANCIAL INC',
    'New York Stock Exchange Inc.',
    'Financials',
    64.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TPR',
    'TAPESTRY INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    70.65,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TOST',
    'TOAST INC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    35.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GPC',
    'GENUINE PARTS',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    117.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DLTR',
    'DOLLAR TREE INC',
    'NASDAQ',
    'Consumer Staples',
    81.77,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FDS',
    'FACTSET RESEARCH SYSTEMS INC',
    'New York Stock Exchange Inc.',
    'Financials',
    432.22,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DOCU',
    'DOCUSIGN INC',
    'NASDAQ',
    'Information Technology',
    81.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PKG',
    'PACKAGING CORP OF AMERICA',
    'New York Stock Exchange Inc.',
    'Materials',
    185.61,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SSNC',
    'SS AND C TECHNOLOGIES HOLDINGS INC',
    'NASDAQ',
    'Industrials',
    75.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SNA',
    'SNAP ON INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    313.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HEIA',
    'HEICO CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Industrials',
    200.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CFG',
    'CITIZENS FINANCIAL GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    36.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TW',
    'TRADEWEB MARKETS INC CLASS A',
    'NASDAQ',
    'Financials',
    138.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TRU',
    'TRANSUNION',
    'New York Stock Exchange Inc.',
    'Industrials',
    82.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ROL',
    'ROLLINS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    57.13,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WSO',
    'WATSCO INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    459.84,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BAX',
    'BAXTER INTERNATIONAL INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    31.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COO',
    'COOPER INC',
    'NASDAQ',
    'Health Care',
    81.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SMCI',
    'SUPER MICRO COMPUTER INC',
    'NASDAQ',
    'Information Technology',
    31.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SUI',
    'SUN COMMUNITIES REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    124.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LNT',
    'ALLIANT ENERGY CORP',
    'NASDAQ',
    'Utilities',
    61.04,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JBL',
    'JABIL INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    146.56,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BJ',
    'BJS WHOLESALE CLUB HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    117.56,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'L',
    'LOEWS CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    86.83,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RS',
    'RELIANCE STEEL & ALUMINUM',
    'New York Stock Exchange Inc.',
    'Materials',
    288.23,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EXPD',
    'EXPEDITORS INTERNATIONAL OF WASHIN',
    'New York Stock Exchange Inc.',
    'Industrials',
    109.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EVRG',
    'EVERGY INC',
    'NASDAQ',
    'Utilities',
    69.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BAH',
    'BOOZ ALLEN HAMILTON HOLDING CORP C',
    'New York Stock Exchange Inc.',
    'Industrials',
    120.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BALL',
    'BALL CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    51.94,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WST',
    'WEST PHARMACEUTICAL SERVICES INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    211.29,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FFIV',
    'F5 INC',
    'NASDAQ',
    'Information Technology',
    264.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'J',
    'JACOBS SOLUTIONS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    123.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WDC',
    'WESTERN DIGITAL CORP',
    'NASDAQ',
    'Information Technology',
    43.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EG',
    'EVEREST GROUP LTD',
    'New York Stock Exchange Inc.',
    'Financials',
    358.83,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LYB',
    'LYONDELLBASELL INDUSTRIES NV CLASS',
    'New York Stock Exchange Inc.',
    'Materials',
    58.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DKNG',
    'DRAFTKINGS INC CLASS A',
    'NASDAQ',
    'Consumer Discretionary',
    33.29,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PNR',
    'PENTAIR',
    'New York Stock Exchange Inc.',
    'Industrials',
    90.73,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TRMB',
    'TRIMBLE INC',
    'NASDAQ',
    'Information Technology',
    62.14,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PINS',
    'PINTEREST INC CLASS A',
    'New York Stock Exchange Inc.',
    'Communication',
    25.32,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TWLO',
    'TWILIO INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    96.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EQH',
    'EQUITABLE HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Financials',
    49.45,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OMC',
    'OMNICOM GROUP INC',
    'New York Stock Exchange Inc.',
    'Communication',
    76.16,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DUOL',
    'DUOLINGO INC CLASS A',
    'NASDAQ',
    'Consumer Discretionary',
    389.48,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BBY',
    'BEST BUY INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    66.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'USFD',
    'US FOODS HOLDING CORP',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    65.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BURL',
    'BURLINGTON STORES INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    225.04,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UNM',
    'UNUM',
    'New York Stock Exchange Inc.',
    'Financials',
    77.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GEN',
    'GEN DIGITAL INC',
    'NASDAQ',
    'Information Technology',
    25.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PSTG',
    'PURE STORAGE INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    45.36,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FIX',
    'COMFORT SYSTEMS USA INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    397.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DT',
    'DYNATRACE INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    46.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EL',
    'ESTEE LAUDER INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    59.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GGG',
    'GRACO INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    81.61,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UDR',
    'UDR REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    41.88,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BLDR',
    'BUILDERS FIRSTSOURCE INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    119.63,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KEY',
    'KEYCORP',
    'New York Stock Exchange Inc.',
    'Financials',
    14.84,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AVY',
    'AVERY DENNISON CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    171.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WPC',
    'W. P. CAREY REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    62.44,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CF',
    'CF INDUSTRIES HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Materials',
    78.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'THC',
    'TENET HEALTHCARE CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    142.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RPM',
    'RPM INTERNATIONAL INC',
    'New York Stock Exchange Inc.',
    'Materials',
    106.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FSLR',
    'FIRST SOLAR INC',
    'NASDAQ',
    'Information Technology',
    125.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'APTV',
    'APTIV PLC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    57.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AFRM',
    'AFFIRM HOLDINGS INC CLASS A',
    'NASDAQ',
    'Financials',
    49.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IEX',
    'IDEX CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    173.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SOFI',
    'SOFI TECHNOLOGIES INC',
    'NASDAQ',
    'Financials',
    12.51,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UTHR',
    'UNITED THERAPEUTICS CORP',
    'NASDAQ',
    'Health Care',
    303.09,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KIM',
    'KIMCO REALTY REIT CORP',
    'New York Stock Exchange Inc.',
    'Real Estate',
    19.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TXT',
    'TEXTRON INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    70.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ACM',
    'AECOM',
    'New York Stock Exchange Inc.',
    'Industrials',
    98.65,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CW',
    'CURTISS WRIGHT CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    344.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MAS',
    'MASCO CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    60.61,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'REG',
    'REGENCY CENTERS REIT CORP',
    'NASDAQ',
    'Real Estate',
    72.18,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALGN',
    'ALIGN TECHNOLOGY INC',
    'NASDAQ',
    'Health Care',
    173.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HOLX',
    'HOLOGIC INC',
    'NASDAQ',
    'Health Care',
    58.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LVS',
    'LAS VEGAS SANDS CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    36.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TKO',
    'TKO GROUP HOLDINGS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Communication',
    162.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RPRX',
    'ROYALTY PHARMA PLC CLASS A',
    'NASDAQ',
    'Health Care',
    32.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JKHY',
    'JACK HENRY AND ASSOCIATES INC',
    'NASDAQ',
    'Financials',
    173.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ZBRA',
    'ZEBRA TECHNOLOGIES CORP CLASS A',
    'NASDAQ',
    'Information Technology',
    250.32,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMH',
    'AMERICAN HOMES RENT REIT CLASS A',
    'New York Stock Exchange Inc.',
    'Real Estate',
    37.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OC',
    'OWENS CORNING',
    'New York Stock Exchange Inc.',
    'Industrials',
    145.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PFGC',
    'PERFORMANCE FOOD GROUP',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    80.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ARE',
    'ALEXANDRIA REAL ESTATE EQUITIES RE',
    'New York Stock Exchange Inc.',
    'Real Estate',
    72.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MDB',
    'MONGODB INC CLASS A',
    'NASDAQ',
    'Information Technology',
    172.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ILMN',
    'ILLUMINA INC',
    'NASDAQ',
    'Health Care',
    77.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GLPI',
    'GAMING AND LEISURE PROPERTIES REIT',
    'NASDAQ',
    'Real Estate',
    47.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DOC',
    'HEALTHPEAK PROPERTIES INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    17.84,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ELS',
    'EQUITY LIFESTYLE PROPERTIES REIT I',
    'New York Stock Exchange Inc.',
    'Real Estate',
    64.78,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RNR',
    'RENAISSANCERE HOLDING LTD',
    'New York Stock Exchange Inc.',
    'Financials',
    241.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RGA',
    'REINSURANCE GROUP OF AMERICA INC',
    'New York Stock Exchange Inc.',
    'Financials',
    187.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALLE',
    'ALLEGION PLC',
    'New York Stock Exchange Inc.',
    'Industrials',
    139.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AKAM',
    'AKAMAI TECHNOLOGIES INC',
    'NASDAQ',
    'Information Technology',
    80.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'XPO',
    'XPO INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    106.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FTI',
    'TECHNIPFMC PLC',
    'New York Stock Exchange Inc.',
    'Energy',
    28.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EWBC',
    'EAST WEST BANCORP INC',
    'NASDAQ',
    'Financials',
    85.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BMRN',
    'BIOMARIN PHARMACEUTICAL INC',
    'NASDAQ',
    'Health Care',
    63.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RGLD',
    'ROYAL GOLD INC',
    'NASDAQ',
    'Materials',
    182.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SJM',
    'JM SMUCKER',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    116.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CPT',
    'CAMDEN PROPERTY TRUST REIT',
    'New York Stock Exchange Inc.',
    'Real Estate',
    113.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ENTG',
    'ENTEGRIS INC',
    'NASDAQ',
    'Information Technology',
    79.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CAG',
    'CONAGRA BRANDS INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    24.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JNPR',
    'JUNIPER NETWORKS INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    36.32,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PAYC',
    'PAYCOM SOFTWARE INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    226.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TER',
    'TERADYNE INC',
    'NASDAQ',
    'Information Technology',
    74.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RIVN',
    'RIVIAN AUTOMOTIVE INC CLASS A',
    'NASDAQ',
    'Consumer Discretionary',
    13.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EHC',
    'ENCOMPASS HEALTH CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    116.99,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ITT',
    'ITT INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    137.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RVTY',
    'REVVITY INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    93.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CCK',
    'CROWN HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Materials',
    96.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EXEL',
    'EXELIXIS INC',
    'NASDAQ',
    'Health Care',
    39.15,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SCI',
    'SERVICE',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    79.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HEI',
    'HEICO CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    250.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TXRH',
    'TEXAS ROADHOUSE INC',
    'NASDAQ',
    'Consumer Discretionary',
    165.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FOXA',
    'FOX CORP CLASS A',
    'NASDAQ',
    'Communication',
    49.79,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CLH',
    'CLEAN HARBORS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    213.94,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NLY',
    'ANNALY CAPITAL MANAGEMENT REIT INC',
    'New York Stock Exchange Inc.',
    'Financials',
    19.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PEN',
    'PENUMBRA INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    292.84,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GME',
    'GAMESTOP CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    27.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WWD',
    'WOODWARD INC',
    'NASDAQ',
    'Industrials',
    187.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'POOL',
    'POOL CORP',
    'NASDAQ',
    'Consumer Discretionary',
    293.14,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JLL',
    'JONES LANG LASALLE INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    227.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MANH',
    'MANHATTAN ASSOCIATES INC',
    'NASDAQ',
    'Information Technology',
    177.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NDSN',
    'NORDSON CORP',
    'NASDAQ',
    'Industrials',
    189.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PNW',
    'PINNACLE WEST CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    95.18,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NBIX',
    'NEUROCRINE BIOSCIENCES INC',
    'NASDAQ',
    'Health Care',
    107.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JBHT',
    'JB HUNT TRANSPORT SERVICES INC',
    'NASDAQ',
    'Industrials',
    130.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DKS',
    'DICKS SPORTING INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    187.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OHI',
    'OMEGA HEALTHCARE INVESTORS REIT IN',
    'New York Stock Exchange Inc.',
    'Real Estate',
    39.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BG',
    'BUNGE GLOBAL SA',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    78.72,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SGI',
    'SOMNIGROUP INTERNATIONAL INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    61.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'Z',
    'ZILLOW GROUP INC CLASS C',
    'NASDAQ',
    'Real Estate',
    67.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WTRG',
    'ESSENTIAL UTILITIES INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    41.13,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NWSA',
    'NEWS CORP CLASS A',
    'NASDAQ',
    'Communication',
    27.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SWKS',
    'SKYWORKS SOLUTIONS INC',
    'NASDAQ',
    'Information Technology',
    64.28,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CHRW',
    'CH ROBINSON WORLDWIDE INC',
    'NASDAQ',
    'Industrials',
    89.22,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UHS',
    'UNIVERSAL HEALTH SERVICES INC CLAS',
    'New York Stock Exchange Inc.',
    'Health Care',
    177.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GL',
    'GLOBE LIFE INC',
    'New York Stock Exchange Inc.',
    'Financials',
    123.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CNM',
    'CORE & MAIN INC CLASS A',
    'New York Stock Exchange Inc.',
    'Industrials',
    52.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VTRS',
    'VIATRIS INC',
    'NASDAQ',
    'Health Care',
    8.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CNH',
    'CNH INDUSTRIAL N.V. NV',
    'New York Stock Exchange Inc.',
    'Industrials',
    11.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CACI',
    'CACI INTERNATIONAL INC CLASS A',
    'New York Stock Exchange Inc.',
    'Industrials',
    457.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LAMR',
    'LAMAR ADVERTISING COMPANY CLAS',
    'NASDAQ',
    'Real Estate',
    113.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AR',
    'ANTERO RESOURCES CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    34.83,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BRBR',
    'BELLRING BRANDS INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    77.14,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LKQ',
    'LKQ CORP',
    'NASDAQ',
    'Consumer Discretionary',
    38.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'INCY',
    'INCYTE CORP',
    'NASDAQ',
    'Health Care',
    62.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ATR',
    'APTARGROUP INC',
    'New York Stock Exchange Inc.',
    'Materials',
    149.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LBRDK',
    'LIBERTY BROADBAND CORP SERIES C',
    'NASDAQ',
    'Communication',
    90.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TOL',
    'TOLL BROTHERS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    100.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BXP',
    'BXP INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    63.73,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AIZ',
    'ASSURANT INC',
    'New York Stock Exchange Inc.',
    'Financials',
    192.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HST',
    'HOST HOTELS & RESORTS REIT INC',
    'NASDAQ',
    'Real Estate',
    14.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KMX',
    'CARMAX INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    64.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DOX',
    'AMDOCS LTD',
    'NASDAQ',
    'Information Technology',
    88.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BWXT',
    'BWX TECHNOLOGIES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    109.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LECO',
    'LINCOLN ELECTRIC HOLDINGS INC',
    'NASDAQ',
    'Industrials',
    176.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DTM',
    'DT MIDSTREAM INC',
    'New York Stock Exchange Inc.',
    'Energy',
    97.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TAP',
    'MOLSON COORS BREWING CLASS B',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    57.53,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'X',
    'US STEEL CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    43.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MOS',
    'MOSAIC',
    'New York Stock Exchange Inc.',
    'Materials',
    30.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CIEN',
    'CIENA CORP',
    'New York Stock Exchange Inc.',
    'Information Technology',
    67.16,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OWL',
    'BLUE OWL CAPITAL INC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    18.53,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IPG',
    'INTERPUBLIC GROUP OF COMPANIES INC',
    'New York Stock Exchange Inc.',
    'Communication',
    25.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KNSL',
    'KINSALE CAPITAL GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    435.26,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FHN',
    'FIRST HORIZON CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    18.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MUSA',
    'MURPHY USA INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    498.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SWK',
    'STANLEY BLACK & DECKER INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    60.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OGE',
    'OGE ENERGY CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    45.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RBC',
    'RBC BEARINGS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    328.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MRNA',
    'MODERNA INC',
    'NASDAQ',
    'Health Care',
    28.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'QGEN',
    'QIAGEN NV',
    'New York Stock Exchange Inc.',
    'Health Care',
    42.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SOLV',
    'SOLVENTUM CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    66.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AFG',
    'AMERICAN FINANCIAL GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    126.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ACI',
    'ALBERTSONS COMPANY INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    21.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CUBE',
    'CUBESMART REIT',
    'New York Stock Exchange Inc.',
    'Real Estate',
    40.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NVT',
    'NVENT ELECTRIC PLC',
    'New York Stock Exchange Inc.',
    'Industrials',
    54.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HII',
    'HUNTINGTON INGALLS INDUSTRIES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    230.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALLY',
    'ALLY FINANCIAL INC',
    'New York Stock Exchange Inc.',
    'Financials',
    32.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BLD',
    'TOPBUILD CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    295.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ORI',
    'OLD REPUBLIC INTERNATIONAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    37.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RL',
    'RALPH LAUREN CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    224.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AVTR',
    'AVANTOR INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    12.99,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EMN',
    'EASTMAN CHEMICAL',
    'New York Stock Exchange Inc.',
    'Materials',
    77.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HLI',
    'HOULIHAN LOKEY INC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    162.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'G',
    'GENPACT LTD',
    'New York Stock Exchange Inc.',
    'Industrials',
    50.26,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FYBR',
    'FRONTIER COMMUNICATIONS PARENT INC',
    'NASDAQ',
    'Communication',
    36.25,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ARMK',
    'ARAMARK',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    33.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HRL',
    'HORMEL FOODS CORP',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    29.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DAY',
    'DAYFORCE INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    57.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OVV',
    'OVINTIV INC',
    'New York Stock Exchange Inc.',
    'Energy',
    33.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EPAM',
    'EPAM SYSTEMS INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    156.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ROKU',
    'ROKU INC CLASS A',
    'NASDAQ',
    'Communication',
    68.18,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CHE',
    'CHEMED CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    581.51,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PRI',
    'PRIMERICA INC',
    'New York Stock Exchange Inc.',
    'Financials',
    262.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HAS',
    'HASBRO INC',
    'NASDAQ',
    'Consumer Discretionary',
    61.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'APG',
    'API GROUP CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    37.83,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'INGR',
    'INGREDION INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    132.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SF',
    'STIFEL FINANCIAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    85.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CG',
    'CARLYLE GROUP INC',
    'NASDAQ',
    'Financials',
    38.64,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PCTY',
    'PAYLOCITY HOLDING CORP',
    'NASDAQ',
    'Industrials',
    192.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NYT',
    'NEW YORK TIMES CLASS A',
    'New York Stock Exchange Inc.',
    'Communication',
    52.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HRB',
    'H&R BLOCK INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    60.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COKE',
    'COCA COLA CONSOLIDATED INC',
    'NASDAQ',
    'Consumer Staples',
    1355.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EXAS',
    'EXACT SCIENCES CORP',
    'NASDAQ',
    'Health Care',
    45.64,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SNX',
    'TD SYNNEX CORP',
    'New York Stock Exchange Inc.',
    'Information Technology',
    110.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MKTX',
    'MARKETAXESS HOLDINGS INC',
    'NASDAQ',
    'Financials',
    221.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AOS',
    'A O SMITH CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    67.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TTEK',
    'TETRA TECH INC',
    'NASDAQ',
    'Industrials',
    31.19,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EGP',
    'EASTGROUP PROPERTIES REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    163.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JEF',
    'JEFFERIES FINANCIAL GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    46.73,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WBS',
    'WEBSTER FINANCIAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    47.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALSN',
    'ALLISON TRANSMISSION HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    92.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COHR',
    'COHERENT CORP',
    'New York Stock Exchange Inc.',
    'Information Technology',
    64.32,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GMED',
    'GLOBUS MEDICAL INC CLASS A',
    'New York Stock Exchange Inc.',
    'Health Care',
    71.77,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HSIC',
    'HENRY SCHEIN INC',
    'NASDAQ',
    'Health Care',
    64.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FRT',
    'FEDERAL REALTY INVESTMENT TRUST RE',
    'New York Stock Exchange Inc.',
    'Real Estate',
    94.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WMS',
    'ADVANCED DRAINAGE SYSTEMS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    113.49,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TECH',
    'BIO TECHNE CORP',
    'NASDAQ',
    'Health Care',
    50.35,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SEIC',
    'SEI INVESTMENTS',
    'NASDAQ',
    'Financials',
    78.29,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RRC',
    'RANGE RESOURCES CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    33.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DCI',
    'DONALDSON INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    65.73,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WYNN',
    'WYNN RESORTS LTD',
    'NASDAQ',
    'Consumer Discretionary',
    80.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ADC',
    'AGREE REALTY REIT CORP',
    'New York Stock Exchange Inc.',
    'Real Estate',
    77.61,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PLNT',
    'PLANET FITNESS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    94.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SCCO',
    'SOUTHERN COPPER CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    89.52,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MTZ',
    'MASTEC INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    127.32,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WBA',
    'WALGREEN BOOTS ALLIANCE INC',
    'NASDAQ',
    'Consumer Staples',
    10.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WING',
    'WINGSTOP INC',
    'NASDAQ',
    'Consumer Discretionary',
    263.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LAD',
    'LITHIA MOTORS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    292.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MEDP',
    'MEDPACE HOLDINGS INC',
    'NASDAQ',
    'Health Care',
    308.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CR',
    'CRANE',
    'New York Stock Exchange Inc.',
    'Industrials',
    160.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RGEN',
    'REPLIGEN CORP',
    'NASDAQ',
    'Health Care',
    137.99,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PR',
    'PERMIAN RESOURCES CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Energy',
    11.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LNW',
    'LIGHT WONDER INC',
    'NASDAQ',
    'Consumer Discretionary',
    85.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MORN',
    'MORNINGSTAR INC',
    'NASDAQ',
    'Financials',
    284.72,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MTCH',
    'MATCH GROUP INC',
    'NASDAQ',
    'Communication',
    29.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AGNC',
    'AGNC INVESTMENT REIT CORP',
    'NASDAQ',
    'Financials',
    8.83,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NNN',
    'NNN REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    41.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CBSH',
    'COMMERCE BANCSHARES INC',
    'NASDAQ',
    'Financials',
    60.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FND',
    'FLOOR DECOR HOLDINGS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    71.44,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LW',
    'LAMB WESTON HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    52.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ESTC',
    'ELASTIC NV',
    'New York Stock Exchange Inc.',
    'Information Technology',
    86.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GPK',
    'GRAPHIC PACKAGING HOLDING',
    'New York Stock Exchange Inc.',
    'Materials',
    25.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AYI',
    'ACUITY INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    243.61,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EXP',
    'EAGLE MATERIALS INC',
    'New York Stock Exchange Inc.',
    'Materials',
    226.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PNFP',
    'PINNACLE FINANCIAL PARTNERS INC',
    'NASDAQ',
    'Financials',
    100.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WAL',
    'WESTERN ALLIANCE',
    'New York Stock Exchange Inc.',
    'Financials',
    69.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EVR',
    'EVERCORE INC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    205.29,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KD',
    'KYNDRYL HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    32.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UBFUT',
    'CASH COLLATERAL USD UBFUT',
    '--',
    'Cash and/or Derivatives',
    100.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AXS',
    'AXIS CAPITAL HOLDINGS LTD',
    'New York Stock Exchange Inc.',
    'Financials',
    96.32,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BRX',
    'BRIXMOR PROPERTY GROUP REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    24.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MGM',
    'MGM RESORTS INTERNATIONAL',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    31.46,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WTFC',
    'WINTRUST FINANCIAL CORP',
    'NASDAQ',
    'Financials',
    111.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'REXR',
    'REXFORD INDUSTRIAL REALTY REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    33.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UGI',
    'UGI CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    32.79,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AZEK',
    'AZEK COMPANY INC CLASS A',
    'New York Stock Exchange Inc.',
    'Industrials',
    49.56,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BFAM',
    'BRIGHT HORIZONS FAMILY SOLUTIONS I',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    125.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CPB',
    'CAMPBELL SOUP',
    'NASDAQ',
    'Consumer Staples',
    36.46,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AES',
    'AES CORP',
    'New York Stock Exchange Inc.',
    'Utilities',
    10.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALAB',
    'ASTERA LABS INC',
    'NASDAQ',
    'Information Technology',
    65.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AXTA',
    'AXALTA COATING SYSTEMS LTD',
    'New York Stock Exchange Inc.',
    'Materials',
    32.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MIDD',
    'MIDDLEBY CORP',
    'NASDAQ',
    'Industrials',
    133.35,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CMA',
    'COMERICA INC',
    'New York Stock Exchange Inc.',
    'Financials',
    53.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RRX',
    'REGAL REXNORD CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    105.84,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DOCS',
    'DOXIMITY INC CLASS A',
    'New York Stock Exchange Inc.',
    'Health Care',
    56.88,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CAVA',
    'CAVA GROUP INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    92.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MASI',
    'MASIMO CORP',
    'NASDAQ',
    'Health Care',
    160.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JAZZ',
    'JAZZ PHARMACEUTICALS PLC',
    'NASDAQ',
    'Health Care',
    116.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KBR',
    'KBR INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    52.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'QRVO',
    'QORVO INC',
    'NASDAQ',
    'Information Technology',
    71.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NCLH',
    'NORWEGIAN CRUISE LINE HOLDINGS LTD',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    16.03,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALB',
    'ALBEMARLE CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    58.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CART',
    'MAPLEBEAR INC',
    'NASDAQ',
    'Consumer Staples',
    39.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NFG',
    'NATIONAL FUEL GAS',
    'New York Stock Exchange Inc.',
    'Utilities',
    76.78,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PARA',
    'PARAMOUNT GLOBAL CLASS B',
    'NASDAQ',
    'Communication',
    11.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CFR',
    'CULLEN FROST BANKERS INC',
    'New York Stock Exchange Inc.',
    'Financials',
    116.47,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ESAB',
    'ESAB CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    120.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WCC',
    'WESCO INTERNATIONAL INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    162.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GNRC',
    'GENERAC HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    114.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TTC',
    'TORO',
    'New York Stock Exchange Inc.',
    'Industrials',
    68.28,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RYAN',
    'RYAN SPECIALTY HOLDINGS INC CLASS',
    'New York Stock Exchange Inc.',
    'Financials',
    65.51,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PCOR',
    'PROCORE TECHNOLOGIES INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    64.09,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ATI',
    'ATI INC',
    'New York Stock Exchange Inc.',
    'Materials',
    54.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LSCC',
    'LATTICE SEMICONDUCTOR CORP',
    'NASDAQ',
    'Information Technology',
    48.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DVA',
    'DAVITA INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    141.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BPOP',
    'POPULAR INC',
    'NASDAQ',
    'Financials',
    95.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FBIN',
    'FORTUNE BRANDS INNOVATIONS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    53.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ZION',
    'ZIONS BANCORPORATION',
    'NASDAQ',
    'Financials',
    44.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BBWI',
    'BATH AND BODY WORKS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    30.51,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AAL',
    'AMERICAN AIRLINES GROUP INC',
    'NASDAQ',
    'Industrials',
    9.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'XP',
    'XP CLASS A INC',
    'NASDAQ',
    'Financials',
    16.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BROS',
    'DUTCH BROS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    59.74,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TFX',
    'TELEFLEX INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    137.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SSD',
    'SIMPSON MANUFACTURING INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    153.69,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'U',
    'UNITY SOFTWARE INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    21.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MTSI',
    'MACOM TECHNOLOGY SOLUTIONS INC',
    'NASDAQ',
    'Information Technology',
    103.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WH',
    'WYNDHAM HOTELS RESORTS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    85.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SAIA',
    'SAIA INC',
    'NASDAQ',
    'Industrials',
    244.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OLLI',
    'OLLIES BARGAIN OUTLET HOLDINGS INC',
    'NASDAQ',
    'Consumer Discretionary',
    106.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DBX',
    'DROPBOX INC CLASS A',
    'NASDAQ',
    'Information Technology',
    28.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TREX',
    'TREX INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    57.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IDA',
    'IDACORP INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    118.09,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CHDN',
    'CHURCHILL DOWNS INC',
    'NASDAQ',
    'Consumer Discretionary',
    90.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FR',
    'FIRST INDUSTRIAL REALTY TRUST INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    47.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VNO',
    'VORNADO REALTY TRUST REIT',
    'New York Stock Exchange Inc.',
    'Real Estate',
    35.28,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MTG',
    'MGIC INVESTMENT CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    24.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RLI',
    'RLI CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    74.01,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SKX',
    'SKECHERS USA INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    48.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AAON',
    'AAON INC',
    'NASDAQ',
    'Industrials',
    91.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AWI',
    'ARMSTRONG WORLD INDUSTRIES INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    145.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FAF',
    'FIRST AMERICAN FINANCIAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    60.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PB',
    'PROSPERITY BANCSHARES INC',
    'New York Stock Exchange Inc.',
    'Financials',
    67.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BWA',
    'BORGWARNER INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    28.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SNV',
    'SYNOVUS FINANCIAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    43.32,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CELH',
    'CELSIUS HOLDINGS INC',
    'NASDAQ',
    'Consumer Staples',
    34.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'STWD',
    'STARWOOD PROPERTY TRUST REIT INC',
    'New York Stock Exchange Inc.',
    'Financials',
    19.19,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FOX',
    'FOX CORP CLASS B',
    'NASDAQ',
    'Communication',
    46.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'STAG',
    'STAG INDUSTRIAL REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    33.03,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AA',
    'ALCOA CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    24.53,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SLM',
    'SLM CORP',
    'NASDAQ',
    'Financials',
    28.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CRL',
    'CHARLES RIVER LABORATORIES INTERNA',
    'New York Stock Exchange Inc.',
    'Health Care',
    118.62,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KNX',
    'KNIGHT-SWIFT TRANSPORTATION HOLDIN',
    'New York Stock Exchange Inc.',
    'Industrials',
    39.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BSY',
    'BENTLEY SYSTEMS INC CLASS B',
    'NASDAQ',
    'Information Technology',
    42.99,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FLS',
    'FLOWSERVE CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    45.23,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BFB',
    'BROWN FORMAN CORP CLASS B',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    34.84,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CFLT',
    'CONFLUENT INC CLASS A',
    'NASDAQ',
    'Information Technology',
    23.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'THG',
    'HANOVER INSURANCE GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    166.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ONTO',
    'ONTO INNOVATION INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    121.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MSA',
    'MSA SAFETY INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    157.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ARW',
    'ARROW ELECTRONICS INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    111.36,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'POST',
    'POST HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    113.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SAIC',
    'SCIENCE APPLICATIONS INTERNATIONAL',
    'NASDAQ',
    'Industrials',
    121.03,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ENPH',
    'ENPHASE ENERGY INC',
    'NASDAQ',
    'Information Technology',
    44.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'R',
    'RYDER SYSTEM INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    137.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FCN',
    'FTI CONSULTING INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    166.28,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OLED',
    'UNIVERSAL DISPLAY CORP',
    'NASDAQ',
    'Information Technology',
    125.63,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CZR',
    'CAESARS ENTERTAINMENT INC',
    'NASDAQ',
    'Consumer Discretionary',
    27.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BEN',
    'FRANKLIN RESOURCES INC',
    'New York Stock Exchange Inc.',
    'Financials',
    18.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GTLB',
    'GITLAB INC CLASS A',
    'NASDAQ',
    'Information Technology',
    46.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VMI',
    'VALMONT INDS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    293.22,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RITM',
    'RITHM CAPITAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    11.18,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VOYA',
    'VOYA FINANCIAL INC',
    'New York Stock Exchange Inc.',
    'Financials',
    59.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SRPT',
    'SAREPTA THERAPEUTICS INC',
    'NASDAQ',
    'Health Care',
    62.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'APA',
    'APA CORP',
    'NASDAQ',
    'Energy',
    15.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KEX',
    'KIRBY CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    96.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AM',
    'ANTERO MIDSTREAM CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    16.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CHRD',
    'CHORD ENERGY CORP',
    'NASDAQ',
    'Energy',
    90.23,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MHK',
    'MOHAWK INDUSTRIES INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    106.35,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COLD',
    'AMERICOLD REALTY INC TRUST',
    'New York Stock Exchange Inc.',
    'Real Estate',
    19.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LPX',
    'LOUISIANA PACIFIC CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    86.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UHALB',
    'U HAUL NON VOTING SERIES N',
    'New York Stock Exchange Inc.',
    'Industrials',
    54.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HR',
    'HEALTHCARE REALTY TRUST INC CLASS',
    'New York Stock Exchange Inc.',
    'Real Estate',
    15.53,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CROX',
    'CROCS INC',
    'NASDAQ',
    'Consumer Discretionary',
    96.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OMF',
    'ONEMAIN HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Financials',
    47.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OSK',
    'OSHKOSH CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    83.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AGCO',
    'AGCO CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    84.83,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MAT',
    'MATTEL INC',
    'NASDAQ',
    'Consumer Discretionary',
    15.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALK',
    'ALASKA AIR GROUP INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    44.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LNC',
    'LINCOLN NATIONAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    31.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MTN',
    'VAIL RESORTS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    139.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PATH',
    'UIPATH INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    11.94,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SN',
    'SHARKNINJA INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    80.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FOUR',
    'SHIFT4 PAYMENTS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    81.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SITE',
    'SITEONE LANDSCAPE SUPPLY INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    114.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LOPE',
    'GRAND CANYON EDUCATION INC',
    'NASDAQ',
    'Consumer Discretionary',
    178.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CRUS',
    'CIRRUS LOGIC INC',
    'NASDAQ',
    'Information Technology',
    96.04,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FMC',
    'FMC CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    41.92,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VNOM',
    'VIPER ENERGY INC CLASS A',
    'NASDAQ',
    'Energy',
    40.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WEX',
    'WEX INC',
    'New York Stock Exchange Inc.',
    'Financials',
    130.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IVZ',
    'INVESCO LTD',
    'New York Stock Exchange Inc.',
    'Financials',
    13.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'S',
    'SENTINELONE INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    18.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DAR',
    'DARLING INGREDIENTS INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    32.19,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GNTX',
    'GENTEX CORP',
    'NASDAQ',
    'Consumer Discretionary',
    21.78,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ETSY',
    'ETSY INC',
    'NASDAQ',
    'Consumer Discretionary',
    43.48,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ROIV',
    'ROIVANT SCIENCES LTD',
    'NASDAQ',
    'Health Care',
    11.62,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VNT',
    'VONTIER CORP',
    'New York Stock Exchange Inc.',
    'Information Technology',
    31.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GLOB',
    'GLOBANT SA',
    'New York Stock Exchange Inc.',
    'Information Technology',
    117.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMG',
    'AFFILIATED MANAGERS GROUP INC',
    'New York Stock Exchange Inc.',
    'Financials',
    165.63,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DINO',
    'HF SINCLAIR CORP',
    'New York Stock Exchange Inc.',
    'Energy',
    30.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CE',
    'CELANESE CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    44.51,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AL',
    'AIR LEASE CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Industrials',
    46.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'APPF',
    'APPFOLIO INC CLASS A',
    'NASDAQ',
    'Information Technology',
    206.52,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LSTR',
    'LANDSTAR SYSTEM INC',
    'NASDAQ',
    'Industrials',
    134.15,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LEA',
    'LEAR CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    85.75,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FNB',
    'FNB CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    13.09,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DLB',
    'DOLBY LABORATORIES INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    76.79,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IONS',
    'IONIS PHARMACEUTICALS INC',
    'NASDAQ',
    'Health Care',
    30.71,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LYFT',
    'LYFT INC CLASS A',
    'NASDAQ',
    'Industrials',
    12.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'INSP',
    'INSPIRE MEDICAL SYSTEMS INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    158.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WSC',
    'WILLSCOT HOLDINGS CORP CLASS A',
    'NASDAQ',
    'Industrials',
    25.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BIO',
    'BIO RAD LABORATORIES INC CLASS A',
    'New York Stock Exchange Inc.',
    'Health Care',
    244.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CGNX',
    'COGNEX CORP',
    'NASDAQ',
    'Information Technology',
    27.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BILL',
    'BILL HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    45.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NOV',
    'NOV INC',
    'New York Stock Exchange Inc.',
    'Energy',
    11.61,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MTDR',
    'MATADOR RESOURCES',
    'New York Stock Exchange Inc.',
    'Energy',
    39.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COLB',
    'COLUMBIA BANKING SYSTEM INC',
    'NASDAQ',
    'Financials',
    22.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'H',
    'HYATT HOTELS CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    112.68,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MKSI',
    'MKS INSTRUMENTS INC',
    'NASDAQ',
    'Information Technology',
    70.14,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ELAN',
    'ELANCO ANIMAL HEALTH INC',
    'New York Stock Exchange Inc.',
    'Health Care',
    9.48,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ESI',
    'ELEMENT SOLUTIONS INC',
    'New York Stock Exchange Inc.',
    'Materials',
    20.41,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SIRI',
    'SIRIUSXM HOLDINGS INC',
    'NASDAQ',
    'Communication',
    21.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WTM',
    'WHITE MOUNTAINS INSURANCE GROUP LT',
    'New York Stock Exchange Inc.',
    'Financials',
    1767.45,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RHI',
    'ROBERT HALF',
    'New York Stock Exchange Inc.',
    'Industrials',
    44.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CUZ',
    'COUSINS PROPERTIES REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    27.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NXST',
    'NEXSTAR MEDIA GROUP INC',
    'NASDAQ',
    'Communication',
    149.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OZK',
    'BANK OZK',
    'NASDAQ',
    'Financials',
    42.6,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AN',
    'AUTONATION INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    174.15,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CCCS',
    'CCC INTELLIGENT SOLUTIONS HOLDINGS',
    'NASDAQ',
    'Information Technology',
    9.26,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VVV',
    'VALVOLINE INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    34.26,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GTES',
    'GATES INDUSTRIAL PLC',
    'New York Stock Exchange Inc.',
    'Industrials',
    18.92,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AGO',
    'ASSURED GUARANTY LTD',
    'New York Stock Exchange Inc.',
    'Financials',
    87.73,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SLGN',
    'SILGAN HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Materials',
    51.65,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BRKR',
    'BRUKER CORP',
    'NASDAQ',
    'Health Care',
    40.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LFUS',
    'LITTELFUSE INC',
    'NASDAQ',
    'Information Technology',
    182.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BYD',
    'BOYD GAMING CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    69.14,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EEFT',
    'EURONET WORLDWIDE INC',
    'NASDAQ',
    'Financials',
    99.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GAP',
    'GAP INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    21.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TKR',
    'TIMKEN',
    'New York Stock Exchange Inc.',
    'Industrials',
    64.25,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JHG',
    'JANUS HENDERSON GROUP PLC',
    'New York Stock Exchange Inc.',
    'Financials',
    33.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LAZ',
    'LAZARD INC',
    'New York Stock Exchange Inc.',
    'Financials',
    38.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SPR',
    'SPIRIT AEROSYSTEMS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Industrials',
    36.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GXO',
    'GXO LOGISTICS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    36.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PEGA',
    'PEGASYSTEMS INC',
    'NASDAQ',
    'Information Technology',
    92.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VFC',
    'VF CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    11.88,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NEU',
    'NEWMARKET CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    615.3,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FIVE',
    'FIVE BELOW INC',
    'NASDAQ',
    'Consumer Discretionary',
    75.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SON',
    'SONOCO PRODUCTS',
    'New York Stock Exchange Inc.',
    'Materials',
    41.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CLF',
    'CLEVELAND CLIFFS INC',
    'New York Stock Exchange Inc.',
    'Materials',
    8.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AVT',
    'AVNET INC',
    'NASDAQ',
    'Information Technology',
    46.99,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WHR',
    'WHIRLPOOL CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    76.28,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HXL',
    'HEXCEL CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    48.47,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LITE',
    'LUMENTUM HOLDINGS INC',
    'NASDAQ',
    'Information Technology',
    59.04,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TPG',
    'TPG INC CLASS A',
    'NASDAQ',
    'Financials',
    46.45,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SEE',
    'SEALED AIR CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    27.56,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'THO',
    'THOR INDUSTRIES INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    72.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BEPC',
    'BROOKFIELD RENEWABLE SUBORDINATE V',
    'New York Stock Exchange Inc.',
    'Utilities',
    28.46,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RYN',
    'RAYONIER REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    24.46,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PVH',
    'PVH CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    68.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KMPR',
    'KEMPER CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    59.12,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SNDK',
    'SANDISK CORP',
    'NASDAQ',
    'Information Technology',
    32.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MSGS',
    'MADISON SQUARE GARDEN SPORTS CORP',
    'New York Stock Exchange Inc.',
    'Communication',
    192.57,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NWS',
    'NEWS CORP CLASS B',
    'NASDAQ',
    'Communication',
    31.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'EPR',
    'EPR PROPERTIES REIT',
    'New York Stock Exchange Inc.',
    'Real Estate',
    49.49,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CHH',
    'CHOICE HOTELS INTERNATIONAL INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    126.11,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KRC',
    'KILROY REALTY REIT CORP',
    'New York Stock Exchange Inc.',
    'Real Estate',
    31.51,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MSM',
    'MSC INDUSTRIAL INC CLASS A',
    'New York Stock Exchange Inc.',
    'Industrials',
    76.48,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GFS',
    'GLOBALFOUNDRIES INC',
    'NASDAQ',
    'Information Technology',
    35.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MDU',
    'MDU RESOURCES GROUP INC',
    'New York Stock Exchange Inc.',
    'Utilities',
    17.14,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PRGO',
    'PERRIGO PLC',
    'New York Stock Exchange Inc.',
    'Health Care',
    25.72,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FRPT',
    'FRESHPET INC',
    'NASDAQ',
    'Consumer Staples',
    73.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BHF',
    'BRIGHTHOUSE FINANCIAL INC',
    'NASDAQ',
    'Financials',
    58.22,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OGN',
    'ORGANON',
    'New York Stock Exchange Inc.',
    'Health Care',
    12.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RARE',
    'ULTRAGENYX PHARMACEUTICAL INC',
    'NASDAQ',
    'Health Care',
    38.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LOAR',
    'LOAR HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    94.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LLYVK',
    'LIBERTY MEDIA LIBERTY LIVE CORP SE',
    'NASDAQ',
    'Communication',
    71.51,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VIRT',
    'VIRTU FINANCIAL INC CLASS A',
    'NASDAQ',
    'Financials',
    39.15,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ELF',
    'ELF BEAUTY INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    61.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ST',
    'SENSATA TECHNOLOGIES HOLDING PLC',
    'New York Stock Exchange Inc.',
    'Industrials',
    21.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMTM',
    'AMENTUM HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    21.82,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FLO',
    'FLOWERS FOODS INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    17.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MPW',
    'MEDICAL PROPERTIES TRUST REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    5.52,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MRP',
    'MILLROSE PROPERTIES INC CLASS A',
    'New York Stock Exchange Inc.',
    'Real Estate',
    25.04,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MP',
    'MP MATERIALS CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Materials',
    24.46,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ZG',
    'ZILLOW GROUP INC CLASS A',
    'NASDAQ',
    'Real Estate',
    65.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'M',
    'MACYS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    11.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HIW',
    'HIGHWOODS PROPERTIES REIT INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    28.44,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PSN',
    'PARSONS CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    66.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VKTX',
    'VIKING THERAPEUTICS INC',
    'NASDAQ',
    'Health Care',
    28.87,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WLK',
    'WESTLAKE CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    92.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMED',
    'AMEDISYS INC',
    'NASDAQ',
    'Health Care',
    94.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CACC',
    'CREDIT ACCEPTANCE CORP',
    'NASDAQ',
    'Financials',
    487.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ADT',
    'ADT INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    8.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WFRD',
    'WEATHERFORD INTERNATIONAL PLC',
    'NASDAQ',
    'Energy',
    41.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LINE',
    'LINEAGE INC',
    'NASDAQ',
    'Real Estate',
    48.23,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TNL',
    'TRAVEL LEISURE',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    43.93,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BC',
    'BRUNSWICK CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    46.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FHB',
    'FIRST HAWAIIAN INC',
    'NASDAQ',
    'Financials',
    22.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'W',
    'WAYFAIR INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    30.16,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SARO',
    'STANDARDAERO',
    'New York Stock Exchange Inc.',
    'Industrials',
    27.02,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'XRAY',
    'DENTSPLY SIRONA INC',
    'NASDAQ',
    'Health Care',
    13.9,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PAG',
    'PENSKE AUTOMOTIVE GROUP VOTING INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    155.67,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DXC',
    'DXC TECHNOLOGY',
    'New York Stock Exchange Inc.',
    'Information Technology',
    15.52,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ASH',
    'ASHLAND INC',
    'New York Stock Exchange Inc.',
    'Materials',
    54.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CIVI',
    'CIVITAS RESOURCES INC',
    'New York Stock Exchange Inc.',
    'Energy',
    27.25,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DNB',
    'DUN BRADST HLDG INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    8.97,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IRDM',
    'IRIDIUM COMMUNICATIONS INC',
    'NASDAQ',
    'Communication',
    24.13,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RH',
    'RH',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    184.03,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NVST',
    'ENVISTA HOLDINGS CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    16.08,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WU',
    'WESTERN UNION',
    'New York Stock Exchange Inc.',
    'Financials',
    9.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IAC',
    'IAC INC',
    'NASDAQ',
    'Communication',
    34.94,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NSA',
    'NATIONAL STORAGE AFFILIATES TRUST',
    'New York Stock Exchange Inc.',
    'Real Estate',
    37.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HOG',
    'HARLEY DAVIDSON INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    22.42,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'OLN',
    'OLIN CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    21.62,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LCID',
    'LUCID GROUP INC',
    'NASDAQ',
    'Consumer Discretionary',
    2.51,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'YETI',
    'YETI HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    28.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CWEN',
    'CLEARWAY ENERGY INC CLASS C',
    'New York Stock Exchange Inc.',
    'Utilities',
    29.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PENN',
    'PENN ENTERTAINMENT INC',
    'NASDAQ',
    'Consumer Discretionary',
    15.22,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ZI',
    'ZOOMINFO TECHNOLOGIES INC',
    'NASDAQ',
    'Communication',
    8.56,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ALGM',
    'ALLEGRO MICROSYSTEMS INC',
    'NASDAQ',
    'Information Technology',
    19.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CNXC',
    'CONCENTRIX CORP',
    'NASDAQ',
    'Industrials',
    51.06,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SAM',
    'BOSTON BEER INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    245.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'JWN',
    'NORDSTROM INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    24.14,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CXT',
    'CRANE NXT',
    'New York Stock Exchange Inc.',
    'Information Technology',
    46.92,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HUN',
    'HUNTSMAN CORP',
    'New York Stock Exchange Inc.',
    'Materials',
    13.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SMG',
    'SCOTTS MIRACLE GRO',
    'New York Stock Exchange Inc.',
    'Materials',
    50.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WEN',
    'WENDYS',
    'NASDAQ',
    'Consumer Discretionary',
    12.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HHH',
    'HOWARD HUGHES HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    66.53,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RNG',
    'RINGCENTRAL INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    25.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TDC',
    'TERADATA CORP',
    'New York Stock Exchange Inc.',
    'Information Technology',
    21.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COLM',
    'COLUMBIA SPORTSWEAR',
    'NASDAQ',
    'Consumer Discretionary',
    62.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PPC',
    'PILGRIMS PRIDE CORP',
    'NASDAQ',
    'Consumer Staples',
    54.58,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ACHC',
    'ACADIA HEALTHCARE COMPANY INC',
    'NASDAQ',
    'Health Care',
    23.4,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BOKF',
    'BOK FINANCIAL CORP',
    'NASDAQ',
    'Financials',
    93.17,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PINC',
    'PREMIER INC CLASS A',
    'NASDAQ',
    'Health Care',
    20.35,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ECG',
    'EVERUS CONSTRUCTION GROUP INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    40.24,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PK',
    'PARK HOTELS RESORTS INC',
    'New York Stock Exchange Inc.',
    'Real Estate',
    9.94,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'MAN',
    'MANPOWER INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    43.07,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BIRK',
    'BIRKENSTOCK HOLDING PLC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    51.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NWL',
    'NEWELL BRANDS INC',
    'NASDAQ',
    'Consumer Discretionary',
    4.78,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'APLS',
    'APELLIS PHARMACEUTICALS INC',
    'NASDAQ',
    'Health Care',
    19.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AAP',
    'ADVANCE AUTO PARTS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    32.72,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VAC',
    'MARRIOTT VACATIONS WORLDWIDE CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    54.81,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AMKR',
    'AMKOR TECHNOLOGY INC',
    'NASDAQ',
    'Information Technology',
    17.45,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'COTY',
    'COTY INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    5.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LBTYK',
    'LIBERTY GLOBAL LTD CLASS C',
    'NASDAQ',
    'Communication',
    11.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NCNO',
    'NCINO INC',
    'NASDAQ',
    'Information Technology',
    23.2,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ENOV',
    'ENOVIS CORP',
    'New York Stock Exchange Inc.',
    'Health Care',
    34.59,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'HAYW',
    'HAYWARD HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Industrials',
    13.33,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DJT',
    'TRUMP MEDIA TECHNOLOGY GROUP CORP',
    'NASDAQ',
    'Communication',
    24.54,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CC',
    'CHEMOURS',
    'New York Stock Exchange Inc.',
    'Materials',
    12.38,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DV',
    'DOUBLEVERIFY HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    13.26,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FIVN',
    'FIVE9 INC',
    'NASDAQ',
    'Information Technology',
    25.14,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LBTYA',
    'LIBERTY GLOBAL LTD CLASS A',
    'NASDAQ',
    'Communication',
    10.95,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'IPGP',
    'IPG PHOTONICS CORP',
    'NASDAQ',
    'Information Technology',
    59.89,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'RKT',
    'ROCKET COMPANIES INC CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    12.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CLVT',
    'CLARIVATE PLC',
    'New York Stock Exchange Inc.',
    'Industrials',
    4.31,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'QDEL',
    'QUIDELORTHO CORP',
    'NASDAQ',
    'Health Care',
    27.79,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SHC',
    'SOTERA HEALTH COMPANY',
    'NASDAQ',
    'Health Care',
    11.5,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CPRI',
    'CAPRI HOLDINGS LTD',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    15.04,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PII',
    'POLARIS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    33.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'BFA',
    'BROWN FORMAN CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    34.61,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FWONA',
    'LIBERTY MEDIA FORMULA ONE CORP SER',
    'NASDAQ',
    'Communication',
    80.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SPB',
    'SPECTRUM BRANDS HOLDINGS INC',
    'New York Stock Exchange Inc.',
    'Consumer Staples',
    63.1,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CAR',
    'AVIS BUDGET GROUP INC',
    'NASDAQ',
    'Industrials',
    92.63,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CERT',
    'CERTARA INC',
    'NASDAQ',
    'Health Care',
    13.86,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GO',
    'GROCERY OUTLET HOLDING CORP',
    'NASDAQ',
    'Consumer Staples',
    16.79,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'INFA',
    'INFORMATICA INC CLASS A',
    'New York Stock Exchange Inc.',
    'Information Technology',
    18.83,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LBRDA',
    'LIBERTY BROADBAND CORP SERIES A',
    'NASDAQ',
    'Communication',
    89.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AS',
    'AMER SPORTS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    24.25,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'QS',
    'QUANTUMSCAPE CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    3.91,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UI',
    'UBIQUITI INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    326.45,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LLYVA',
    'LIBERTY MEDIA LIBERTY LIVE CORP SE',
    'NASDAQ',
    'Communication',
    69.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LEG',
    'LEGGETT & PLATT INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    9.62,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TRIP',
    'TRIPADVISOR INC',
    'NASDAQ',
    'Communication',
    12.45,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'REYN',
    'REYNOLDS CONSUMER PRODUCTS INC',
    'NASDAQ',
    'Consumer Staples',
    23.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CRI',
    'CARTERS INC',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    33.05,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CNA',
    'CNA FINANCIAL CORP',
    'New York Stock Exchange Inc.',
    'Financials',
    48.16,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'LENB',
    'LENNAR CORP CLASS B',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    103.37,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UAA',
    'UNDER ARMOUR INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    5.72,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UA',
    'UNDER ARMOUR INC CLASS C',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    5.44,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'DDS',
    'DILLARDS INC CLASS A',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    346.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'AZTA',
    'AZENTA INC',
    'NASDAQ',
    'Health Care',
    26.34,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SNDR',
    'SCHNEIDER NATIONAL INC CLASS B',
    'New York Stock Exchange Inc.',
    'Industrials',
    21.49,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'GRAL',
    'GRAIL INC',
    'NASDAQ',
    'Health Care',
    34.49,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'CWENA',
    'CLEARWAY ENERGY INC CLASS A',
    'New York Stock Exchange Inc.',
    'Utilities',
    27.35,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'VSTS',
    'VESTIS CORP',
    'New York Stock Exchange Inc.',
    'Industrials',
    8.76,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TXG',
    '10X GENOMICS INC CLASS A',
    'NASDAQ',
    'Health Care',
    8.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'TFSL',
    'TFS FINANCIAL CORP',
    'NASDAQ',
    'Financials',
    12.96,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'KSS',
    'KOHLS CORP',
    'New York Stock Exchange Inc.',
    'Consumer Discretionary',
    6.7,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SFD',
    'SMITHFIELD FOODS INC',
    'NASDAQ',
    'Consumer Staples',
    22.21,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FTRE',
    'FORTREA HOLDINGS INC',
    'NASDAQ',
    'Health Care',
    6.23,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UHAL',
    'U HAUL HOLDING',
    'New York Stock Exchange Inc.',
    'Industrials',
    61.39,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SEB',
    'SEABOARD CORP',
    'Nyse Mkt Llc',
    'Consumer Staples',
    2585.98,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'WOLF',
    'WOLFSPEED INC',
    'New York Stock Exchange Inc.',
    'Information Technology',
    3.55,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ANGI',
    'ANGI INC CLASS A',
    'NASDAQ',
    'Communication',
    11.46,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'UWMC',
    'UWM HOLDINGS CORP CLASS A',
    'New York Stock Exchange Inc.',
    'Financials',
    4.7,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PLTK',
    'PLAYTIKA HOLDING CORP',
    'NASDAQ',
    'Communication',
    5.27,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'NFE',
    'NEW FORTRESS ENERGY INC CLASS A',
    'NASDAQ',
    'Energy',
    5.43,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'INGM',
    'INGRAM MICRO HOLDING CORP',
    'New York Stock Exchange Inc.',
    'Information Technology',
    17.78,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'PARAA',
    'PARAMOUNT GLOBAL CLASS A',
    'NASDAQ',
    'Communication',
    22.66,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'SEG',
    'SEAPORT ENTERTAINMENT GROUP INC',
    'Nyse Mkt Llc',
    'Real Estate',
    19.15,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    '--',
    'ESC GCI LIBERTY INC SR ESCROW',
    'NASDAQ',
    'Communication',
    0.0,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'FAM5',
    'S&P MID 400 EMINI JUN 25',
    'Index And Options Market',
    'Cash and/or Derivatives',
    2857.8,
    'USD'
);
INSERT INTO securities (symbol, name, exchange, sector, static_price, currency)
VALUES (
    'ESM5',
    'S&P500 EMINI JUN 25',
    'Index And Options Market',
    'Cash and/or Derivatives',
    5587.0,
    'USD'
);

CREATE TABLE if not exists `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `users` (`user_id`, `username`, `password`, `created_at`) VALUES (10,'user1','$2a$10$G8sJ289bzryjCnGUqvanN.j6eD6Bv6/05sImpAoJV9R8xPEm.0VtO','2025-05-05 21:39:54'),(11,'user2','$2a$10$Ajq2S8o7Y8T/PrBnn.QhMuHXJ4eNkwtqb3y0TCrVS63GYUI6lW/AW','2025-05-05 21:40:00'),(12,'user3','$2a$10$BkRR4eGNMWlO9/X4pSEGXOYkvg68grC4xIALRGSvbF0bwktASy3fa','2025-05-05 21:40:06');


CREATE TABLE if not exists `portfolios` (
  `portfolio_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`portfolio_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `portfolios_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `portfolios` (`portfolio_id`, `user_id`, `name`, `description`, `created_at`) VALUES (18,10,'Favorite stocks ','A collection of my favorite stocks','2025-05-05 17:40:49'),(19,10,'Extras','Extra stocks','2025-05-05 17:41:49'),(20,11,'Fun stocks','fun stockssssss','2025-05-05 17:42:26');

CREATE TABLE if not exists `portfolio_holdings` (
  `holding_id` int NOT NULL AUTO_INCREMENT,
  `portfolio_id` int NOT NULL,
  `security_id` int NOT NULL,
  `quantity` int NOT NULL,
  `average_purchase_price` decimal(10,2) NOT NULL,
  `last_updated` datetime DEFAULT CURRENT_TIMESTAMP,
  `current_value` decimal(10,2) NOT NULL,
  PRIMARY KEY (`holding_id`),
  UNIQUE KEY `unique_portfolio_security` (`portfolio_id`,`security_id`),
  KEY `security_id` (`security_id`),
  CONSTRAINT `portfolio_holdings_ibfk_1` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolios` (`portfolio_id`) ON DELETE CASCADE,
  CONSTRAINT `portfolio_holdings_ibfk_2` FOREIGN KEY (`security_id`) REFERENCES `securities` (`security_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `portfolio_holdings` (`holding_id`, `portfolio_id`, `security_id`, `quantity`, `average_purchase_price`, `last_updated`, `current_value`) VALUES (27,18,3,1,108.92,'2025-05-05 17:41:16',108.92),(28,18,14,1,1131.72,'2025-05-05 17:41:18',1131.72),(29,18,17,1,994.50,'2025-05-05 17:41:20',994.50),(30,18,24,1,72.55,'2025-05-05 17:41:25',72.55),(31,18,27,5,268.71,'2025-05-05 17:41:26',1343.55),(32,18,29,6,71.01,'2025-05-05 17:41:29',426.06),(33,19,84,1,89.12,'2025-05-05 17:41:57',89.12),(34,19,83,1,286.08,'2025-05-05 17:41:57',286.08),(35,19,82,5,294.37,'2025-05-05 17:41:58',1471.85),(36,19,86,5,225.47,'2025-05-05 17:41:59',1127.35),(37,20,153,6,3762.60,'2025-05-05 17:42:39',22575.60),(38,20,154,1,40.34,'2025-05-05 17:42:40',40.34),(39,20,158,1,271.09,'2025-05-05 17:42:41',271.09),(40,20,167,1,108.34,'2025-05-05 17:42:43',108.34);


CREATE TABLE if not exists `transactions` (
  `transaction_id` int NOT NULL AUTO_INCREMENT,
  `portfolio_id` int NOT NULL,
  `security_id` int NOT NULL,
  `transaction_type` enum('BUY','SELL') NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `transaction_date` datetime NOT NULL,
  `notes` text,
  PRIMARY KEY (`transaction_id`),
  KEY `portfolio_id` (`portfolio_id`),
  KEY `security_id` (`security_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`portfolio_id`) REFERENCES `portfolios` (`portfolio_id`) ON DELETE CASCADE,
  CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`security_id`) REFERENCES `securities` (`security_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `transactions` (`transaction_id`, `portfolio_id`, `security_id`, `transaction_type`, `quantity`, `price`, `transaction_date`, `notes`) VALUES (111,18,3,'BUY',1.00,108.92,'2025-05-05 17:41:16','Buy transaction'),(112,18,14,'BUY',1.00,1131.72,'2025-05-05 17:41:18','Buy transaction'),(113,18,17,'BUY',1.00,994.50,'2025-05-05 17:41:20','Buy transaction'),(114,18,24,'BUY',1.00,72.55,'2025-05-05 17:41:25','Buy transaction'),(115,18,27,'BUY',1.00,268.71,'2025-05-05 17:41:26','Buy transaction'),(116,18,27,'BUY',1.00,268.71,'2025-05-05 17:41:26','Buy transaction'),(117,18,27,'BUY',1.00,268.71,'2025-05-05 17:41:26','Buy transaction'),(118,18,27,'BUY',1.00,268.71,'2025-05-05 17:41:27','Buy transaction'),(119,18,27,'BUY',1.00,268.71,'2025-05-05 17:41:27','Buy transaction'),(120,18,29,'BUY',1.00,71.01,'2025-05-05 17:41:29','Buy transaction'),(121,18,29,'BUY',1.00,71.01,'2025-05-05 17:41:29','Buy transaction'),(122,18,29,'BUY',1.00,71.01,'2025-05-05 17:41:30','Buy transaction'),(123,18,29,'BUY',1.00,71.01,'2025-05-05 17:41:30','Buy transaction'),(124,18,29,'BUY',1.00,71.01,'2025-05-05 17:41:30','Buy transaction'),(125,18,29,'BUY',1.00,71.01,'2025-05-05 17:41:30','Buy transaction'),(126,19,84,'BUY',1.00,89.12,'2025-05-05 17:41:57','Buy transaction'),(127,19,83,'BUY',1.00,286.08,'2025-05-05 17:41:57','Buy transaction'),(128,19,82,'BUY',1.00,294.37,'2025-05-05 17:41:58','Buy transaction'),(129,19,82,'BUY',1.00,294.37,'2025-05-05 17:41:58','Buy transaction'),(130,19,82,'BUY',1.00,294.37,'2025-05-05 17:41:58','Buy transaction'),(131,19,82,'BUY',1.00,294.37,'2025-05-05 17:41:58','Buy transaction'),(132,19,82,'BUY',1.00,294.37,'2025-05-05 17:41:58','Buy transaction'),(133,19,86,'BUY',1.00,225.47,'2025-05-05 17:41:59','Buy transaction'),(134,19,86,'BUY',1.00,225.47,'2025-05-05 17:41:59','Buy transaction'),(135,19,86,'BUY',1.00,225.47,'2025-05-05 17:41:59','Buy transaction'),(136,19,86,'BUY',1.00,225.47,'2025-05-05 17:41:59','Buy transaction'),(137,19,86,'BUY',1.00,225.47,'2025-05-05 17:41:59','Buy transaction'),(138,20,153,'BUY',1.00,3762.60,'2025-05-05 17:42:39','Buy transaction'),(139,20,153,'BUY',1.00,3762.60,'2025-05-05 17:42:39','Buy transaction'),(140,20,153,'BUY',1.00,3762.60,'2025-05-05 17:42:39','Buy transaction'),(141,20,153,'BUY',1.00,3762.60,'2025-05-05 17:42:39','Buy transaction'),(142,20,153,'BUY',1.00,3762.60,'2025-05-05 17:42:39','Buy transaction'),(143,20,153,'BUY',1.00,3762.60,'2025-05-05 17:42:39','Buy transaction'),(144,20,154,'BUY',1.00,40.34,'2025-05-05 17:42:40','Buy transaction'),(145,20,158,'BUY',1.00,271.09,'2025-05-05 17:42:41','Buy transaction'),(146,20,167,'BUY',1.00,108.34,'2025-05-05 17:42:43','Buy transaction');

CREATE TABLE if not exists `watchlist` (
  `watchlist_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `security_id` int NOT NULL,
  `added_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `notes` varchar(255) DEFAULT NULL,
  `target_price` double DEFAULT NULL,
  PRIMARY KEY (`watchlist_id`),
  UNIQUE KEY `unique_user_security` (`user_id`,`security_id`),
  KEY `security_id` (`security_id`),
  CONSTRAINT `watchlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `watchlist_ibfk_2` FOREIGN KEY (`security_id`) REFERENCES `securities` (`security_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `watchlist` (`watchlist_id`, `user_id`, `security_id`, `added_at`, `notes`, `target_price`) VALUES (9,10,2,'2025-05-05 17:40:57',NULL,NULL),(10,10,1,'2025-05-05 17:40:58',NULL,NULL),(11,10,3,'2025-05-05 17:40:59',NULL,NULL),(12,10,4,'2025-05-05 17:40:59',NULL,NULL),(13,10,5,'2025-05-05 17:41:00',NULL,NULL),(14,11,1,'2025-05-05 17:42:29',NULL,NULL),(15,11,4,'2025-05-05 17:42:30',NULL,NULL),(16,11,9,'2025-05-05 17:42:32',NULL,NULL);