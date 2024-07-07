-- INSERT sample data

-- ON CONFLICT : in case of duplicate entries.

INSERT INTO customers (name, email) VALUES ('Teyo', 'teyotobias@utexas.edu')
ON CONFLICT (email) DO NOTHING;

INSERT INTO customers(name, email) VALUES ('Paula', 'paulaturrubiates@hotmail.com')
ON CONFLICT (email) DO NOTHING;
