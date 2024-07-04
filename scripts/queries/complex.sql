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

-- Determine how frequently customers place orders by calculating the average number of days between orders
SELECT customers.name, AVG(orders.order_date - LAG(orders.order_date) OVER (PARTITION BY customers.id ORDER BY orders.order_date)) AS avg_days_between_orders
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name;

-- Calculate the month-over-month revenue growth rate
WITH monthly_revenue AS (
    SELECT DATE_TRUNC('month', order_date) AS month, SUM(amount) AS total_revenue
    FROM orders
    GROUP BY month
)
SELECT month, 
       total_revenue, 
       LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue,
       (total_revenue - LAG(total_revenue) OVER (ORDER BY month)) / LAG(total_revenue) OVER (ORDER BY month) * 100 AS growth_rate
FROM monthly_revenue
ORDER BY month;