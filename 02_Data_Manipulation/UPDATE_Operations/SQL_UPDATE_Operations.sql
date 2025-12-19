-- SQL_UPDATE_Operations.sql
-- Comprehensive guide to UPDATE statements with examples and exercises

CREATE DATABASE IF NOT EXISTS retail_db;
USE retail_db;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) DEFAULT 'General',
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    last_updated DATE DEFAULT (CURRENT_DATE)
);

-- Sample data
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Laptop Pro', 'Electronics', 999.99, 50),
('Smartphone X', 'Electronics', 699.99, 100),
('Coffee Maker', 'Appliances', 49.99, 30),
('Wireless Headphones', 'Electronics', 89.99, 75),
('Blender', 'Appliances', 39.99, 20),
('Smart TV', 'Electronics', 499.99, 0),
('Microwave Oven', 'Appliances', 79.99, 40);

-- 1. Basic UPDATE (single column)
UPDATE products 
SET price = 949.99 
WHERE product_id = 1;

-- 2. Multiple columns
UPDATE products 
SET price = 79.99, 
    stock_quantity = 90 
WHERE product_name = 'Wireless Headphones';

-- 3. Update with expressions
UPDATE products 
SET stock_quantity = stock_quantity + 20 
WHERE category = 'Appliances';

UPDATE products 
SET price = price * 1.10 
WHERE category = 'Electronics' AND stock_quantity > 0;

-- 4. Update with CASE
UPDATE products 
SET category = CASE
    WHEN price > 500 THEN 'Premium Electronics'
    WHEN category = 'Appliances' THEN 'Kitchen Appliances'
    ELSE category
END;

-- 5. Update all rows (no WHERE)
UPDATE products 
SET last_updated = CURRENT_DATE;

-- 6. Safe UPDATE with LIMIT
UPDATE products 
SET price = price * 0.95 
WHERE category = 'Appliances'
ORDER BY price DESC
LIMIT 2;  -- Discount only the 2 most expensive Appliances

-- Exercises
-- Exercise 1: Increase stock by 50 for products with stock < 30
UPDATE products 
SET stock_quantity = stock_quantity + 50 
WHERE stock_quantity < 30;

-- Exercise 2: Set price to 99.99 and category 'Discounted' for low-stock Electronics
UPDATE products 
SET price = 99.99, category = 'Discounted' 
WHERE category = 'Electronics' AND stock_quantity < 50;

-- Exercise 3: Mark out-of-stock as discontinued via description (add column first)
ALTER TABLE products ADD COLUMN status VARCHAR(20) DEFAULT 'Active';

UPDATE products 
SET status = 'Discontinued' 
WHERE stock_quantity = 0;

-- Combined Exercise: 15% discount on Appliances over $50
UPDATE products 
SET price = ROUND(price * 0.85, 2),
    last_updated = CURRENT_DATE
WHERE category LIKE '%Appliances%' AND price > 50;

-- Cleanup
DROP DATABASE IF EXISTS retail_db;