import pandas as pd

# Read the Excel file, skipping the first few rows
df = pd.read_excel('StockHoldingsDBM.xlsx', skiprows=6)

# The first row contains the actual column names, so we'll set it as the header
df.columns = df.iloc[0]
df = df.drop(df.index[0])

# Select the columns we want
selected_columns = ['Ticker', 'Name', 'Sector', 'Price', 'Exchange', 'Currency']
df_selected = df[selected_columns]

# Reset the index
df_selected = df_selected.reset_index(drop=True)

# Save to a new Excel file
df_selected.to_excel('StockHoldingsDBM_selected_columns.xlsx', index=False)
print("New file has been created: StockHoldingsDBM_selected_columns.xlsx")
print("\nFirst few rows of the extracted data:")
print(df_selected.head())
