/* Reminders about different constraints */

/* 
PRODUCTS TABLE:

1. PRODUCT ID: unique identifier for each product. The primary key
2. Product name
3. Category: the category of the product. Will demonstrate the 'check' constraint.
4. Price: will also have a 'CHECK' constraint to ensure its positive
5. Stock quantity: will have a 'DEFAULT' value
*/

CREATE TABLE IF NOT EXISTS products (
    product_id SERIAL PRIMARY KEY, -- Unique identifier for each product
    product_name VARCHAR(100) NOT NULL UNIQUE, -- Product name must be unique and not null
    category VARCHAR(50) NOT NULL, -- Category must be provided
    price DECIMAL(10,2) CHECK (price > 0), -- Price must be positive
    stock_quantity INT DEFAULT 0, -- Default stock quantity is 0
    supplier_id INT, -- Foreign key to suppliers table
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) -- Reference to suppliers id
);

/* ORDER: COLUMN NAME, DATA TYPE, CONSTRAINTS
    - SERIAL PRIMARY KEY: ensures each product has a unique identifier
    - SERIAL: Postgresql automatically creates a sequence object for it and sets up a default value to use the next value from that sequence.
            -The 'SERIAL' type automatically increments the value for each new row inserted into the table
    - NOT NULL: ensures fields cannot be empty
    - UNIQUE: ensures product names are unique across the table
    - Check: Ensures the price is a positive value
    - Default: sets the default stock quantity to 0 if not specified.
    - Foreign Key: references primary key in another table

*/