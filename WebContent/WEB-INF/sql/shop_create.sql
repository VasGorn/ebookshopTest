--DROP DATABASE shop;
--CREATE DATABASE shop;
DROP TABLE IF EXISTS books, categories;

CREATE TABLE IF NOT EXISTS categories(
	category_id SERIAL PRIMARY KEY,
	category_name VARCHAR(127)
);

CREATE TABLE IF NOT EXISTS books(
	book_id SERIAL PRIMARY KEY,
	title VARCHAR(127),
	author VARCHAR(127),
	price NUMERIC(5,2),
	category_id INT REFERENCES categories(category_id)
);
