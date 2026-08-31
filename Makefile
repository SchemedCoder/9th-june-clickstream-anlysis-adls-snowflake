.PHONY: help install generate validate upload test clean

# Variables
PYTHON := python
PIP := pip
DATA_DIR := data
CSV_FILE := $(DATA_DIR)/clickstream_events.csv

help:
	@echo "Available commands:"
	@echo "  make install    - Install Python dependencies"
	@echo "  make generate   - Generate mock clickstream data"
	@echo "  make validate   - Validate the generated data"
	@echo "  make upload     - Upload the data to ADLS Gen2"
	@echo "  make test       - Run unit tests with pytest"
	@echo "  make clean      - Remove generated data and python cache"

install:
	$(PIP) install -r requirements.txt

generate:
	@mkdir -p $(DATA_DIR)
	$(PYTHON) scripts/generate_clickstream.py --output-path $(CSV_FILE)

validate:
	$(PYTHON) scripts/validate_data.py --file-path $(CSV_FILE)

upload:
	$(PYTHON) scripts/upload_to_adls.py --local-file $(CSV_FILE)

test:
	pytest tests/ -v

clean:
	rm -rf $(DATA_DIR)/*.csv
	find . -type d -name "__pycache__" -exec rm -r {} +
	find . -type f -name "*.pyc" -delete
