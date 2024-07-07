-- Create a customers table if it doesn't already exist

/*
1. Connect to psql and database: psql -U Postgres -d sqlPractice
2. Execute file: \i scripts/create_tables/create_customers.sql
*/

CREATE TABLE IF NOT EXISTS customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);