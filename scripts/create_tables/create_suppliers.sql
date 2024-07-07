

/*
For the supplier_id foreign key, need a suppliers table
*/

CREATE TABLE IF NOT EXISTS suppliers (
    supplier_id SERIAL PRIMARY KEY, -- Unique identifier for each supplier
    supplier_name VARCHAR(100) NOT NULL UNIQUE, -- Supplier must be unique and not null
    contact_email VARCHAR(100) UNIQUE -- Contact email must be unique
)