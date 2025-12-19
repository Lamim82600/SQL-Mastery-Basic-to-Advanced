-- SQL_GRANT_Operations.sql
-- Guide to MySQL GRANT and Roles

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
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30);

-- Create users
CREATE USER IF NOT EXISTS 'sales'@'localhost' IDENTIFIED BY 'pass';
CREATE USER IF NOT EXISTS 'manager'@'localhost' IDENTIFIED BY 'pass';
CREATE USER IF NOT EXISTS 'inventory'@'localhost' IDENTIFIED BY 'pass';

-- 1. Basic GRANT
GRANT SELECT ON retail_db.products TO 'sales'@'localhost';

GRANT SELECT, INSERT ON retail_db.orders TO 'inventory'@'localhost';

-- 2. Multiple privileges
GRANT SELECT, UPDATE (price, stock_quantity) ON retail_db.products TO 'manager'@'localhost';

-- 3. Database level
GRANT ALL PRIVILEGES ON retail_db.* TO 'manager'@'localhost';

-- 4. Roles
CREATE ROLE 'read_only';
GRANT SELECT ON retail_db.* TO 'read_only';

CREATE ROLE 'order_manager';
GRANT INSERT, UPDATE, DELETE ON retail_db.orders TO 'order_manager';

-- Assign roles
GRANT 'read_only' TO 'sales'@'localhost';
GRANT 'order_manager' TO 'inventory'@'localhost';

-- Activate (user must set)
-- SET ROLE 'read_only';

-- 5. WITH GRANT OPTION
GRANT SELECT ON retail_db.products TO 'manager'@'localhost' WITH GRANT OPTION;

-- Exercises
-- Exercise 1: Grant UPDATE on stock_quantity to inventory
GRANT UPDATE (stock_quantity) ON retail_db.products TO 'inventory'@'localhost';

-- Exercise 2: Create role 'analyst' with SELECT on both tables
CREATE ROLE 'analyst';
GRANT SELECT ON retail_db.products TO 'analyst';
GRANT SELECT ON retail_db.orders TO 'analyst';
GRANT 'analyst' TO 'sales'@'localhost';

-- Flush
FLUSH PRIVILEGES;

-- Cleanup (comment out in practice)
-- DROP USER 'sales'@'localhost', 'manager'@'localhost', 'inventory'@'localhost';
-- DROP ROLE 'read_only', 'order_manager', 'analyst';
-- DROP DATABASE retail_db;