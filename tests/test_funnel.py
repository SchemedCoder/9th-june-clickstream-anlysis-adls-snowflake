import pandas as pd

DATA_FILE = "data/clickstream_events.csv"


def test_purchase_less_than_total():

    df = pd.read_csv(DATA_FILE)

    purchases = len(
        df[df["event_type"] == "PURCHASE"]
    )

    total = len(df)

    assert purchases <= total


def test_checkout_vs_purchase():

    df = pd.read_csv(DATA_FILE)

    purchases = len(
        df[df["event_type"] == "PURCHASE"]
    )

    checkouts = len(
        df[df["event_type"] == "CHECKOUT"]
    )

    assert purchases <= checkouts


def test_product_views_exist():

    df = pd.read_csv(DATA_FILE)

    views = len(
        df[df["event_type"] == "PRODUCT_VIEW"]
    )

    assert views > 0


def test_add_to_cart_exists():

    df = pd.read_csv(DATA_FILE)

    carts = len(
        df[df["event_type"] == "ADD_TO_CART"]
    )

    assert carts > 0
