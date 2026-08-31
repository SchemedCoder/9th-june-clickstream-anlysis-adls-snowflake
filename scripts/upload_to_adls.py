import argparse
import logging
import os
import sys

from azure.core.exceptions import AzureError
from azure.storage.filedatalake import DataLakeServiceClient
from dotenv import load_dotenv

# Configure standard logging
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
    datefmt="%Y-%m-%d %H:%M:%S"
)
logger = logging.getLogger(__name__)

def upload_file_to_adls(
    local_file_path: str, 
    remote_file_name: str, 
    file_system: str
) -> None:
    """
    Uploads a local file to Azure Data Lake Storage Gen2.
    """
    # Load credentials from .env
    load_dotenv()
    account_name = os.getenv("ADLS_ACCOUNT_NAME")
    account_key = os.getenv("ADLS_ACCOUNT_KEY")

    if not account_name or not account_key:
        logger.error("ADLS_ACCOUNT_NAME and ADLS_ACCOUNT_KEY must be set in .env")
        sys.exit(1)

    account_url = f"https://{account_name}.dfs.core.windows.net"

    try:
        logger.info(f"Connecting to ADLS account: {account_name}...")
        service_client = DataLakeServiceClient(
            account_url=account_url,
            credential=account_key
        )
        
        filesystem_client = service_client.get_file_system_client(file_system)
        file_client = filesystem_client.get_file_client(remote_file_name)

        logger.info(f"Reading local file {local_file_path}...")
        with open(local_file_path, "rb") as f:
            data = f.read()
            
        logger.info(f"Uploading to {file_system}/{remote_file_name}...")
        file_client.upload_data(data, overwrite=True)
        
        logger.info("Upload completed successfully.")
        
    except FileNotFoundError:
        logger.error(f"Local file not found: {local_file_path}")
        sys.exit(1)
    except AzureError as e:
        logger.error(f"Azure Storage error occurred: {str(e)}")
        sys.exit(1)
    except Exception as e:
        logger.error(f"An unexpected error occurred: {str(e)}")
        sys.exit(1)

def main():
    parser = argparse.ArgumentParser(description="Upload files to ADLS Gen2.")
    parser.add_argument(
        "--local-file", 
        type=str, 
        default="data/clickstream_events.csv",
        help="Path to the local file to upload"
    )
    parser.add_argument(
        "--remote-file", 
        type=str, 
        default="clickstream_events.csv",
        help="Name of the file in ADLS"
    )
    parser.add_argument(
        "--filesystem", 
        type=str, 
        default="clickstream",
        help="ADLS file system (container) name"
    )
    args = parser.parse_args()

    upload_file_to_adls(
        local_file_path=args.local_file,
        remote_file_name=args.remote_file,
        file_system=args.filesystem
    )

if __name__ == "__main__":
    main()
