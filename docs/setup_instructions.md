# Setup Instructions

## Installing a Local SQL Database

### 1. Install PostgreSQL
Windows/Mac/Linux: Visit the PostgreSQL Download page and follow the instructions to download and install PostgreSQL for your operating system.

### 2. Initialize and Start PostgreSQL
Windows: Open the PostgreSQL installer and follow the steps to initialize and start the PostgreSQL server.
Mac/Linux: Open a terminal and start PostgreSQL:
sudo service postgresql start

### 3. Create a New Database
Open the PostgreSQL command-line interface (psql): psql -U postgres
Create a new database named sql_practice: CREATE DATABASE sql_practice;

### 4. Import Sample Data
In the terminal, navigate to your repository directory: cd path/to/your/repository
Import the sample_data.sql file into your sql_practice database: psql -U postgres -d sql_practice -f data/sample_data.sql

### 5. Connect to the Database
Open psql and connect to the sql_practice database: psql -U postgres -d sql_practice

### 6. Run SQL Scripts
You can now run SQL commands directly in the psql interface or execute SQL scripts. For example, to run the create_tables.sql script: \i scripts/create_tables.sql

### 7. Practice SQL Queries
Use the SQL scripts in the scripts/queries folder to practice different types of queries. For example:
To run basic queries: \i scripts/queries/basic_queries.sql

### 8. Write and Execute Your Own Queries
Open a new SQL file or edit an existing one (e.g., scripts/queries/basic_queries.sql) and write your SQL queries.
Save the file and execute it using psql: \i scripts/queries/basic_queries.sql