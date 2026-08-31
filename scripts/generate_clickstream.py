import argparse
import logging
import random
import uuid
from datetime import datetime, timedelta
from typing import List, Tuple, Any

import pandas as pd
from faker import Faker

# Configure standard logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)
logger = logging.getLogger(__name__)

fake = Faker()

COUNTRIES = ["INDIA", "USA", "UK", "GERMANY", "CANADA", "AUSTRALIA"]
DEVICES = ["MOBILE", "DESKTOP", "TABLET"]
PRODUCTS = [f"P100{i}" for i in range(1, 10)] + ["P1010"]

def generate_events(num_events: int) -> pd.DataFrame:
    """
    Generates mock clickstream events.
    """
    logger.info(f"Generating {num_events} clickstream events...")
    events: List[Tuple[Any, ...]] = []
    start_time = datetime.now() - timedelta(days=30)

    for _ in range(num_events):
        event_id = str(uuid.uuid4())
        user_id = f"U{random.randint(1000, 9999)}"
        session_id = str(uuid.uuid4())
        device_type = random.choice(DEVICES)
        country = random.choice(COUNTRIES)
        product_id = random.choice(PRODUCTS)
        product_price = round(random.uniform(10, 500), 2)

        funnel_probability = random.random()
        if funnel_probability < 0.25:
            event_type, page = "HOME_PAGE", "HOME"
        elif funnel_probability < 0.45:
            event_type, page = "SEARCH", "SEARCH"
        elif funnel_probability < 0.70:
            event_type, page = "PRODUCT_VIEW", "PRODUCT"
        elif funnel_probability < 0.85:
            event_type, page = "ADD_TO_CART", "CART"
        elif funnel_probability < 0.95:
            event_type, page = "CHECKOUT", "CHECKOUT"
        else:
            event_type, page = "PURCHASE", "CHECKOUT"

        event_time = start_time + timedelta(minutes=random.randint(1, 43200))
        
        events.append((
            event_id, user_id, session_id, page, event_type, 
            product_id, product_price, device_type, country, event_time
        ))

    columns = [
        "event_id", "user_id", "session_id", "page", "event_type",
        "product_id", "product_price", "device_type", "country", "event_time"
    ]
    
    return pd.DataFrame(events, columns=columns)

def main():
    parser = argparse.ArgumentParser(description="Generate mock clickstream data.")
    parser.add_argument(
        "--num-events", 
        type=int, 
        default=100000,
        help="Number of events to generate"
    )
    parser.add_argument(
        "--output-path", 
        type=str, 
        default="data/clickstream_events.csv",
        help="Path to save the generated CSV"
    )
    args = parser.parse_args()

    df = generate_events(args.num_events)
    
    logger.info(f"Saving generated data to {args.output_path}...")
    df.to_csv(args.output_path, index=False)
    logger.info(f"Successfully generated and saved {len(df)} rows.")

if __name__ == "__main__":
    main()
