import pandas as pd

FILE_PATH = "data/clickstream_events.csv"

df = pd.read_csv(FILE_PATH)

print("\nData Validation Report")
print("=" * 50)

print(
    f"Total Rows: {len(df)}"
)

print(
    f"Total Columns: {len(df.columns)}"
)

print("\nNull Counts")

print(
    df.isnull().sum()
)

print("\nDuplicate Events")

duplicates = df.duplicated(
    subset=["event_id"]
).sum()

print(
    f"Duplicate Event IDs: {duplicates}"
)

print("\nEvent Distribution")

print(
    df["event_type"]
    .value_counts()
)

print("\nDevice Distribution")

print(
    df["device_type"]
    .value_counts()
)

print("\nCountry Distribution")

print(
    df["country"]
    .value_counts()
)

print("\nPrice Statistics")

print(
    df["product_price"]
    .describe()
)

print("\nValidation Complete")
