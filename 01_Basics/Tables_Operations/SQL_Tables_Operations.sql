-- SQL Tables Operations: Comprehensive Examples

-- Create Database Safely
CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

-- 1. CREATE TABLE
-- Basic table with realistic constraints
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) DEFAULT 0.00,
    stock_quantity INT DEFAULT 0,
    launch_date DATE
);

-- Supporting table for foreign key demo
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE
);

-- Add foreign key to products
ALTER TABLE products ADD COLUMN supplier_id INT;
ALTER TABLE products ADD CONSTRAINT fk_supplier
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
    ON DELETE SET NULL;

-- CREATE TABLE ... LIKE (copy structure)
CREATE TABLE products_backup LIKE products;

-- CREATE TABLE ... AS SELECT (copy structure + data)
CREATE TABLE expensive_products AS
SELECT * FROM products WHERE price > 500.00;

-- Customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15)
);

-- 2. ALTER TABLE
-- Add column
ALTER TABLE products ADD COLUMN rating DECIMAL(3,1) DEFAULT 0.0;

-- Modify column
ALTER TABLE products MODIFY COLUMN price DECIMAL(12,2);

-- Drop column
ALTER TABLE products DROP COLUMN launch_date;

-- Rename column (MySQL 8.0+)
ALTER TABLE products RENAME COLUMN rating TO avg_rating;

-- Rename table
RENAME TABLE products_backup TO products_archive;

-- 3. DROP TABLE
DROP TABLE IF EXISTS expensive_products;
DROP TABLE IF EXISTS products_archive;
DROP TABLE IF EXISTS suppliers;  -- Cascades if needed

-- 4. TRUNCATE TABLE
-- Insert sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30);

-- Truncate removes all rows
TRUNCATE TABLE products;

-- Combined Example: Orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    order_date DATE DEFAULT (CURRENT_DATE),
    quantity INT DEFAULT 1,
    status VARCHAR(20) DEFAULT 'Pending',
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Modify and truncate
ALTER TABLE orders ADD COLUMN customer_id INT;
TRUNCATE TABLE orders;

-- Cleanup (optional)
DROP TABLE IF EXISTS orders, customers, products;