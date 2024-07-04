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


-- Common Table Expressions (CTEs)

WITH LastOrder AS (
    SELECT customer_id, MAX(order_date) AS last_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT customers.name, LastOrder.last_order_date
FROM customers
JOIN LastOrder ON customer.id = LastOrder.customer_id;


-- Top N Customers by Total Spending

WITH TotalSpending AS (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT customers.name, TotalSpending.total_spent
FROM customers
JOIN TotalSpending ON customers.id = TotalSpending.customer_id
ORDER BY TotalSpending.total_spent DESC
LIMIT 5;


/*
What does LAG do?
LAG is used to access daa from a previous row in the same result set without using a self-join.
It is particularly useful for comparing values between rows and is commonly used in time
series analysis, financial calculations, and trend analysis.

LAG (scalar_expression [,offset] [,default]) OVER ([PARTITION BY partition_expression] ORDER BY order_expression)
1. scalar_expression: The value to be returned from a previous row.
2. offset (optional): The number of rows back 
3. default (optional): The value to return if the offset goes beyond the result set. The default is 'NULL'.

Usage: The 'LAG' function is used within the 'OVER' clause, which defines the window (set of rows) over which the function operates.

Basic Usage: to compare each row's value with the previou row's value
SELECT order_date, amount, LAG(amount) OVER (ORDER BY order_date) AS previous_amount
FROM orders;

The above query returns the order date, the current amount, and the amount from the previous row.
If there is no previous row, it returns 0.
*/

-- Monthly Revenue Growth Rate
WITH MonthlyRevenue AS (
    SELECT Date_TRUNC('month', order_date) AS month, SUM(amount) AS total_revenue
    FROM orders
    GROUP BY month
),
RevenueGrowth AS (
    SELECT month, total_revenue, 
    LAG(total_revenue) OVER (ORDER BY month) AS previous_month_revenue,
    (total_revenue - LAG(total_revenue) OVER (ORDER by month)) / LAG(total_revenue) OVER (ORDER BY month) * 100 AS growth_rate
FROM MonthlyRevenue
)
SELECT month, total_revenue, growth_rate
FROM RevenueGrowth
ORDER BY month;