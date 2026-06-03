# Olist E-Commerce Analytics Project

This project analyzes the Brazilian Olist e-commerce dataset using Python and SQL.

The goal is to build an end-to-end data analytics workflow: starting from raw CSV files, cleaning and preparing the data in Python, analyzing sales and customer behavior, creating visualizations, adding a small statistical and machine learning bonus, and designing SQL queries for business insights.

## Project Overview

The project focuses on:

* delivered e-commerce orders
* product category revenue
* average order value over time
* payment behavior
* repeat customer behavior
* basic statistical analysis with SciPy
* a simple machine learning baseline
* SQL database schema and analytical queries

## Dataset

This project uses the Brazilian E-Commerce Public Dataset by Olist.

Dataset source: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

The raw CSV files are not included in this repository. To run the project, download the dataset from Kaggle and place the following files inside `data/raw/`:

* `olist_customers_dataset.csv`
* `olist_orders_dataset.csv`
* `olist_order_items_dataset.csv`
* `olist_products_dataset.csv`
* `olist_order_payments_dataset.csv`

## Project Structure

olist-ecommerce-analytics/
│
├── README.md
├── requirements.txt
├── .gitignore
│
├── data/
│   ├── raw/
│   │   └── .gitkeep
│   └── processed/
│       └── .gitkeep
│
├── notebooks/
│   └── ecommerce_analysis.ipynb
│
├── sql/
│   ├── olist_schema.sql
│   └── olist_queries.sql
│
└── scripts/
    └── populate_and_query_database.py
```

## Python Analysis

The notebook includes:

* loading multiple CSV files
* checking data structure, missing values, and duplicates
* filtering delivered orders
* converting date columns to datetime format
* extracting purchase year and purchase month
* aggregating payments at the order level
* merging customers, orders, products, order items, and payments
* analyzing product revenue, payment behavior, and repeat customer behavior
* creating visualizations with matplotlib and seaborn

The main notebook is:

notebooks/ecommerce_analysis.ipynb


## Data Cleaning Workflow

The cleaning process includes:

1. Loading the raw CSV files.
2. Checking missing values, duplicated rows, data types, and order status distribution.
3. Filtering the orders dataset to keep only delivered orders.
4. Converting date columns to datetime format.
5. Creating `purchase_year` and `purchase_month` features.
6. Aggregating payment information at the order level.
7. Merging orders, customers, and payment summary data.
8. Creating a payment-complete dataset for payment-related analysis.
9. Saving processed datasets in `data/processed/`.

Payment aggregation was an important step because one order can have more than one payment record. Aggregating payments before merging prevents duplicated order rows in the final analytical dataset.

## Exploratory Analysis and Visualizations

The project includes visual analysis of:

* top product categories by total revenue
* average order value over time
* number of delivered orders over time
* order value categories
* distribution of total payment value
* relationship between payment value and payment records
* one-time customers versus repeat customers

## Statistical Bonus

The project includes a small SciPy statistical analysis:

* Pearson correlation between total payment value and average installments
* 95% confidence interval for average order value

The Pearson correlation showed a positive but moderate relationship between total payment value and average installments. This suggests that higher-value orders tend to have more installments, although the relationship is not very strong.

The confidence interval was used to estimate the average order value with uncertainty.

## Machine Learning Bonus

A simple Logistic Regression model is included as an educational baseline.

The model predicts whether an order is high-value or not using:

* number of payment records
* average installments
* purchase month

The target variable is:

0 = low or medium value order
1 = high-value order


The model achieved about 72% accuracy, but recall for high-value orders was low. For this reason, the model is interpreted as a simple baseline rather than a final predictive model.

A stronger model could include additional features such as:

* product category
* customer location
* number of items
* freight value
* delivery information

## SQL Component

The SQL part includes:

* relational schema design
* table creation scripts
* projection and selection queries
* aggregation queries
* joins between orders, customers, products, payments, and order items
* product revenue analysis
* payment behavior analysis
* repeat customer analysis
* monthly average order value analysis

SQL files:


sql/olist_schema.sql
sql/olist_queries.sql


## Python Database Loader

The script below loads processed CSV files into a SQLite database and runs an example SQL query:

scripts/populate_and_query_database.py

This connects the Python data preparation workflow with the SQL database component.

## Main Insights

The main findings are:

* revenue is concentrated in a limited number of product categories
* average order value changes over time
* order volume and average order value should be interpreted together
* most orders are low or medium value
* repeat customers represent only a small percentage of the customer base
* payment behavior contains some information for predicting high-value orders, but more features would be needed for a stronger model

## Tools Used

* Python
* pandas
* matplotlib
* seaborn
* SciPy
* scikit-learn
* SQL
* SQLite
* Jupyter Notebook

## How to Run the Project

1. Clone this repository.

git clone <repository-url>
cd olist-ecommerce-analytics

2. Install the required Python packages.

pip install -r requirements.txt

3. Download the Olist dataset from Kaggle.

Dataset source:

https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

4. Place the required CSV files inside:

data/raw/

Required files:

olist_customers_dataset.csv
olist_orders_dataset.csv
olist_order_items_dataset.csv
olist_products_dataset.csv
olist_order_payments_dataset.csv

5. Open and run the notebook:

notebooks/ecommerce_analysis.ipynb

6. The notebook will generate processed datasets inside:

data/processed/

7. To run the Python database loader:

python scripts/populate_and_query_database.py

## Notes

The raw dataset files are not included in this repository. They should be downloaded directly from Kaggle.

The processed datasets are generated by the notebook and are also excluded from the repository to keep the project lightweight and reproducible.

## Future Improvements

Possible future improvements include:

* adding more features to the machine learning model
* improving high-value order prediction recall
* analyzing delivery delays
* including customer location patterns
* comparing SQL query results with Python aggregation outputs
* creating a dashboard for business insights
