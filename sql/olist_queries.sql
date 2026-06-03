-- Queries.sql
-- SQL queries for the Olist e-commerce database project

-- Query 1: Projection + selection
-- Show selected columns for delivered orders.

SELECT
    order_id,
    customer_id,
    order_purchase_timestamp,
    order_status
FROM orders
WHERE order_status = 'delivered'
LIMIT 20;


-- Query 2: Aggregation
-- Count the number of orders by order status.

SELECT
    order_status,
    COUNT(*) AS number_of_orders
FROM orders
GROUP BY order_status
ORDER BY number_of_orders DESC;


-- Query 3: Aggregation with selection
-- Count delivered orders by purchase year and month.

SELECT
    purchase_year,
    purchase_month,
    COUNT(*) AS number_of_delivered_orders
FROM orders
WHERE order_status = 'delivered'
GROUP BY purchase_year, purchase_month
ORDER BY purchase_year, purchase_month;


-- Query 4: Join between orders and customers
-- Show delivered orders with customer location.

SELECT
    o.order_id,
    o.order_purchase_timestamp,
    c.customer_city,
    c.customer_state
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
LIMIT 20;


-- Query 5: Join + aggregation
-- Calculate total payment value by order status.

SELECT
    o.order_status,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    ROUND(SUM(p.payment_value), 2) AS total_payment_value
FROM orders AS o
JOIN payments AS p
    ON o.order_id = p.order_id
GROUP BY o.order_status
ORDER BY total_payment_value DESC;


-- Query 6: Join + aggregation
-- Calculate revenue by product category for delivered orders.

SELECT
    pr.product_category_name,
    COUNT(oi.order_item_id) AS number_of_items_sold,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    ROUND(AVG(oi.price), 2) AS average_item_price
FROM orders AS o
JOIN order_items AS oi
    ON o.order_id = oi.order_id
JOIN products AS pr
    ON oi.product_id = pr.product_id
WHERE o.order_status = 'delivered'
GROUP BY pr.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;


-- Query 7: Join + aggregation
-- Calculate average payment value by payment type.

SELECT
    p.payment_type,
    COUNT(*) AS number_of_payment_records,
    ROUND(SUM(p.payment_value), 2) AS total_payment_value,
    ROUND(AVG(p.payment_value), 2) AS average_payment_value
FROM payments AS p
GROUP BY p.payment_type
ORDER BY total_payment_value DESC;


-- Query 8: Customer behavior
-- Identify repeat customers using customer_unique_id.

SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS number_of_orders
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY number_of_orders DESC
LIMIT 20;


-- Query 9: Customer retention summary
-- Count one-time and repeat customers.

WITH customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS number_of_orders
    FROM orders AS o
    JOIN customers AS c
        ON o.customer_id = c.customer_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    CASE
        WHEN number_of_orders > 1 THEN 'Repeat Customer'
        ELSE 'One-time Customer'
    END AS customer_type,
    COUNT(*) AS number_of_customers
FROM customer_orders
GROUP BY customer_type
ORDER BY number_of_customers DESC;


-- Query 10: Monthly average order value
-- Calculate average payment value by month for delivered orders.

SELECT
    o.purchase_year,
    o.purchase_month,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    ROUND(AVG(order_payment.total_payment_value), 2) AS average_order_value
FROM orders AS o
JOIN (
    SELECT
        order_id,
        SUM(payment_value) AS total_payment_value
    FROM payments
    GROUP BY order_id
) AS order_payment
    ON o.order_id = order_payment.order_id
WHERE o.order_status = 'delivered'
GROUP BY o.purchase_year, o.purchase_month
ORDER BY o.purchase_year, o.purchase_month;





