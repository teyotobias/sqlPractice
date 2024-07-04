-- find each customer's last order date
SELECT customers.name, MAX(orders.order_date) AS last_order_date
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name;

-- find total number of orders and total amount spent per customer
SELECT customers.name AS name, SUM(orders.amount), COUNT(orders.id)
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name

-- find customers with orders in a specific date range (90 days in this use)
SELECT DISTINCT customers.name
FROM customers
JOIN orders on customers.id = orders.customer_id
WHERE orders.order_date BETWEEN CURRENT_DATE - INTERVAL '90 days' AND CURRENT_DATE;

-- find the top N customers by total spending (top 5 customers)
SELECT customers.name, SUM(orders.amount) AS total_spent
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name
ORDER BY total_spent DESC
LIMIT 5;

-- average order value by month
SELECT DATE_TRUNC('month', order_date) AS month, AVG(amount) AS average_order_value
FROM orders
GROUP BY month
ORDER BY month

