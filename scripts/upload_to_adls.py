import os

from azure.storage.filedatalake import DataLakeServiceClient
from dotenv import load_dotenv

load_dotenv()

ACCOUNT_NAME = os.getenv("ADLS_ACCOUNT_NAME")
ACCOUNT_KEY = os.getenv("ADLS_ACCOUNT_KEY")

FILE_SYSTEM = "clickstream"

LOCAL_FILE = "data/clickstream_events.csv"

REMOTE_FILE = "clickstream_events.csv"

account_url = f"https://{ACCOUNT_NAME}.dfs.core.windows.net"

service_client = DataLakeServiceClient(
    account_url=account_url,
    credential=ACCOUNT_KEY
)

filesystem_client = service_client.get_file_system_client(
    FILE_SYSTEM
)

file_client = filesystem_client.get_file_client(
    REMOTE_FILE
)

with open(LOCAL_FILE, "rb") as f:

    data = f.read()

    file_client.upload_data(
        data,
        overwrite=True
    )

print(
    f"Uploaded {LOCAL_FILE} to ADLS Gen2"
)

