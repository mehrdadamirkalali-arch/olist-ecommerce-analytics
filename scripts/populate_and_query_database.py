import sqlite3
from pathlib import Path

import pandas as pd


BASE_DIR = Path(__file__).resolve().parents[1]
DATA_DIR = BASE_DIR / "data" / "processed"
DB_PATH = BASE_DIR / "olist_project.db"


def load_csv_to_database(csv_name, table_name, connection):
    """Load a CSV file into a SQLite database table."""
    csv_path = DATA_DIR / csv_name
    df = pd.read_csv(csv_path)
    df.to_sql(table_name, connection, if_exists="replace", index=False)
    print(f"Loaded {csv_name} into table {table_name}: {df.shape}")


def run_query(query, connection):
    """Run a SQL query and return the result as a pandas DataFrame."""
    return pd.read_sql_query(query, connection)


def main():
    connection = sqlite3.connect(DB_PATH)

    load_csv_to_database("customers_cleaned.csv", "customers", connection)
    load_csv_to_database("orders_cleaned.csv", "orders", connection)
    load_csv_to_database("payments_cleaned.csv", "payments", connection)
    load_csv_to_database("order_items_cleaned.csv", "order_items", connection)
    load_csv_to_database("products_cleaned.csv", "products", connection)

    load_csv_to_database("product_revenue.csv", "product_revenue", connection)
    load_csv_to_database("monthly_order_value.csv", "monthly_order_value", connection)
    load_csv_to_database("repeat_customers.csv", "repeat_customers", connection)

    query = """
    SELECT
        product_category_name,
        total_revenue,
        number_of_items_sold,
        average_item_price
    FROM product_revenue
    ORDER BY total_revenue DESC
    LIMIT 10;
    """

    result = run_query(query, connection)
    print("\nTop 10 product categories by revenue:")
    print(result)

    connection.close()
    print("\nDatabase created successfully:", DB_PATH)