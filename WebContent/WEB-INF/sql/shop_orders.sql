DROP TABLE IF EXISTS orders, order_details;

CREATE TABLE IF NOT EXISTS orders(
	order_id SERIAL PRIMARY KEY,
	delivery_name VARCHAR(127),
	delivery_address VARCHAR(127),
	cc_name VARCHAR(127),
	cc_number VARCHAR(32),
	cc_expiry VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS order_details(
	id SERIAL PRIMARY KEY,
	book_id INT,
	title VARCHAR(127),
	author VARCHAR(127),
	quantity INT,
	price NUMERIC(6,2),
	order_id INT REFERENCES orders(order_id)
);