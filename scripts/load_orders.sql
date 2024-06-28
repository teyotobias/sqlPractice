CREATE TEMP TABLE temp_orders (
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE
);

-- Load data into the temporary table from CSV file using \copy command in psql
\copy temp_orders(customer_id, amount, order_date) FROM 'data/orders.csv' DELIMITER ',' CSV HEADER;

-- Insert data into orders table from temporary table
INSERT INTO orders (customer_id, amount, order_date)
SELECT customer_id, amount, order_date FROM temp_orders
WHERE NOT EXISTS (
    SELECT 1 FROM orders 
    WHERE orders.customer_id = temp_orders.customer_id
    AND orders.order_date = temp_orders.order_date
);

-- Drop the temporary table (optional)
DROP TABLE temp_orders;