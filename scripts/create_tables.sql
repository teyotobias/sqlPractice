-- SERIAL, which means it will automatically generate a unique, sequential integer for each new row inserted into the table. 
-- The PRIMARY KEY constraint ensures that the id column is unique for each row and is used as the primary key for the table.

/*  if statements for duplicate entries */

CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);


CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    customer_id INT,
    amount DECIMAL(10,2),
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);