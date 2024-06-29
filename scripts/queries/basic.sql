                        /*  COMMENT OUT WHAT IS NOT NEEDED THEN RUN '\i queries/basic.sql  */
                        /* OR SIMPLY USE PSQL CLI: 1. psql -U postgres -d sql_practice   2. RUN any query from CL.*/
-- get all customers

SELECT *
FROM customers;

-- get names and emails of all customers
SELECT name, email
FROM customers;

-- get all orders

SELECT *
FROM orders;

-- find a customer by name
SELECT *
FROM orders
WHERE name = 'Teyo';

SELECT *
FROM orders
WHERE orders.customer_id = 8;

-- Combine information from the orders and customers tables where each order is matched to the corresponding customer based on the customer_id.
SELECT *
FROM orders
JOIN customers
ON orders.customer_id = customers.id;
-- Practical Use: This command helps in tracking a customer's purchasing behavior, handling order-related queries, or 
-- managing customer relationships.


-- Combine customer information with their corresponding orders to get a complete view of each order.
SELECT customers.name, orders.amount, orders.order_date
FROM customers
JOIN orders ON customers.id = orders.customer_id;
-- Practical Use: This command is useful for generating comprehensive reports that show both customer information and 
-- their order details, which is valuable for business analysis, marketing, and sales strategies.


-- Calculate total order amount per customer
SELECT customers.name, SUM(orders.amount) AS total_amount
FROM customers
JOIN orders
ON customers.id = orders.customer_id;
GROUP BY customers.name;
-- Practical Use: This command helps in identifying top customers by total spending, which is useful for 
-- loyalty programs, targeted marketing, and sales forecasting. 

-- identify customers who have not placed any orders.
SELECT * FROM customers
WHERE id NOT IN (
    SELECT customer_id FROM orders
);
-- Practical Use: This command is useful for identifying potential customers who might need engagement or 
-- promotional offers to convert them into active buyers.

-- update a customer's email

UPDATE customers
SET email = 'newemail@example.com'
WHERE name = 'example';
-- in case a user's email has changed.

-- Delete an order - specifying customer id and order date.
DELETE FROM orders
WHERE customer_id = 8 and order_date = 'yyyy/mm/dd';


-- Count the number of orders for each customer
SELECT customers.name, COUNT(orders.id) AS order_count
FROM customers
LEFT JOIN orders
ON customers.id = orders.customer_id;
GROUP BY customers.name;
-- Practical Use: This command helps in understanding customer engagement by counting their orders, which can inform 
-- customer relationship management strategies and help in segmenting customers based on activity levels.

-- Calculate the average order amount per customer:
SELECT customers.name, AVG(orders.amount) AS average_amount
FROM customers
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.name;

-- Find maximum order amount placed by each customer
SELECT customers.name, MAX(orders.amount) AS max_amount
FROM customers
JOIN orders on customers.id = orders.customer_id
GROUP BY customers.name;

-- Find orders above a threshold amount ($150 as an example)
SELECT *
FROM orders
WHERE amount > 150.00;

-- Find customers with email addresses from a specific domain
SELECT *
FROM customers
WHERE name LIKE '%@gmai.com';

-- Get all orders placed in the last 30 days
SELECT *
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 days';

-- Get the total order amount for each month
SELECT DATE_TRUNC('month', order_date) AS month, SUM(amount) AS total_amount
FROM orders
GROUP BY month
ORDER BY month;