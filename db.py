import psycopg2
from dotenv import load_dotenv
import os
import logging

# Load environment variables
load_dotenv()

# Fetch environment variables
DATABASE_USER = os.getenv("POSTGRES_USER")
DATABASE_PASSWORD = os.getenv("POSTGRES_PASSWORD")
DATABASE_DB = os.getenv("POSTGRES_DB")
DATABASE_HOST = os.getenv("POSTGRES_HOST")
DATABASE_PORT = os.getenv("POSTGRES_PORT")

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Database connection function
def get_db_connection():
    """Establish a connection to the PostgreSQL database."""
    try:
        conn = psycopg2.connect(
            dbname=DATABASE_DB,
            user=DATABASE_USER,
            password=DATABASE_PASSWORD,
            host=DATABASE_HOST,
            port=DATABASE_PORT
        )
        logger.info(f"Connection to the database {DATABASE_DB} established successfully.")
        return conn
    except Exception as ex:
        logger.error(f"Connection error: {ex}")
        raise


def run_sql_script(filename: str, conn=None):
    if conn is None:
        conn = get_db_connection()
    try:
        # Open connection
        cur = conn.cursor()

        # Read the SQL script
        with open(filename, "r") as file:
            sql_script = file.read()

        # Execute the entire script
        cur.execute(sql_script)

        # Commit the transaction
        conn.commit()
        logging.info(f"Executed script: {filename}")

    except Exception as ex:
        logging.error(f"Error executing the script: {ex}")
        if conn:
            conn.rollback()

    finally:
        # Clean up
        if cur:
            cur.close()
        if conn:
            conn.close()


def create_stage_table(conn=None):
    if conn is None:
        conn = get_db_connection()
    cur = conn.cursor()
    with open("sourcedata/data.csv", "r") as f:
        next(f)
        cur.copy_expert("COPY staging_sales(invoiceNo, StockCode, Description, Quantity, InvoiceDate, UnitPrice, "
                        "CustomerID, Country) FROM STDIN WITH CSV", f)
        conn.commit()
        cur.close()
        conn.close()