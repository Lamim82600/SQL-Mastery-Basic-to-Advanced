-- SQL_Indexing.sql
-- Guide to MySQL Indexes: B-Tree, Hash, FULLTEXT, SPATIAL

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    description TEXT,
    location POINT SRID 4326  -- For spatial
) ENGINE=InnoDB;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100) UNIQUE  -- Auto index
) ENGINE=MEMORY;

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity, description, location) VALUES
('Laptop Pro', 'Electronics', 999.99, 50, 'High-performance laptop', POINT(40.7, -74.0)),
('Smartphone X', 'Electronics', 699.99, 100, 'Flagship smartphone', POINT(51.5, -0.1)),
('Coffee Maker', 'Appliances', 49.99, 30, 'Drip coffee maker', POINT(35.7, 139.7));

INSERT INTO orders (product_id, customer_id, order_date, quantity) VALUES
(1, 1, '2025-01-10', 2),
(2, 2, '2025-02-15', 1),
(1, 1, '2025-03-01', 3);

INSERT INTO customers VALUES
(1, 'Alice', 'alice@example.com'),
(2, 'Bob', 'bob@example.com');

-- 1. Single-column B-Tree (default)
CREATE INDEX idx_category ON products(category);

-- Query using it
EXPLAIN SELECT * FROM products WHERE category = 'Electronics';

-- 2. Composite B-Tree
CREATE INDEX idx_cat_price ON products(category, price);

-- Optimizes
SELECT * FROM products WHERE category = 'Electronics' AND price < 800;

-- 3. Hash Index (MEMORY engine only)
CREATE INDEX idx_email_hash USING HASH ON customers(email);

-- 4. FULLTEXT Index
ALTER TABLE products ADD FULLTEXT idx_desc (description);

-- Search
SELECT product_name, MATCH(description) AGAINST('laptop') AS score
FROM products
WHERE MATCH(description) AGAINST('laptop');

-- 5. SPATIAL Index
CREATE SPATIAL INDEX idx_location ON products(location);

-- 6. Unique Index (explicit)
CREATE UNIQUE INDEX idx_unique_name ON products(product_name);

-- Exercises
-- Exercise 1: Index for frequent order_date range queries
CREATE INDEX idx_order_date ON orders(order_date);

-- Exercise 2: Composite for customer orders
CREATE INDEX idx_cust_prod ON orders(customer_id, product_id);

-- Exercise 3: FULLTEXT on product_name + description
CREATE FULLTEXT INDEX idx_name_desc ON products(product_name, description);

-- Drop examples
-- DROP INDEX idx_category ON products;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;