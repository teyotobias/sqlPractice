-- INSERT sample data

-- ON CONFLICT : in case of duplicate entries.

INSERT INTO customers (name, email) VALUES ('Teyo', 'teyotobias@utexas.edu')
ON CONFLICT (email) DO NOTHING;

INSERT INTO customers(name, email) VALUES ('Paula', 'paulaturrubiates@hotmail.com')
ON CONFLICT (email) DO NOTHING;

INSERT INTO orders(customer_id, amount, order_date) VALUES(8, 100.00, '2024-06-01')
ON CONFLICT (customer_id, order_date) DO NOTHING;

INSERT INTO orders(customer_id, amount, order_date) VALUES (9, 150.00, '2024-06-10')
ON CONFLICT (customer_id, order_date) DO NOTHING;