-- SQL_DELETE_Operations.sql
-- Comprehensive guide to DELETE statements with examples and exercises

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- Tables with relationships
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
        ON DELETE CASCADE  -- Important for demo
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30),
('Wireless Headphones', 'Electronics', 89.99, 75),
('Blender', 'Appliances', 39.99, 0),
('Smart TV', 'Electronics', 499.99, 0),
('Microwave Oven', 'Appliances', 79.99, 40);

INSERT INTO orders (product_id, quantity) VALUES
(1, 2), (2, 1), (3, 3), (1, 1), (4, 5);

-- 1. Basic DELETE with WHERE
DELETE FROM products
WHERE stock_quantity = 0;
-- Deletes Blender and Smart TV

-- 2. DELETE with multiple conditions
DELETE FROM products
WHERE category = 'Appliances' AND price < 60;
-- Deletes Coffee Maker

-- 3. DELETE using subquery
DELETE FROM products
WHERE product_id IN (
    SELECT product_id
    FROM orders
    GROUP BY product_id
    HAVING SUM(quantity) < 2
);
-- Example: removes rarely ordered products

-- 4. DELETE with LIMIT (MySQL specific - for safety)
DELETE FROM products
WHERE category = 'Electronics'
ORDER BY price ASC
LIMIT 1;
-- Deletes cheapest Electronics product

-- 5. Cascading DELETE (via FK ON DELETE CASCADE)
DELETE FROM products
WHERE product_id = 1;
-- Also deletes related orders automatically

-- 6. Delete all rows
DELETE FROM products;
-- Removes every row (structure remains)

-- Alternative: TRUNCATE (faster, resets AUTO_INCREMENT)
TRUNCATE TABLE products;

-- Exercises
-- Exercise 1: Delete all products with price > 800
DELETE FROM products WHERE price > 800;

-- Exercise 2: Delete orders-related products with zero stock
DELETE FROM products
WHERE stock_quantity = 0
  AND product_id IN (SELECT product_id FROM orders);

-- Exercise 3: Safely delete oldest 2 products (by product_id)
DELETE FROM products
ORDER BY product_id ASC
LIMIT 2;

-- Combined Exercise: Clean low performers
DELETE FROM products
WHERE stock_quantity < 10
   OR product_id NOT IN (SELECT product_id FROM orders WHERE order_date > '2025-01-01');

-- Cleanup
DROP DATABASE IF EXISTS retail_db;