import argparse
import logging
import sys

import pandas as pd

# Configure standard logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)
logger = logging.getLogger(__name__)

def validate_dataset(file_path: str) -> None:
    """
    Reads a CSV dataset and logs data quality metrics and distributions.
    """
    try:
        logger.info(f"Loading data from {file_path} for validation...")
        df = pd.read_csv(file_path)
    except FileNotFoundError:
        logger.error(f"File not found: {file_path}")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Error loading data: {str(e)}")
        sys.exit(1)

    logger.info("=" * 50)
    logger.info("Data Validation Report")
    logger.info("=" * 50)

    logger.info(f"Total Rows: {len(df)}")
    logger.info(f"Total Columns: {len(df.columns)}")

    logger.info("\n--- Null Counts ---")
    null_counts = df.isnull().sum()
    for col, count in null_counts.items():
        if count > 0:
            logger.warning(f"{col}: {count} nulls")
        else:
            logger.info(f"{col}: 0 nulls")

    logger.info("\n--- Duplicate Events ---")
    duplicates = df.duplicated(subset=["event_id"]).sum()
    if duplicates > 0:
        logger.warning(f"Duplicate Event IDs: {duplicates}")
    else:
        logger.info(f"Duplicate Event IDs: {duplicates}")

    logger.info("\n--- Event Distribution ---")
    event_dist = df["event_type"].value_counts().to_dict()
    for event, count in event_dist.items():
        logger.info(f"{event}: {count}")

    logger.info("\n--- Device Distribution ---")
    device_dist = df["device_type"].value_counts().to_dict()
    for device, count in device_dist.items():
        logger.info(f"{device}: {count}")

    logger.info("\n--- Price Statistics ---")
    price_stats = df["product_price"].describe().to_dict()
    for stat, val in price_stats.items():
        logger.info(f"{stat}: {val:.2f}")

    logger.info("\nValidation Complete")

def main():
    parser = argparse.ArgumentParser(description="Validate generated clickstream data.")
    parser.add_argument(
        "--file-path", 
        type=str, 
        default="data/clickstream_events.csv",
        help="Path to the CSV file to validate"
    )
    args = parser.parse_args()

    validate_dataset(args.file_path)

if __name__ == "__main__":
    main()
