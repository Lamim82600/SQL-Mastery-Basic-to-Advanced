-- SQL_Views_Operations.sql
-- Guide to MySQL Views

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    order_date DATE DEFAULT (CURRENT_DATE),
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30),
('Wireless Headphones', 'Electronics', 89.99, 75);

INSERT INTO orders (product_id, order_date, quantity) VALUES
(1, '2025-01-10', 2),
(2, '2025-01-15', 1),
(3, '2025-02-01', 3),
(1, '2025-02-20', 1);

-- 1. Simple View
CREATE VIEW electronics_view AS
SELECT product_name, price, stock_quantity
FROM products
WHERE category = 'Electronics';

SELECT * FROM electronics_view;

-- 2. View with JOIN
CREATE VIEW order_details AS
SELECT 
    o.order_id,
    p.product_name,
    o.quantity,
    o.quantity * p.price AS total_value
FROM orders o
JOIN products p ON o.product_id = p.product_id;

SELECT * FROM order_details;

-- 3. Updatable View
CREATE VIEW low_stock AS
SELECT product_id, product_name, stock_quantity
FROM products
WHERE stock_quantity < 50;

-- Update via view
UPDATE low_stock SET stock_quantity = stock_quantity + 20 WHERE product_id = 3;

-- 4. View with aggregation
CREATE VIEW sales_summary AS
SELECT 
    p.category,
    COUNT(o.order_id) AS orders_count,
    SUM(o.quantity) AS total_qty,
    SUM(o.quantity * p.price) AS revenue
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.category;

SELECT * FROM sales_summary;

-- 5. ALTER VIEW
ALTER VIEW electronics_view AS
SELECT product_name, price
FROM products
WHERE category = 'Electronics' AND price > 500;

SELECT * FROM electronics_view;

-- 6. DROP VIEW
DROP VIEW IF EXISTS electronics_view;
DROP VIEW IF EXISTS order_details;
DROP VIEW IF EXISTS low_stock;
DROP VIEW IF EXISTS sales_summary;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;