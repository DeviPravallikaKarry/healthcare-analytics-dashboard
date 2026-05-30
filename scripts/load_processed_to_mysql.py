"""
Load processed hospital analytics CSV files into MySQL.

This script reads files from:
    data/processed/

Files named like:
    processed_patient.csv
    processed_admission.csv

will be loaded into MySQL as:
    patient
    admission

The script asks for the MySQL password at runtime so the password is not saved
inside the project files.
"""

from getpass import getpass
from pathlib import Path

import pandas as pd
from sqlalchemy import create_engine, text


PROJECT_ROOT = Path(__file__).resolve().parents[1]
PROCESSED_DATA_PATH = PROJECT_ROOT / "data" / "processed"

MYSQL_HOST = "localhost"
MYSQL_PORT = 3306
MYSQL_USER = "root"
MYSQL_DATABASE = "hospital_analytics"


def create_mysql_engine(password: str):
    """Create a SQLAlchemy engine for MySQL."""
    connection_url = (
        f"mysql+pymysql://{MYSQL_USER}:{password}"
        f"@{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DATABASE}"
    )
    return create_engine(connection_url)


def load_csv_files_to_mysql():
    """Load all processed CSV files into the MySQL database."""
    csv_files = sorted(PROCESSED_DATA_PATH.glob("processed_*.csv"))

    if not csv_files:
        raise FileNotFoundError(
            f"No processed CSV files found in: {PROCESSED_DATA_PATH}"
        )

    print("MySQL CSV Import")
    print("-" * 40)
    print(f"Project root: {PROJECT_ROOT}")
    print(f"Processed data path: {PROCESSED_DATA_PATH}")
    print(f"CSV files found: {len(csv_files)}")
    print(f"MySQL database: {MYSQL_DATABASE}")
    print()

    password = getpass("Enter your MySQL password for user root: ")
    engine = create_mysql_engine(password)

    with engine.begin() as connection:
        connection.execute(text(f"CREATE DATABASE IF NOT EXISTS {MYSQL_DATABASE}"))
        connection.execute(text(f"USE {MYSQL_DATABASE}"))

    for csv_file in csv_files:
        table_name = csv_file.stem.replace("processed_", "")
        print(f"Loading {csv_file.name} -> {table_name}")

        df = pd.read_csv(csv_file)

        df.to_sql(
            name=table_name,
            con=engine,
            if_exists="replace",
            index=False,
            chunksize=5000,
        )

        print(f"  Loaded {len(df):,} rows")

    print()
    print("Import completed successfully.")
    print("You can now open MySQL Workbench and refresh the hospital_analytics schema.")


if __name__ == "__main__":
    load_csv_files_to_mysql()

