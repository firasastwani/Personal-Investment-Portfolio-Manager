import pandas as pd

# Read the Excel file with selected columns
df = pd.read_excel('StockHoldingsDBM_selected_columns.xlsx')

# Create SQL file
with open('insert_securities.sql', 'w') as f:
    # Write the CREATE TABLE statement
    f.write("""CREATE TABLE IF NOT EXISTS securities (
    security_id INT AUTO_INCREMENT PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(100),
    exchange VARCHAR(50),
    sector VARCHAR(100),
    price DECIMAL(10, 2) NOT NULL,
    currency VARCHAR(10) DEFAULT 'USD'
);\n\n""")
    
    # Generate INSERT statements
    for index, row in df.iterrows():
        sql = f"""INSERT INTO securities (symbol, name, exchange, sector, price, currency)
VALUES (
    '{row['Ticker'].strip()}',
    '{row['Name'].strip().replace("'", "''")}',
    '{row['Exchange'].strip()}',
    '{row['Sector'].strip().replace("'", "''")}',
    {row['Price']},
    '{row['Currency'].strip()}'
);\n"""
        f.write(sql)

print("SQL insert statements have been generated in 'insert_securities.sql'")
print("\nFirst few lines preview:")
with open('insert_securities.sql', 'r') as f:
    print(''.join(f.readlines()[:10])) 