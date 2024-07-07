-- Create an orders table if it doesn't already exist

/*
1. Connect to psql and database: psql -U Postgres -d sqlPractice
2. Execute file: \i scripts/create_tables/create_orders.sql
*/

CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);