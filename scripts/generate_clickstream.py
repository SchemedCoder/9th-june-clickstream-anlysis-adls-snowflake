import pandas as pd
import random
import uuid

from faker import Faker
from datetime import datetime, timedelta

fake = Faker()

NUM_EVENTS = 100000

countries = [
    "INDIA",
    "USA",
    "UK",
    "GERMANY",
    "CANADA",
    "AUSTRALIA"
]

devices = [
    "MOBILE",
    "DESKTOP",
    "TABLET"
]

products = [
    "P1001",
    "P1002",
    "P1003",
    "P1004",
    "P1005",
    "P1006",
    "P1007",
    "P1008",
    "P1009",
    "P1010"
]

pages = [
    "HOME",
    "SEARCH",
    "PRODUCT",
    "CART",
    "CHECKOUT"
]

events = []

start_time = datetime.now() - timedelta(days=30)

for _ in range(NUM_EVENTS):

    event_id = str(uuid.uuid4())

    user_id = f"U{random.randint(1000,9999)}"

    session_id = str(uuid.uuid4())

    device_type = random.choice(devices)

    country = random.choice(countries)

    product_id = random.choice(products)

    product_price = round(
        random.uniform(10,500),
        2
    )

    funnel_probability = random.random()

    if funnel_probability < 0.25:
        event_type = "HOME_PAGE"
        page = "HOME"

    elif funnel_probability < 0.45:
        event_type = "SEARCH"
        page = "SEARCH"

    elif funnel_probability < 0.70:
        event_type = "PRODUCT_VIEW"
        page = "PRODUCT"

    elif funnel_probability < 0.85:
        event_type = "ADD_TO_CART"
        page = "CART"

    elif funnel_probability < 0.95:
        event_type = "CHECKOUT"
        page = "CHECKOUT"

    else:
        event_type = "PURCHASE"
        page = "CHECKOUT"

    event_time = start_time + timedelta(
        minutes=random.randint(1,43200)
    )

    events.append([
        event_id,
        user_id,
        session_id,
        page,
        event_type,
        product_id,
        product_price,
        device_type,
        country,
        event_time
    ])

df = pd.DataFrame(
    events,
    columns=[
        "event_id",
        "user_id",
        "session_id",
        "page",
        "event_type",
        "product_id",
        "product_price",
        "device_type",
        "country",
        "event_time"
    ]
)

df.to_csv(
    "data/clickstream_events.csv",
    index=False
)

print(f"{len(df)} rows generated.")

