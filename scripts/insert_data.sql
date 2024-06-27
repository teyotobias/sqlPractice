-- INSERT sample data

INSERT INTO customers (name, email) VALUES ('Teyo', 'teyotobias@utexas.edu');
INSERT INTO customers(name, email) VALUES ('Paula', 'paulaturrubiates@hotmail.com');

INSERT INTO orders(customer_id, amount, order_date) VALUES(8, 100.00, '2024-06-01');
INSERT INTO orders(customer_id, amount, order_date) VALUES (9, 150.00, '2024-06-10');