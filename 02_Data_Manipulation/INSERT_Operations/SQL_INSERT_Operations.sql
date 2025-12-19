-- SQL_INSERT_Operations.sql
-- Comprehensive guide to INSERT statements with examples and exercises

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- Tables
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) DEFAULT 'General',
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    added_date DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE product_archive (
    archive_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2),
    archived_date DATE DEFAULT (CURRENT_DATE)
);

-- Initial sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30);

-- 1. Single Row INSERT
INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('Wireless Headphones', 'Electronics', 89.99, 75);

-- Omitting columns (uses defaults)
INSERT INTO products (product_name, price)
VALUES ('Tablet', 299.99);

-- 2. Multiple Row INSERT
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Smart TV', 'Electronics', 499.99, 15),
('Microwave Oven', 'Appliances', 79.99, 40),
('Gaming Console', 'Electronics', 399.99, 60),
('Toaster', 'Appliances', 29.99, 25);

-- 3. INSERT with SELECT
-- Archive low-stock items
INSERT INTO product_archive (product_name, category, price)
SELECT product_name, category, price
FROM products
WHERE stock_quantity < 20;

-- Archive high-price items with current date
INSERT INTO product_archive (product_name, category, price, archived_date)
SELECT product_name, category, price, CURDATE()
FROM products
WHERE price > 500;

-- 4. INSERT IGNORE (skip errors, e.g., duplicate PK)
INSERT IGNORE INTO products (product_id, product_name, price)
VALUES (1, 'Duplicate Attempt', 100.00);  -- Ignored due to PK conflict

-- 5. INSERT ... ON DUPLICATE KEY UPDATE
INSERT INTO products (product_id, product_name, price, stock_quantity)
VALUES (1, 'Laptop Pro Updated', 1099.99, 60)
ON DUPLICATE KEY UPDATE
    price = VALUES(price),
    stock_quantity = VALUES(stock_quantity);

-- Exercises
-- Exercise 1: Insert a single product 'Blender' (Appliances, 39.99, stock 35)
INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('Blender', 'Appliances', 39.99, 35);

-- Exercise 2: Insert three new books (category 'Books')
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('SQL Mastery', 'Books', 49.99, 200),
('Database Design', 'Books', 59.99, 150),
('Advanced Queries', 'Books', 69.99, 100);

-- Exercise 3: Archive all Electronics products priced under 100
INSERT INTO product_archive (product_name, category, price)
SELECT product_name, category, price
FROM products
WHERE category = 'Electronics' AND price < 100;

-- Combined Exercise
-- Add a premium product, then archive all items with stock < 30
INSERT INTO products (product_name, category, price, stock_quantity)
VALUES ('Premium Speaker', 'Electronics', 799.99, 20);

INSERT INTO product_archive (product_name, category, price)
SELECT product_name, category, price
FROM products
WHERE stock_quantity < 30;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;