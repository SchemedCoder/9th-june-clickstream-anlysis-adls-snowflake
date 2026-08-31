import pandas as pd

DATA_FILE = "data/clickstream_events.csv"


def test_file_exists():

    df = pd.read_csv(DATA_FILE)

    assert len(df) > 0


def test_no_null_event_id():

    df = pd.read_csv(DATA_FILE)

    assert df["event_id"].isnull().sum() == 0


def test_no_null_user_id():

    df = pd.read_csv(DATA_FILE)

    assert df["user_id"].isnull().sum() == 0


def test_unique_event_id():

    df = pd.read_csv(DATA_FILE)

    duplicates = df["event_id"].duplicated().sum()

    assert duplicates == 0


def test_positive_product_price():

    df = pd.read_csv(DATA_FILE)

    assert (df["product_price"] > 0).all()


def test_valid_device_type():

    df = pd.read_csv(DATA_FILE)

    allowed = [
        "MOBILE",
        "DESKTOP",
        "TABLET"
    ]

    assert df["device_type"].isin(allowed).all()


def test_valid_event_type():

    df = pd.read_csv(DATA_FILE)

    allowed = [
        "HOME_PAGE",
        "SEARCH",
        "PRODUCT_VIEW",
        "ADD_TO_CART",
        "CHECKOUT",
        "PURCHASE"
    ]

    assert df["event_type"].isin(allowed).all()

