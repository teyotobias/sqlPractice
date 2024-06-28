
-- Create a temporary table
CREATE TEMP TABLE temp_customers (
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Load data into the temporary table from CSV file using \copy command in psql
\copy temp_customers(name, email) FROM 'data/customers.csv' DELIMITER ',' CSV HEADER;

-- Insert data from the temporary table into the customers table
INSERT INTO customers (name, email)
SELECT name, email FROM temp_customers
WHERE NOT EXISTS (
    SELECT 1 FROM customers
    WHERE customers.email = temp_customers.email
);

-- Drop the temporary table (optional)
DROP TABLE temp_customers;